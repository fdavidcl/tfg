CHAPTERS=$(basename $(wildcard chapters/*.md))
CHAP_TEX=$(addsuffix .tex, $(CHAPTERS))
TEMPLATE=default.latex
BIB=bibliography.bib
CSL=iso690-author-date-es.csl

PANDOC_FLAGS = --bibliography $(BIB) --biblatex

all: doc.pdf

clean:
	rm -f chapters/*.tex *.pdf

doc.pdf: doc.md $(CHAP_TEX) $(TEMPLATE) config.tex
	pandoc $< -o $@ --filter pandoc-citeproc $(PANDOC_FLAGS) --template $(TEMPLATE) --latex-engine xelatex

%.tex: %.md $(BIB) $(CSL)
	pandoc $< -o $@ --filter pandoc-citeproc $(PANDOC_FLAGS)
