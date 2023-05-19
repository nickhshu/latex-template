# WARNING:
# This Makefile not thoroughly tested. Use only for multifile projects with
# complex dependencies. Otherwise, the VS Code intergration is good enough.
# Even when this Makefile is needed, use VS Code during the first writing.

# LIMITATIONS:
# Compiling and cleaning LaTeX files within subdirectories is not yet
# supported. Compiling can be done by specifying `-out_dir` or `cd`ing into the
# directory. However, cleaning is harder to support.
#
# Adding the `-cd` flag to `latexmk` should solve most of the problem. However,
# this has not been tested, and this does not cover HTML and PNG generation
# anyway.

# --------------------------------------------------------------------

# Simple targets that only relies on the `.tex` file itself and `macros.tex`
# Do not add extension names for these
pdf_only_targets =
html_targets =
png_targets_tp_bg =
png_targets_white_bg =

# Rules for special targets, scuh as PDFs that relies on figures, need to be
# specified mannually. Also remember to add them to `all`.
special_targets :=

# --------------------------------------------------------------------

# HTML targets should not be compiled with `-auxdir`
non_html_targets = $(pdf_only_targets) $(png_targets_white_bg) \
	$(png_targets_tp_bg)
pdfs_non_html = $(addsuffix .pdf, $(non_html_targets))
pdfs_pdf_only = $(addsuffix .pdf, $(pdf_only_targets))

pdfs_html = $(addsuffix .pdf, $(html_targets))
_html.texs = $(addsuffix _html.tex, $(html_targets))
_html.pdfs = $(addsuffix _html.pdf, $(html_targets))
htmls = $(addsuffix .html, $(html_targets))

pngs_tp_bg = $(addsuffix .png, $(png_targets_tp_bg))
pngs_white_bg = $(addsuffix .png, $(png_targets_white_bg))
pngs = $(pngs_tp_bg) $(pngs_white_bg)

latexmk_no_auxdir = latexmk -auxdir= -noemulate-aux-dir
latexmk_with_auxdir = latexmk

magick = magick -density 300 -quality 90
magick_white_bg_opts = -background white -alpha remove -alpha off

.DELETE_ON_ERROR:
.PHONY: all
all: $(pdfs_pdf_only) $(htmls) $(pngs)

.PHONY: FORCE
FORCE:

$(pdfs_non_html): %.pdf: FORCE
	$(latexmk_with_auxdir) $*.tex

$(_html.texs): %_html.tex: FORCE
	$(latexmk_no_auxdir) $*.tex

$(_html.pdfs): %_html.pdf: FORCE
	$(latexmk_no_auxdir) $*_html.tex

$(htmls): %.html: %_html.pdf
	lwarpmk pdftohtml $<

$(pngs_tp_bg): %.png: %.pdf
	$(magick) $< $@

$(pngs_white_bg): %.png: %.pdf
	$(magick) $< $(magick_white_bg_opts) $@

.PHONY: clean
clean:
	$(latexmk_no_auxdir) -c
	$(latexmk_with_auxdir) -c
	rm -rf aux
	rm -f *.run.xml
	-lwarpmk clean
	rm -f *_html.tex
	rm -f lwarp_formal.css lwarp_sagebrush.css sample_project.css
	rm -f *-images.txt
	rm -f lwarp.xdy lwarp.ist
	rm -f lwarp_*.txt
	rm -f *.lwarpmkconf

.PHONY: clean_all
clean_all: clean
	$(latexmk_no_auxdir) -C
	$(latexmk_with_auxdir) -C
	rm -f *.synctex.gz
	rm -f $(pngs)
	-lwarpmk cleanall
	rm -f lwarp.css
	rm -f lwarpmk.conf
