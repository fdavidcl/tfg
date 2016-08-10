CHAPTERS=$(basename $(wildcard chapters/*.md))
CHAP_TEX=$(addsuffix .tex, $(CHAPTERS))
TEMPLATE=default.latex

all: doc.pdf

clean:
	rm -f *.tex *.pdf

doc.pdf: doc.md $(CHAP_TEX) $(TEMPLATE)
	pandoc $< -o $@ --filter pandoc-citeproc --template $(TEMPLATE) --latex-engine xelatex

%.tex: %.md
	pandoc $< -o $@ --filter pandoc-citeproc
