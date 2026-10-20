.PHONY: all data simulations caseStudy manuscript figures main.pdf clean

all: data simulations caseStudy manuscript

## Analysis targets

data:
	R CMD BATCH --no-restore --no-save make_data.R

simulations:
	R CMD BATCH --no-restore --no-save make_simulations.R

caseStudy:
	R CMD BATCH --no-restore --no-save make_caseStudy.R

## Manuscript targets

manuscript:
	$(MAKE) figures
	$(MAKE) main.pdf

figures:
	R CMD BATCH --no-restore --no-save manuscript/figs/make_figures.R

## The manuscript (LTJournalArticle class) uses biblatex with the biber backend.
## biber must match the installed biblatex version: the copy in ~/bin is used
## when present, override with e.g. `make main.pdf BIBER=biber`.
BIBER ?= $(shell if [ -x "$(HOME)/bin/biber" ]; then echo "$(HOME)/bin/biber"; else echo biber; fi)
LATEX = pdflatex -interaction=nonstopmode -halt-on-error

main.pdf:
	cd manuscript && $(LATEX) main.tex
	cd manuscript && $(BIBER) main
	cd manuscript && $(LATEX) main.tex
	cd manuscript && $(LATEX) main.tex
	$(MAKE) clean

## Cleaning artefacts

## Only LaTeX artefacts in manuscript/ are removed: the project root
## holds a large .RData workspace that must not be deleted.
clean:
	@find manuscript -type f \( -name "*.aux" -o -name "*.log" -o -name "*-blx.bib" -o -name "*.run.xml" -o -name "*.bcf" -o -name "*.out" -o -name "*.suppinfo" -o -name "*.toc" -o -name "*.lof" -o -name "*.lot" -o -name "*.bbl" -o -name "*.blg" -o -name "*.synctex.gz" -o -name "*.fls" -o -name "*.fdb_latexmk" \) -exec rm -rf {} \;
	@rm -f manuscript/Rplots.pdf Rplots.pdf
