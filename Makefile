CHAPTERS=$(basename $(wildcard chapters/*.md))
CHAP_TEX=$(addsuffix .tex, $(CHAPTERS))
TEMPLATE=default.latex
BIB=bibliography.bib

PANDOC_FLAGS = --bibliography $(BIB) --csl ieee.csl

all: doc.pdf

clean:
	rm -f *.tex *.pdf

doc.pdf: doc.md $(CHAP_TEX) $(TEMPLATE)
	pandoc $< -o $@ --filter pandoc-citeproc $(PANDOC_FLAGS) --template $(TEMPLATE) --latex-engine xelatex

%.tex: %.md $(BIB)
	pandoc $< -o $@ --filter pandoc-citeproc $(PANDOC_FLAGS)
