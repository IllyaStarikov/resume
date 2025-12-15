# Simplified makefile for compiling resume in the public repo
# Dependencies: xelatex, fontawesome
#
# Note: This compiles from the src/ directory where the standalone
# source files are located. Output is moved to the root for convenience.

SHELL := /bin/bash

.PHONY: all clean resume resume_dark cv cv_dark help

all: resume resume_dark cv cv_dark

help:
	@echo "Available targets:"
	@echo "  make resume       - Build resume (light mode)"
	@echo "  make resume_dark  - Build resume (dark mode)"
	@echo "  make cv           - Build CV (light mode)"
	@echo "  make cv_dark      - Build CV (dark mode)"
	@echo "  make all          - Build all variants"
	@echo "  make clean        - Remove build artifacts"

resume:
	cd src && $(MAKE) resume
	cp src/illya-starikov-resume.pdf ./

resume_dark:
	cd src && $(MAKE) resume_dark
	cp src/illya-starikov-resume-dark.pdf ./

cv:
	cd src && $(MAKE) cv
	cp src/illya-starikov-cv.pdf ./

cv_dark:
	cd src && $(MAKE) cv_dark
	cp src/illya-starikov-cv-dark.pdf ./

clean:
	cd src && $(MAKE) clean
	rm -f *.pdf *.aux *.log *.out
