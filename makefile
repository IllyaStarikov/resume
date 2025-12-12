# Simplified makefile for compiling resume in the public repo
# Dependencies: xelatex, fontawesome, fontin fonts

SHELL := /bin/bash

# Default target
all: resume

# Clean build artifacts
clean:
	rm -f src/*.aux src/*.log src/*.out src/*.fdb_latexmk src/*.fls src/*.synctex.gz
	rm -f *.pdf

# Build resume
resume:
	cd src && xelatex illya-starikov-resume.tex --interaction=nonstopmode || true
	cd src && mv illya-starikov-resume.pdf ../illya-starikov-resume.pdf || true

# Build with multiple passes for references
resume-full:
	cd src && xelatex illya-starikov-resume.tex --interaction=nonstopmode || true
	cd src && xelatex illya-starikov-resume.tex --interaction=nonstopmode || true
	cd src && mv illya-starikov-resume.pdf ../illya-starikov-resume.pdf || true

.PHONY: all clean resume resume-full