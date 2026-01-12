---
name: blob-converter
description: Convert binary files (PDFs, DOCX, PPTX) to Markdown for better AI processing
triggers: [convert to markdown, convert pdf, convert document, make readable, blob to markdown, pdf to md]
---

# Blob Converter Skill

## Purpose

Convert "blob" files (PDFs, Word documents, PowerPoint slides) into **Markdown** format. LLMs are specifically trained to read and write Markdown, making it significantly more token-efficient and accurate than raw binary formats.

> "Convert all blob files (PDFs, Docx, PPTX) into Markdown. LLMs are specifically trained to read and write Markdown, making it significantly more token-efficient and accurate than raw PDFs."

## Why Convert?

| Format | Issue | After Conversion |
|--------|-------|------------------|
| PDF | Complex parsing, layout issues, high token use | Clean text, structured headers |
| DOCX | Binary format, embedded styles | Pure content, markdown formatting |
| PPTX | Slide-by-slide complexity | Linear document, clear sections |

**Token Efficiency**: A 10-page PDF might use 15K tokens as raw text but only 5K as cleaned Markdown.

## Supported Formats

| Input | Tool | Output |
|-------|------|--------|
| `.pdf` | `pdftotext` or `pandoc` | `.md` |
| `.docx` | `pandoc` | `.md` |
| `.doc` | `pandoc` (via LibreOffice) | `.md` |
| `.pptx` | `pandoc` | `.md` |
| `.rtf` | `pandoc` | `.md` |
| `.odt` | `pandoc` | `.md` |

## Prerequisites

Install conversion tools:

```bash
# macOS
brew install pandoc poppler

# Ubuntu/Debian
sudo apt-get install pandoc poppler-utils

# Check installation
pandoc --version
pdftotext -v
```

## Workflow

### Step 1: Identify File Type

```bash
file [filename]
```

### Step 2: Choose Conversion Method

**For PDFs**:
```bash
# Simple text extraction (fast)
pdftotext input.pdf output.txt

# With layout preservation
pdftotext -layout input.pdf output.txt

# To Markdown via pandoc
pandoc input.pdf -o output.md
```

**For Word Documents**:
```bash
pandoc input.docx -o output.md --wrap=none
```

**For PowerPoint**:
```bash
pandoc input.pptx -o output.md
```

### Step 3: Clean Up Output

After conversion, clean the Markdown:
- Remove excessive blank lines
- Fix heading hierarchy
- Convert bullet formatting
- Remove page numbers/headers
- Fix table formatting

### Step 4: Organize

Place converted files in a standard location:
```
docs/
├── source/          # Original blob files
│   └── report.pdf
└── converted/       # Markdown versions
    └── report.md
```

## Output Format

Converted files should have:

```markdown
# Document Title

**Source**: [original filename]
**Converted**: [date]
**Pages**: [if applicable]

---

[Document content in clean Markdown]

## Section Heading

[Content...]

### Subsection

[Content...]

---

*Converted from [format] using [tool]*
```

## Example

**Input**: "Convert this requirements PDF to markdown"

**Process**:
1. Check if pandoc/pdftotext available
2. Run conversion
3. Clean up output
4. Return clean Markdown

**Commands**:
```bash
# Convert
pdftotext -layout requirements.pdf requirements.txt

# Or with pandoc for better structure
pandoc requirements.pdf -o requirements.md --wrap=none
```

**Before (PDF extracted raw)**:
```
                    REQUIREMENTS DOCUMENT

  1.0   Introduction

The system shall provide...     Page 1 of 15

  1.1   Scope

This document covers...
```

**After (Clean Markdown)**:
```markdown
# Requirements Document

## 1.0 Introduction

The system shall provide...

## 1.1 Scope

This document covers...
```

## Handling Complex Documents

### Tables
```bash
# Pandoc handles tables better
pandoc input.pdf -o output.md --extract-media=./media
```

### Images
```bash
# Extract images separately
pdfimages input.pdf images/prefix

# Or with pandoc
pandoc input.pdf -o output.md --extract-media=./media
```

### Multi-column layouts
```bash
# Use layout preservation
pdftotext -layout input.pdf output.txt
# Then manually restructure
```

## Batch Conversion

For multiple files:

```bash
# Convert all PDFs in a directory
for f in *.pdf; do
  pandoc "$f" -o "${f%.pdf}.md"
done

# Convert all DOCX files
for f in *.docx; do
  pandoc "$f" -o "${f%.docx}.md" --wrap=none
done
```

## Quality Checklist

After conversion, verify:

- [ ] Headings are properly hierarchical (H1 → H2 → H3)
- [ ] Lists are formatted correctly
- [ ] Tables are readable
- [ ] No garbled characters
- [ ] Code blocks preserved (if any)
- [ ] Links are functional
- [ ] No layout artifacts (page numbers in wrong places)

## When Manual Cleanup Is Needed

- Scanned PDFs (need OCR first)
- Complex multi-column layouts
- Heavy use of graphics/diagrams
- Mathematical formulas (may need LaTeX)
- Forms with fillable fields

## Integration with Project

Once converted, reference in CLAUDE.md:

```markdown
## Project Documentation

Converted from source documents:
- `docs/converted/requirements.md` (from requirements.pdf)
- `docs/converted/architecture.md` (from architecture.docx)
```

---

*This skill ensures all project knowledge is in the most AI-friendly format.*
