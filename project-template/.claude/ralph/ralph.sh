#!/bin/bash
#
# Ralph: Autonomous Agent Loop for Claude Code
#
# Based on Geoffrey Huntley's Ralph Wiggum pattern
# Adapted for Claude Code Project Starter
#
# Usage: ./ralph.sh [max_iterations] [timeout_minutes]
# Example: ./ralph.sh 25 15
#

set -e

# Configuration
MAX_ITERATIONS=${1:-10}
TIMEOUT_MINUTES=${2:-15}
TIMEOUT_SECONDS=$((TIMEOUT_MINUTES * 60))
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Circuit breaker settings
NO_CHANGE_LIMIT=3
SAME_ERROR_LIMIT=5

# State tracking
no_change_count=0
last_error=""
same_error_count=0
last_git_hash=""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check dependencies
check_dependencies() {
    if ! command -v claude &> /dev/null; then
        log_error "Claude Code CLI not found. Install with: npm install -g @anthropic-ai/claude-code"
        exit 1
    fi

    if ! command -v jq &> /dev/null; then
        log_error "jq not found. Install with: sudo apt install jq (Linux) or brew install jq (macOS)"
        exit 1
    fi

    if [ ! -f "$SCRIPT_DIR/prd.json" ]; then
        log_error "prd.json not found. Run /ralph-init first to generate it."
        exit 1
    fi

    if [ ! -f "$SCRIPT_DIR/PROMPT.md" ]; then
        log_error "PROMPT.md not found in $SCRIPT_DIR"
        exit 1
    fi
}

# Check if all stories are complete
all_stories_complete() {
    local incomplete=$(jq '[.userStories[] | select(.passes == false)] | length' "$SCRIPT_DIR/prd.json")
    [ "$incomplete" -eq 0 ]
}

# Get current incomplete story count
get_incomplete_count() {
    jq '[.userStories[] | select(.passes == false)] | length' "$SCRIPT_DIR/prd.json"
}

# Get current git hash
get_git_hash() {
    git -C "$PROJECT_ROOT" rev-parse HEAD 2>/dev/null || echo "no-git"
}

# Check if git has changes since last iteration
check_for_changes() {
    local current_hash=$(get_git_hash)

    if [ "$current_hash" = "$last_git_hash" ]; then
        ((no_change_count++))
        log_warn "No git changes detected (${no_change_count}/${NO_CHANGE_LIMIT})"
        return 1
    else
        no_change_count=0
        last_git_hash=$current_hash
        return 0
    fi
}

# Circuit breaker check
circuit_breaker_check() {
    if [ $no_change_count -ge $NO_CHANGE_LIMIT ]; then
        log_error "Circuit breaker: No changes in $NO_CHANGE_LIMIT iterations"
        log_error "Ralph may be stuck. Check prd.json for impossible tasks."
        return 1
    fi

    if [ $same_error_count -ge $SAME_ERROR_LIMIT ]; then
        log_error "Circuit breaker: Same error repeated $SAME_ERROR_LIMIT times"
        log_error "Check progress.txt for error patterns."
        return 1
    fi

    return 0
}

# Cost awareness messaging
cost_warning() {
    local iteration=$1

    if [ $iteration -eq 25 ]; then
        log_warn "25 iterations reached. Estimated cost: \$15-40"
    elif [ $iteration -eq 50 ]; then
        log_warn "50 iterations reached. Estimated cost: \$30-100"
    elif [ $iteration -eq 75 ]; then
        log_warn "75 iterations reached. Estimated cost: \$50-150"
        log_warn "Consider stopping and reviewing progress."
    fi
}

# Display status
show_status() {
    local iteration=$1
    local incomplete=$(get_incomplete_count)
    local total=$(jq '.userStories | length' "$SCRIPT_DIR/prd.json")
    local complete=$((total - incomplete))

    echo ""
    echo "═══════════════════════════════════════════════════════"
    echo "  RALPH ITERATION $iteration of $MAX_ITERATIONS"
    echo "  Stories: $complete/$total complete"
    echo "  Remaining: $incomplete"
    echo "═══════════════════════════════════════════════════════"
    echo ""
}

# Main loop
main() {
    log_info "Starting Ralph autonomous loop"
    log_info "Max iterations: $MAX_ITERATIONS"
    log_info "Timeout per iteration: $TIMEOUT_MINUTES minutes"
    log_info "Project root: $PROJECT_ROOT"
    echo ""

    check_dependencies

    # Initial git hash
    last_git_hash=$(get_git_hash)

    # Check if already complete
    if all_stories_complete; then
        log_success "All stories already complete!"
        exit 0
    fi

    # Main loop
    for i in $(seq 1 $MAX_ITERATIONS); do
        show_status $i
        cost_warning $i

        # Circuit breaker check
        if ! circuit_breaker_check; then
            log_error "Stopping due to circuit breaker"
            exit 1
        fi

        # Run Claude Code with PROMPT.md
        log_info "Spawning Claude Code instance..."

        # Capture output while also displaying it
        OUTPUT=$(timeout "${TIMEOUT_SECONDS}s" claude --dangerously-skip-permissions \
            -p "$(cat "$SCRIPT_DIR/PROMPT.md")" 2>&1 \
            | tee /dev/stderr) || {
            exit_code=$?
            if [ $exit_code -eq 124 ]; then
                log_warn "Iteration timed out after $TIMEOUT_MINUTES minutes"
            else
                log_warn "Claude exited with code $exit_code"
            fi
        }

        # Check for completion signal
        if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then
            log_success "Ralph received completion signal!"
            log_success "All stories complete!"

            # Final status
            echo ""
            echo "═══════════════════════════════════════════════════════"
            echo "  RALPH COMPLETE"
            echo "  Total iterations: $i"
            echo "  Check progress.txt for learnings"
            echo "═══════════════════════════════════════════════════════"

            exit 0
        fi

        # Check for changes
        check_for_changes || true

        # Check if all stories complete (in case signal was missed)
        if all_stories_complete; then
            log_success "All stories marked complete in prd.json"
            exit 0
        fi

        # Brief pause between iterations
        log_info "Iteration $i complete. Pausing before next iteration..."
        sleep 2
    done

    # Max iterations reached
    log_warn "Max iterations ($MAX_ITERATIONS) reached"
    log_warn "Ralph stopped. Review progress.txt and prd.json."

    local incomplete=$(get_incomplete_count)
    log_warn "$incomplete stories still incomplete"

    exit 1
}

# Handle interrupts gracefully
trap 'log_warn "Ralph interrupted. Progress saved in prd.json and progress.txt."; exit 130' INT TERM

# Run
main
