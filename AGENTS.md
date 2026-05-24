# AGENTS.md

## LaTeX

Instructions in this section apply to all LaTeX files in this project.

### Compilation

- Compile any LaTeX file by running `latexmk path/to/file.tex` from the project root, which makes sure `latexmk` reads configurations in `.latexmkrc`.

### Writing

- Put each sentence on a new line.
- Use `\(`, `\)`, `\[`, and `\]` for equations.
- Use `tp` for placement of figures, tables, etc.
- Use package `tabularray` with its `booktabs` library for tables.
  Both should already be loaded in the preamble.
