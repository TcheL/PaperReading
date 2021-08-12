TEXE := xelatex
OUTDIR := build
CFLAGS := -synctex=1 -interaction=nonstopmode
TEXD :=
MAIN := Reading
DIRS := \
  FWI \
  Modelling \
  Inversion \
  Others

SUFS := \
  aux \
  bbl blg \
  fdb_latexmk fls \
  idx ind ilg \
  listing loc lof log lol los lot ltx \
  nav nlo nls \
  out \
  run.xml \
  snm synctex.gz synctex\(busy\) \
  toc \
  vrb \
  xdv

ifeq ($(TEXE), xelatex)
  MKFLAGS := -pdfxe
else ifeq ($(TEXE), pdflatex)
  MKFLAGS := -pdf
else ifeq ($(TEXE), lualatex)
  MKFLAGS := -pdflua
else
  MKFLAGS :=
endif

all : prep tex2pdf backup view

prep :
	ln -fs $(OUTDIR)/$(MAIN).pdf
	mkdir -p $(OUTDIR)

tex2pdf :
	$(TEXD)$(TEXE) $(CFLAGS) -output-directory="$(OUTDIR)" $(MAIN)

full :
	$(TEXD)latexmk $(MKFLAGS) $(CFLAGS) -outdir=$(OUTDIR) $(MAIN)

view :
	evince $(MAIN).pdf &

edit :
	vim $(MAIN).tex

backup :
	tar -zpcv -f Backup.tar.gz $(MAIN).tex $(MAIN).pdf \
        $(foreach d,$(DIRS),$(d)/*.tex)

clean :
	-rm -f $(foreach s,$(SUFS),$(OUTDIR)/$(MAIN).$(s))

clear :
	-rm -f $(MAIN).pdf
	-rm -rf $(OUTDIR)

# vim:ft=make:noet:noai:ts=4
