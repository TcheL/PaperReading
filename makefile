file := Reading
xlx := xelatex -interaction=nonstopmode
csuf := aux blg bbl log out idx ind ilg toc nav snm synctex.gz tex.bak
cdir := FWI WaveForward Others

all : tex2pdf backup view

cc : clean clear

tex2pdf :
	$(xlx) $(file).tex

full :
	$(xlx) $(file).tex
	-bibtex $(file).aux
	-makeindex $(file).idx
	$(xlx) $(file).tex > /dev/null
	-makeindex $(file).idx
	$(xlx) $(file).tex > /dev/null
#	$(xlx) $(file).tex > /dev/null

view :
	evince $(file).pdf &

edit :
	vim $(file).tex

backup :
	tar -zpcv -f Backup.tar.gz $(file).tex $(file).pdf \
        $(foreach cd,$(cdir),$(cd)/*.tex)

clean :
	-rm -f $(foreach cs,$(csuf),$(file).$(cs))
	-rm -f $(foreach cd,$(cdir),$(foreach cs,$(csuf),$(cd)/*.$(cs)))

clear :
	-rm -f $(file).pdf

# vim:ft=make:noet:noai:ts=4
