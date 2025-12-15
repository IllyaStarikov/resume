# Standalone Resume Makefile
# Compiles from within the resume/src/ directory
# Uses FontAwesome icons instead of images (displaycolor=false)
#
# Usage:
#   make resume       - Build resume (light mode)
#   make resume_dark  - Build resume (dark mode)
#   make cv           - Build CV (light mode)
#   make cv_dark      - Build CV (dark mode)
#   make all          - Build all variants
#   make clean        - Remove build artifacts
SHELL := /bin/bash

.PHONY: all resume resume_dark cv cv_dark clean help

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
	cp illya-starikov-resume.tex working.tex
	sed -i '' 's|% \\documentclass\[10pt,letterpaper\]{article}|\\documentclass\[10pt,letterpaper\]{article}|g' working.tex
	sed -i '' 's|\\documentclass\[11pt,a4paper\]{article}|% \\documentclass\[11pt,a4paper\]{article}|g' working.tex
	sed -i '' 's|\\usepackage\[big\]{layaureo}|% \\usepackage\[big\]{layaureo}|g' working.tex
	sed -i '' 's|\\setboolean{displaycv}{true}|% \\setboolean{displaycv}{true}|g' working.tex
	sed -i '' 's|% \\setboolean{displaycv}{false}|\\setboolean{displaycv}{false}|g' working.tex
	sed -i '' 's|% \\usepackage{darkmode}|\\usepackage{darkmode}|g' working.tex
	sed -i '' 's|\\usepackage\[enable\]{darkmode}|% \\usepackage\[enable\]{darkmode}|g' working.tex
	xelatex working.tex --interaction=nonstopmode || true
	mv working.pdf illya-starikov-resume.pdf

resume_dark:
	cp illya-starikov-resume.tex working.tex
	sed -i '' 's|% \\documentclass\[10pt,letterpaper\]{article}|\\documentclass\[10pt,letterpaper\]{article}|g' working.tex
	sed -i '' 's|\\documentclass\[11pt,a4paper\]{article}|% \\documentclass\[11pt,a4paper\]{article}|g' working.tex
	sed -i '' 's|\\usepackage\[big\]{layaureo}|% \\usepackage\[big\]{layaureo}|g' working.tex
	sed -i '' 's|\\setboolean{displaycv}{true}|% \\setboolean{displaycv}{true}|g' working.tex
	sed -i '' 's|% \\setboolean{displaycv}{false}|\\setboolean{displaycv}{false}|g' working.tex
	sed -i '' 's|\\usepackage{darkmode}|% \\usepackage{darkmode}|g' working.tex
	sed -i '' 's|% \\usepackage\[enable\]{darkmode}|\\usepackage\[enable\]{darkmode}|g' working.tex
	xelatex working.tex --interaction=nonstopmode || true
	mv working.pdf illya-starikov-resume-dark.pdf

cv:
	cp illya-starikov-resume.tex working.tex
	sed -i '' 's|\\documentclass\[10pt,letterpaper\]{article}|% \\documentclass\[10pt,letterpaper\]{article}|g' working.tex
	sed -i '' 's|% \\documentclass\[11pt,a4paper\]{article}|\\documentclass\[11pt,a4paper\]{article}|g' working.tex
	sed -i '' 's|% \\usepackage\[big\]{layaureo}|\\usepackage\[big\]{layaureo}|g' working.tex
	sed -i '' 's|% \\setboolean{displaycv}{true}|\\setboolean{displaycv}{true}|g' working.tex
	sed -i '' 's|\\setboolean{displaycv}{false}|% \\setboolean{displaycv}{false}|g' working.tex
	sed -i '' 's|% \\usepackage{darkmode}|\\usepackage{darkmode}|g' working.tex
	sed -i '' 's|\\usepackage\[enable\]{darkmode}|% \\usepackage\[enable\]{darkmode}|g' working.tex
	xelatex working.tex --interaction=nonstopmode || true
	mv working.pdf illya-starikov-cv.pdf

cv_dark:
	cp illya-starikov-resume.tex working.tex
	sed -i '' 's|\\documentclass\[10pt,letterpaper\]{article}|% \\documentclass\[10pt,letterpaper\]{article}|g' working.tex
	sed -i '' 's|% \\documentclass\[11pt,a4paper\]{article}|\\documentclass\[11pt,a4paper\]{article}|g' working.tex
	sed -i '' 's|% \\usepackage\[big\]{layaureo}|\\usepackage\[big\]{layaureo}|g' working.tex
	sed -i '' 's|% \\setboolean{displaycv}{true}|\\setboolean{displaycv}{true}|g' working.tex
	sed -i '' 's|\\setboolean{displaycv}{false}|% \\setboolean{displaycv}{false}|g' working.tex
	sed -i '' 's|\\usepackage{darkmode}|% \\usepackage{darkmode}|g' working.tex
	sed -i '' 's|% \\usepackage\[enable\]{darkmode}|\\usepackage\[enable\]{darkmode}|g' working.tex
	xelatex working.tex --interaction=nonstopmode || true
	mv working.pdf illya-starikov-cv-dark.pdf

clean:
	rm -f working.tex working.pdf working.aux working.log working.out || true
	latexmk -C || true
