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
	xelatex src/illya-starikov-resume.tex --interaction=nonstopmode || true
	mv illya-starikov-resume.pdf ./illya-starikov-resume.pdf 2>/dev/null || true

# Build with multiple passes for references
resume-full:
	xelatex src/illya-starikov-resume.tex --interaction=nonstopmode || true
	xelatex src/illya-starikov-resume.tex --interaction=nonstopmode || true
	mv illya-starikov-resume.pdf ./illya-starikov-resume.pdf 2>/dev/null || true

.PHONY: all clean resume resume-full