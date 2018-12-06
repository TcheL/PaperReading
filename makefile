file := Reading
xlx := xelatex -interaction=nonstopmode
csuf := aux blg bbl log out synctex.gz tex.bak toc

all : tex2pdf backup view

cc : clean clear

tex2pdf :
	$(xlx) $(file).tex

full :
	$(xlx) $(file).tex
	-bibtex $(file).aux
	$(xlx) $(file).tex > /dev/null
	$(xlx) $(file).tex > /dev/null

view :
	evince $(file).pdf &

edit :
	vim $(file).tex

backup : $(file).tex $(file).pdf
	tar -zpcv -f Backup.tar.gz $(file).tex $(file).pdf

clean :
	-rm -f $(foreach cs,$(csuf),$(file).$(cs))
	-rm -f $(foreach cs,$(csuf),FWI/*.$(cs))
	-rm -f $(foreach cs,$(csuf),WaveForward/*.$(cs))

clear :
	-rm -f $(file).pdf

# vim:ft=make:noet:noai:ts=4
