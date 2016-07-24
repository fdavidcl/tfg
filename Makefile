CHAPTERS=$(basename $(wildcard chapters/*.md))
CHAP_TEX=$(addsuffix .tex, $(CHAPTERS))

all: doc.pdf

clean:
	rm -f *.tex *.pdf

doc.pdf: doc.md $(CHAP_TEX) default.latex
	pandoc $< -o $@ --filter pandoc-citeproc --template default.latex --latex-engine xelatex

%.tex: %.md
	pandoc $< -o $@ --filter pandoc-citeproc
