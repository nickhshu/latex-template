# AGENTS.md

## LaTeX

Whenever you are working with LaTeX files in this project, follow the instructions in this section.

### Compilation

- Compile any LaTeX file by running `latexmk path/to/file.tex` from the project root, which makes sure `latexmk` reads configurations in `.latexmkrc`.

### Text

- Put each sentence on a new line.

### Float Objects (Figures, Tables, etc.)

- Use `tp` for placement.
- Use package `tabularray` with its `booktabs` library for tables. Both should already be loaded.

### Equations

Follow the following rules for mathematical equations.

- Use `\(`, `\)`, `\[`, and `\]` to delimit equations.
- Use `\ne`, `\le`, and `\ge` instead of `\neq`, `\leq`, and `\geq`.
- Use `\dotsb`, `\dotsc`, etc., instead of `\ldots` and `\cdots` in equations.
