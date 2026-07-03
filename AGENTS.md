# AGENTS.md

## LaTeX

Whenever you are working with LaTeX files in this project, follow the instructions in this section.

### Compilation

- When I ask you to edit a LaTeX document, do not compile it unless I explicitly request it.
- Whenever you compile a LaTeX file, you should run `latexmk path/to/file.tex` from the project root. This makes sure `latexmk` reads configurations in `.latexmkrc`.

### Text

- Put each sentence on a new line.

### Float Objects (Figures, Tables, etc.)

- Use `tp` for placement.
- Use package `tabularray` with its `booktabs` library for tables. Both should already be loaded.

### Equations

- Use `\(`, `\)`, `\[`, and `\]` to delimit equations.
- Use `\ne`, `\le`, and `\ge` instead of `\neq`, `\leq`, and `\geq`.
