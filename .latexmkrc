# Use LuaLaTeX
$pdf_mode = 4;

# Compilers options
set_tex_cmds("-synctex=1 -halt-on-error -file-line-error %O %S");

# Change to the parent directory before processing the document
$do_cd = 1;

# Put auxiliary files into directory `aux`
# This might can be overwritten by `no-aux.latexmkrc`
$aux_dir = "aux";
$emulate_aux = 1;

# Clean `.bbl` files
$bibtex_use = 2;

# Clean `.run.xml` files
$clean_ext = "%R.run.xml";
