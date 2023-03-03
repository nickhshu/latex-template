# Use this Makefile only when lwarp is needed.
# Even when in that case, it is recommended to write normally first.

pdf_only_target =
html_target =

# --------------------------------------------------------------------

.PHONY: all
all:
	@echo 'Use target names'

latexmk_pdf_only := latexmk -silent -pdf -auxdir=aux -emulate-aux-dir
latexmk_lwarp := latexmk -silent -pdf

.PHONY: $(pdf_only_target)
$(pdf_only_target): $(pdf_only_target).pdf

$(pdf_only_target): $(pdf_only_target).tex macros.tex
	$(latexmk_pdf_only) $(pdf_only_target).tex

.PHONY: $(html_target)
$(html_target): $(html_target).pdf $(html_target).html

$(html_target).pdf $(html_target)_html.tex: $(html_target).tex macros.tex
	$(latexmk_lwarp) $(html_target).tex

$(html_target)_html.pdf: $(html_target)_html.tex
	$(latexmk_lwarp) $(html_target)_html.tex

$(html_target).html: $(html_target)_html.pdf
	lwarpmk pdftohtml $(html_target)_html.pdf

.PHONY: clean
clean:
	latexmk -c
	rm -rf aux
	rm -f *.run.xml
	lwarpmk clean
	rm -f *_html.tex
	rm -f lwarp_formal.css lwarp_sagebrush.css sample_project.css
	rm -f *-images.txt
	rm -f lwarp.xdy lwarp.ist
	rm -f lwarp_*.txt
	rm -f *.lwarpmkconf

.PHONY: clean_all
clean_all:
	latexmk -C
	lwarpmk cleanall
	rm -f lwarp.css
	rm -f lwarpmk.conf
# removing `lwarpmk.conf` will cause `lwarpmk clean` to fail
