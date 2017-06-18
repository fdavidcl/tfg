CHAPTERS=$(wildcard chapters/*.tex)
DOC=memoria.pdf
BIB=bibtex
TEX=pdflatex

all: $(DOC)

clean:
	rm -f *.pdf *.aux *.toc *.tmp

memoria.pdf: $(basename $(DOC)).tex $(CHAPTERS) classicthesis-config.tex $(basename $(DOC)).bbl
	#pandoc $< -o $@ --latex-engine $(TEX)
	$(TEX) $<
	$(TEX) $<

%.bbl: %.bib $(basename $(DOC)).aux
	$(BIB) $(basename $(DOC))
	$(TEX) $(basename $(DOC)).tex -shell-escape

%.aux: %.tex
	$(TEX) $< -shell-escape
