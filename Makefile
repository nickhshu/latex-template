# WARNING:
# This Makefile not thoroughly tested. Use only for multifile projects with
# complex dependencies. Otherwise, a simpile invokation of `latexmk doc.tex`
# (as well as `latexmk -C` and `latexmk -c`) should be enough.

# LIMITATIONS:
# Cleaning LaTeX files within subdirectories is not well supported. It should
# work fine for simple LaTeX documents. However, for HTML and PNG generation,
# the cleaning target cannot find auxiliary files in subdirectories. A
# potential (yet imperfect) solution is to ask `latexmk` to clean them.

# --------------------------------------------------------------------
# Do not add extension names
pdf_only_targets =

# HTML and PNG generation are experimental. Use with caution.
html_targets =
png_targets_tp_bg =
png_targets_white_bg =

# Rules for special targets (e.g., PDFs that relies on figures) need to be
# specified mannually.
special_targets :=

# --------------------------------------------------------------------
# Do not modify below this line.

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
