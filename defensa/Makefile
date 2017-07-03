TEX = xelatex
MD = $(wildcard *.md)
# TXSRC = $(wildcard *.tex)
EXE = $(patsubst %.md, %.pdf, $(MD))

default: $(EXE) tidy

%.pdf: %.md beamer.tex
	pandoc $< -o $@ -t beamer -s --latex-engine xelatex --template beamer.tex


# %.tex: %.md
# 	pandoc $< -o $@ -t beamer -s --latex-engine xelatex

# %.pdf: %.tex
# 	$(TEX) $<

clean:
	rm -rf $(EXE) _minted* *.log *.aux *.toc

tidy:
	rm -rf _minted* *.log *.aux *.toc *.out *.vrb *.snm *.nav
