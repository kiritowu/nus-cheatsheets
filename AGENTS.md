# AGENTS.md

This file provides guidance to AGENTS when working with code in this repository.

## What this repo is

A personal collection of NUS exam cheatsheets authored in [Typst](https://typst.app/), compiled to PDF. Currently covers:

- **MA1522** (Linear Algebra for Computing) — midterm and final
- **CS2100** (Computer Organisation) — midterm and final, each split into a main doc, appendix, and (for final) a templates doc

## Building

Compile any `.typ` file to PDF with Typst:

```sh
# Compile a single file
typst compile CS2100/midterm/cs2100-midterm-main.typ

# Watch and recompile on save
typst watch CS2100/midterm/cs2100-midterm-main.typ
```

Install Typst via `cargo install typst-cli` or from [typst.app](https://typst.app/). Alternatively, use the Typst web app to edit and compile online.

There is no lint or test step.

## Architecture

### Shared layout via `*-common.typ`

CS2100 cheatsheets use a shared common file per exam period:

- `CS2100/midterm/cs2100-midterm-common.typ` — imports packages, sets fonts, and defines a pre-configured `cheatsheet-layout` function
- `CS2100/final/cs2100-final-common.typ` — same pattern for final

Each document (`*-main.typ`, `*-appendix.typ`, `*-templates.typ`) starts with `#import "cs2100-*-common.typ": *` then `#show: cheatsheet-layout` to apply the layout. MA1522 cheatsheets inline their layout config directly (no shared common file).

### Typst packages used

- `@preview/boxed-sheet:0.1.0` — provides the `cheatsheet` layout function and `concept-block`, `inline`, and other content primitives
- `@preview/muchpdf:0.1.0` — embeds external PDF pages (used for image assets)

### Assets

PNG images and PDF assets live under each module's folder, organized by topic (e.g., `CS2100/midterm/Cache/`, `CS2100/final/Pipeline/`). They are referenced directly from `.typ` source files.

## README structure

`README.md` uses a single HTML `<table>` under the **Table of Contents** section to list all cheatsheets. Rows are grouped by semester using `rowspan` on the first `<td>`. Within each semester group, each row has:

- **Module** — full module code + name (e.g., `MA1522 Linear Algebra for Computing`)
- **Cheatsheets** — an unordered list of `<a href="...">` links pointing to the compiled PDF files

When adding a new module, add a new `<tr>` (with a `rowspan` matching the number of modules in that semester on the semester cell) and a nested `<tr>` per additional module in the same semester. When adding a new semester, add a new semester group with `rowspan` set to the number of modules in it.

Semesters are listed in chronological order (e.g., AY25/26 Sem 1, then AY25/26 Sem 2).
