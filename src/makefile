# dependencies:
# 	- xelatex, Fontawesome, Fontin (font)
# 	- python3, stripping ntk info
# 	- imagemagick, converting logos
SHELL := /bin/bash

.PHONY: all install clean images white_tooling_icons help

all: \
	images \
	white_tooling_icons \
	source_export \
	ntk_export ntk_dark_export \
	cv_export cv_dark_export \
	resume_prod_export resume_prod_dark_export \
	resume_export resume_dark_export \
	cv_prod_export cv_prod_dark_export \
	resume_redacted_export resume_redacted_dark_export \
	cv_redacted_export cv_redacted_dark_export

# Install dependencies (excluding LaTeX)
install:
	@echo "========================================="
	@echo "Installing Resume Build Dependencies"
	@echo "========================================="
	@echo ""
	@echo "Checking system type..."
	@if [ "$$(uname)" = "Darwin" ]; then \
		echo "✓ macOS detected"; \
		echo ""; \
		echo "Installing dependencies via Homebrew..."; \
		echo ""; \
		if ! command -v brew &> /dev/null; then \
			echo "✗ Homebrew not found!"; \
			echo ""; \
			echo "Please install Homebrew first:"; \
			echo "  /bin/bash -c \"\$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""; \
			echo ""; \
			echo "Then run 'make install' again."; \
			exit 1; \
		fi; \
		echo "✓ Homebrew found"; \
		echo ""; \
		echo "Installing ImageMagick..."; \
		brew list imagemagick &> /dev/null || brew install imagemagick; \
		echo "✓ ImageMagick installed"; \
		echo ""; \
		echo "Installing Python3..."; \
		brew list python@3 &> /dev/null || brew install python@3; \
		echo "✓ Python3 installed"; \
		echo ""; \
	elif [ "$$(uname)" = "Linux" ]; then \
		echo "✓ Linux detected"; \
		echo ""; \
		if command -v apt-get &> /dev/null; then \
			echo "Installing dependencies via apt-get..."; \
			echo ""; \
			echo "Installing ImageMagick..."; \
			sudo apt-get update && sudo apt-get install -y imagemagick; \
			echo "✓ ImageMagick installed"; \
			echo ""; \
			echo "Installing Python3..."; \
			sudo apt-get install -y python3; \
			echo "✓ Python3 installed"; \
			echo ""; \
		elif command -v yum &> /dev/null; then \
			echo "Installing dependencies via yum..."; \
			echo ""; \
			echo "Installing ImageMagick..."; \
			sudo yum install -y ImageMagick; \
			echo "✓ ImageMagick installed"; \
			echo ""; \
			echo "Installing Python3..."; \
			sudo yum install -y python3; \
			echo "✓ Python3 installed"; \
			echo ""; \
		else \
			echo "✗ Unsupported package manager"; \
			echo "Please install manually:"; \
			echo "  - ImageMagick"; \
			echo "  - Python3"; \
			exit 1; \
		fi; \
	else \
		echo "✗ Unsupported operating system: $$(uname)"; \
		echo "Please install manually:"; \
		echo "  - ImageMagick"; \
		echo "  - Python3"; \
		exit 1; \
	fi
	@echo "========================================="
	@echo "Verifying installations..."
	@echo "========================================="
	@echo ""
	@if command -v convert &> /dev/null; then \
		echo "✓ ImageMagick: $$(convert -version | head -n 1)"; \
	else \
		echo "✗ ImageMagick not found in PATH"; \
	fi
	@if command -v python3 &> /dev/null; then \
		echo "✓ Python3: $$(python3 --version)"; \
	else \
		echo "✗ Python3 not found in PATH"; \
	fi
	@echo ""
	@echo "========================================="
	@echo "LaTeX Installation Instructions"
	@echo "========================================="
	@echo ""
	@echo "This project requires XeLaTeX with the following packages:"
	@echo "  - fontspec, xunicode, xltxtra, url, parskip"
	@echo "  - fontawesome5"
	@echo "  - darkmode (custom package)"
	@echo "  - lmodern, layaureo"
	@echo "  - And many more (see src/macros.tex for full list)"
	@echo ""
	@if [ "$$(uname)" = "Darwin" ]; then \
		echo "For macOS, install MacTeX (recommended):"; \
		echo "  Option 1 - Full MacTeX (~4GB):"; \
		echo "    brew install --cask mactex"; \
		echo ""; \
		echo "  Option 2 - BasicTeX (smaller, ~100MB):"; \
		echo "    brew install --cask basictex"; \
		echo "    sudo tlmgr update --self"; \
		echo "    sudo tlmgr install fontawesome5 layaureo darkmode \\"; \
		echo "      fontspec xunicode xltxtra url parskip enumitem \\"; \
		echo "      marvosym titlesec setspace siunitx multicol textcomp \\"; \
		echo "      array ulem xcolor textpos hyperref lmodern ifthen \\"; \
		echo "      adjustbox nicefrac censor geometry moresize"; \
		echo ""; \
		echo "  After installation, you may need to add to PATH:"; \
		echo "    export PATH=\"/Library/TeX/texbin:\$$PATH\""; \
		echo ""; \
	elif [ "$$(uname)" = "Linux" ]; then \
		echo "For Linux, install TeX Live:"; \
		echo "  Ubuntu/Debian:"; \
		echo "    sudo apt-get install texlive-xetex texlive-fonts-extra texlive-latex-extra"; \
		echo ""; \
		echo "  Fedora/RHEL:"; \
		echo "    sudo yum install texlive-xetex texlive-collection-fontsextra"; \
		echo ""; \
		echo "  Or install full TeX Live:"; \
		echo "    sudo apt-get install texlive-full  # Ubuntu/Debian"; \
		echo "    sudo yum install texlive-scheme-full  # Fedora/RHEL"; \
		echo ""; \
	fi
	@echo "========================================="
	@echo "Custom Fonts Required"
	@echo "========================================="
	@echo ""
	@echo "Ensure the following custom fonts are present:"
	@echo "  - src/fonts/Lovelo-Black.otf"
	@echo "  - src/fonts/Lovelo-LineBold.otf"
	@echo "  - src/fonts/Lovelo-LineLight.otf"
	@echo ""
	@if [ -f "src/fonts/Lovelo-LineBold.otf" ]; then \
		echo "✓ Custom fonts found in src/fonts/"; \
	else \
		echo "✗ Custom fonts not found!"; \
		echo "  Please ensure Lovelo fonts are in src/fonts/"; \
	fi
	@echo ""
	@echo "========================================="
	@echo "Verify Installation"
	@echo "========================================="
	@echo ""
	@echo "After installing LaTeX, verify with:"
	@echo "  xelatex --version"
	@echo ""
	@echo "Then test the build with:"
	@echo "  make resume"
	@echo ""
	@echo "========================================="
	@echo "Installation Summary"
	@echo "========================================="
	@echo ""
	@if command -v convert &> /dev/null && command -v python3 &> /dev/null; then \
		echo "✓ Non-LaTeX dependencies installed successfully!"; \
		echo ""; \
		if command -v xelatex &> /dev/null; then \
			echo "✓ XeLaTeX is already installed: $$(xelatex --version | head -n 1)"; \
			echo "✓ You're ready to build! Try: make resume"; \
		else \
			echo "⚠ XeLaTeX not installed yet."; \
			echo "  Follow the instructions above to install LaTeX."; \
		fi; \
	else \
		echo "✗ Some dependencies failed to install."; \
		echo "  Please check the output above for errors."; \
	fi
	@echo ""

# Help target
help:
	@echo "Available targets:"
	@echo "  make install              - Install dependencies (ImageMagick, Python3)"
	@echo "  make all                  - Build all resume variants"
	@echo "  make resume               - Build standard resume (light mode)"
	@echo "  make resume_dark          - Build dark mode resume"
	@echo "  make cv                   - Build CV (light mode)"
	@echo "  make cv_dark              - Build dark mode CV"
	@echo "  make clean                - Remove all build artifacts"
	@echo "  make images               - Process template images"
	@echo "  make white_tooling_icons  - Generate white icons for dark mode"
	@echo "  make help                 - Show this help message"


src_folder = template
dest_folder = src/assets

dimension = 256
quality = 98

# requires imagemagick
images:
	echo "Converting this folder $(src_folder) and outputting to $(dest_folder)..."
	mkdir -p $(dest_folder) || true
	mkdir -p $(dest_folder)/tooling || true
	mkdir -p $(dest_folder)/countries || true
	for s_file in "$(src_folder)"/*.png; do \
		if [ -f "$$s_file" ]; then \
			dest_path="$(dest_folder)/`basename $$s_file`" ; \
			echo "- $$s_file -> $$dest_path" ; \
			convert $$s_file -resize "$(dimension)"x -quality "$(quality)"% $$dest_path ; \
			mogrify -strip $$dest_path ; \
		fi; \
	done
	for s_file in "$(src_folder)"/assets/tooling/*.png; do \
		if [ -f "$$s_file" ]; then \
			dest_path="$(dest_folder)/tooling/`basename $$s_file`" ; \
			echo "- $$s_file -> $$dest_path" ; \
			convert $$s_file -resize "$(dimension)"x -quality "$(quality)"% $$dest_path ; \
			mogrify -strip $$dest_path ; \
		fi; \
	done
	# Handle swift.png.jpeg special case
	if [ -f "$(src_folder)/assets/tooling/swift.png.jpeg" ]; then \
		echo "- $(src_folder)/assets/tooling/swift.png.jpeg -> $(dest_folder)/tooling/swift.png"; \
		convert "$(src_folder)/assets/tooling/swift.png.jpeg" -resize "$(dimension)"x -quality "$(quality)"% "$(dest_folder)/tooling/swift.png"; \
		mogrify -strip "$(dest_folder)/tooling/swift.png"; \
	fi
	for s_file in "$(src_folder)"/assets/countries/*.png; do \
		if [ -f "$$s_file" ]; then \
			dest_path="$(dest_folder)/countries/`basename $$s_file`" ; \
			echo "- $$s_file -> $$dest_path" ; \
			convert $$s_file -resize "$(dimension)"x -quality "$(quality)"% $$dest_path ; \
			mogrify -strip $$dest_path ; \
		fi; \
	done

# Create white versions of tooling icons for dark mode
white_tooling_icons:
	echo "Creating white versions of tooling icons..."
	mkdir -p $(dest_folder)/tooling || true
	# Fix swift icon if it has wrong extension
	if [ -f "$(dest_folder)/tooling/swift.png.jpeg" ] && [ ! -f "$(dest_folder)/tooling/swift.png" ]; then \
		mv "$(dest_folder)/tooling/swift.png.jpeg" "$(dest_folder)/tooling/swift.png"; \
	fi
	# Create perl icon if missing (use python as template)
	if [ ! -f "$(dest_folder)/tooling/perl.png" ] && [ -f "$(dest_folder)/tooling/python.png" ]; then \
		cp "$(dest_folder)/tooling/python.png" "$(dest_folder)/tooling/perl.png"; \
	fi
	for icon in bash c c-sharp cpp gcp latex lua perl python scikit sql swift tensorflow; do \
		if [ -f "$(dest_folder)/tooling/$$icon.png" ]; then \
			echo "- Creating white version of $$icon.png"; \
			convert "$(dest_folder)/tooling/$$icon.png" -fuzz 20% -fill white -opaque black "$(dest_folder)/tooling/$$icon-white.png"; \
		fi; \
	done


clean:
	rm src/working.tex working.pdf || true
	rm -r src/assets || true
	rm -r pdf resume/src resume/*.pdf || true
	latexmk -C || true
	cd src; latexmk -C || true; cd .. 

output_dir:
	mkdir pdf || true


# requires xelatex, require packages
define helper_compile
    xelatex src/working.tex --interaction=nonstopmode || true
endef


define _resume_base
	@$(call helper_copy_doc)
	@$(call helper_letterpaper_enable)
	@$(call helper_displayntk_false)
	@$(call helper_displaycv_false)
	@$(call helper_displaycontact_false)
endef

define _cv_base
	@$(call helper_copy_doc)
	@$(call helper_a4paper_enable)
	@$(call helper_displayntk_false)
	@$(call helper_displaycv_true)
	@$(call helper_displaycontact_false)
	@$(call helper_displaycensor_false)
endef

define _ntk_base
	@$(call helper_copy_doc)
	@$(call helper_letterpaper_enable)
	@$(call helper_displayntk_true)
	@$(call helper_displaycv_true)
	@$(call helper_displaycontact_true)
	@$(call helper_displaycensor_false)
endef

define _resume_prod_base
	@$(call helper_copy_doc)
	@$(call helper_letterpaper_enable)
	@$(call helper_displayntk_false)
	@$(call helper_displaycv_false)
	@$(call helper_displaycontact_true)
	@$(call helper_displaycensor_false)
endef

define _cv_prod_base
	@$(call helper_copy_doc)
	@$(call helper_letterpaper_enable)
	@$(call helper_displayntk_false)
	@$(call helper_displaycv_true)
	@$(call helper_displaycontact_true)
	@$(call helper_displaycensor_false)
endef

define _cv_redacted_base
	@$(call helper_copy_doc)
	@$(call helper_letterpaper_enable)
	@$(call helper_displayntk_false)
	@$(call helper_displaycv_true)
	@$(call helper_displaycontact_true)
	@$(call helper_displaycensor_true)
endef

define _resume_redacted_base
	@$(call helper_copy_doc)
	@$(call helper_letterpaper_enable)
	@$(call helper_displayntk_false)
	@$(call helper_displaycv_false)
	@$(call helper_displaycontact_true)
	@$(call helper_displaycensor_true)
endef

source: output_dir
	@$(call helper_copy_doc)
	@$(call helper_scrub_resume)

resume: output_dir
	@$(call _resume_base)
	@$(call helper_disable_dark)
	@$(call helper_compile)

resume_dark: output_dir
	@$(call _resume_base)
	@$(call helper_enable_dark)
	@$(call helper_compile)

cv: output_dir
	@$(call _cv_base)
	@$(call helper_disable_dark)
	@$(call helper_compile)

cv_dark: output_dir
	@$(call _cv_base)
	@$(call helper_enable_dark)
	@$(call helper_compile)

ntk: output_dir
	@$(call _ntk_base)
	@$(call helper_disable_dark)
	@$(call helper_compile)

ntk_dark: output_dir
	@$(call _ntk_base)
	@$(call helper_enable_dark)
	@$(call helper_compile)

resume_prod: output_dir
	@$(call _resume_prod_base)
	@$(call helper_disable_dark)
	@$(call helper_compile)

resume_prod_dark: output_dir
	@$(call _resume_prod_base)
	@$(call helper_enable_dark)
	@$(call helper_compile)

cv_prod: output_dir
	@$(call _cv_prod_base)
	@$(call helper_disable_dark)
	@$(call helper_compile)

cv_prod_dark: output_dir
	@$(call _cv_prod_base)
	@$(call helper_enable_dark)
	@$(call helper_compile)

resume_redacted: output_dir
	@$(call _resume_redacted_base)
	@$(call helper_disable_dark)
	@$(call helper_compile)

resume_redacted_dark: output_dir
	@$(call _resume_redacted_base)
	@$(call helper_enable_dark)
	@$(call helper_compile)

cv_redacted: output_dir
	@$(call _cv_redacted_base)
	@$(call helper_disable_dark)
	@$(call helper_compile)

cv_redacted_dark: output_dir
	@$(call _cv_redacted_base)
	@$(call helper_enable_dark)
	@$(call helper_compile)


source_export: source
	mkdir resume/src || true
	mv src/working.tex resume/src/illya-starikov-resume.tex
	cp src/macros.tex resume/src/macros.tex
	cp makefile resume/src/makefile

cv_export: cv
	mv working.pdf resume/illya-starikov-cv.pdf

cv_dark_export: cv_dark
	mv working.pdf resume/illya-starikov-cv-dark.pdf

resume_export: resume
	mkdir -p resume/src; cp working.pdf resume/src/illya-starikov-resume.pdf; mv working.pdf resume/illya-starikov-resume.pdf

resume_dark_export: resume_dark
	mkdir -p resume/src; cp working.pdf resume/src/illya-starikov-resume-dark.pdf; mv working.pdf resume/illya-starikov-resume-dark.pdf

ntk_export: ntk
	mkdir pdf/ntk/; mv working.pdf pdf/ntk/illya-starikov-resume.pdf

ntk_dark_export: ntk_dark
	mkdir pdf/ntk-dark/; mv working.pdf pdf/ntk-dark/illya-starikov-resume.pdf

resume_prod_export: resume_prod
	mkdir pdf/resume/; mv working.pdf pdf/resume/illya-starikov-resume.pdf

resume_prod_dark_export: resume_prod_dark
	mkdir pdf/resume-dark/; mv working.pdf pdf/resume-dark/illya-starikov-resume.pdf

cv_prod_export: cv_prod
	mkdir pdf/cv/; mv working.pdf pdf/cv/illya-starikov-resume.pdf

cv_prod_dark_export: cv_prod_dark
	mkdir pdf/cv-dark/; mv working.pdf pdf/cv-dark/illya-starikov-resume.pdf

resume_redacted_export: resume_redacted
	mkdir pdf/resume-redacted/; mv working.pdf pdf/resume-redacted/illya-starikov-resume.pdf

resume_redacted_dark_export: resume_redacted_dark
	mkdir pdf/resume-redacted-dark/; mv working.pdf pdf/resume-redacted-dark/illya-starikov-resume.pdf

cv_redacted_export: cv_redacted
	mkdir pdf/cv-redacted/; mv working.pdf pdf/cv-redacted/illya-starikov-resume.pdf

cv_redacted_dark_export: cv_redacted_dark
	mkdir pdf/cv-redacted-dark/; mv working.pdf pdf/cv-redacted-dark/illya-starikov-resume.pdf


# TODO: Make these check for the beginning of line, check for multiple comments
define helper_a4paper_enable
	sed -i '' 's/\\documentclass\[10pt,letterpaper\]{article}/\% \\documentclass\[10pt,letterpaper\]{article}/g' src/working.tex
	sed -i '' 's/\% \\documentclass\[11pt,a4paper\]{article}/\\documentclass\[11pt,a4paper\]{article}/g' src/working.tex

	sed -i '' 's/\% \\usepackage\[big\]{layaureo}/\\usepackage\[big\]{layaureo}/g' src/working.tex
endef

define helper_letterpaper_enable
	sed -i '' 's/\% \\documentclass\[10pt,letterpaper\]{article}/\\documentclass\[10pt,letterpaper\]{article}/g' src/working.tex
	sed -i '' 's/\\documentclass\[11pt,a4paper\]{article}/\% \\documentclass\[11pt,a4paper\]{article}/g' src/working.tex

	sed -i '' 's/\\usepackage\[big\]{layaureo}/\% \\usepackage\[big\]{layaureo}/g' src/working.tex
endef


define helper_displayntk_true
	sed -i '' 's/\% \\setboolean{ntk}{true}/\\setboolean{ntk}{true}/g' src/working.tex
	sed -i '' 's/\\setboolean{ntk}{false}/\% \\setboolean{ntk}{false}/g' src/working.tex
endef

define helper_displayntk_false
	sed -i '' 's/\\setboolean{ntk}{true}/\% \\setboolean{ntk}{true}/g' src/working.tex
	sed -i '' 's/\% \\setboolean{ntk}{false}/\\setboolean{ntk}{false}/g' src/working.tex
endef


define helper_displaycv_true
	sed -i '' 's/\% \\setboolean{displaycv}{true}/\\setboolean{displaycv}{true}/g' src/working.tex
	sed -i '' 's/\\setboolean{displaycv}{false}/\% \\setboolean{displaycv}{false}/g' src/working.tex
endef

define helper_displaycv_false
	sed -i '' 's/\\setboolean{displaycv}{true}/\% \\setboolean{displaycv}{true}/g' src/working.tex
	sed -i '' 's/\% \\setboolean{displaycv}{false}/\\setboolean{displaycv}{false}/g' src/working.tex
endef


define helper_displaycontact_true
	sed -i '' 's/\% \\setboolean{displaycontact}{true}/\\setboolean{displaycontact}{true}/g' src/working.tex
	sed -i '' 's/\\setboolean{displaycontact}{false}/\% \\setboolean{displaycontact}{false}/g' src/working.tex
endef

define helper_displaycontact_false
	sed -i '' 's/\\setboolean{displaycontact}{true}/\% \\setboolean{displaycontact}{true}/g' src/working.tex
	sed -i '' 's/\% \\setboolean{displaycontact}{false}/\\setboolean{displaycontact}{false}/g' src/working.tex
endef


define helper_displaycensor_true
	sed -i '' 's/\% \\setboolean{displaycensored}{true}/\\setboolean{displaycensored}{true}/g' src/working.tex
	sed -i '' 's/\\setboolean{displaycensored}{false}/\% \\setboolean{displaycensored}{false}/g' src/working.tex
endef

define helper_displaycensor_false
	sed -i '' 's/\\setboolean{displaycensored}{true}/\% \\setboolean{displaycensored}{true}/g' src/working.tex
	sed -i '' 's/\% \\setboolean{displaycensored}{false}/\\setboolean{displaycensored}{false}/g' src/working.tex
endef


define helper_enable_dark
	sed -i '' 's/\\usepackage{darkmode}/\% \\usepackage{darkmode}/g' src/working.tex
	sed -i '' 's/\% \\usepackage\[enable\]{darkmode}/\\usepackage\[enable\]{darkmode}/g' src/working.tex
endef

define helper_disable_dark
	sed -i '' 's/\% \\usepackage{darkmode}/\\usepackage{darkmode}/g' src/working.tex
	sed -i '' 's/\\usepackage\[enable\]{darkmode}/\% \\usepackage\[enable\]{darkmode}/g' src/working.tex
endef


define helper_copy_doc
	cp src/illya-starikov-resume.tex src/working.tex
endef

define scrub_resume_command
import re
p = 'src/working.tex'


def find_matching_brace(s, start_index, extra_searches=0):
	stack = []

	if s[start_index] != '{':
		return -1

	for i in range(start_index, len(s)):
		if s[i] == '{':
			stack.append('{')
		elif s[i] == '}':
			stack.pop()

		if len(stack) == 0:
			if extra_searches == 0:
				return i
			else:
				extra_searches -= 1

	return -1


def main():
	patterns = [
		(r'(\\ntkT{)([\s\S]*})', 1),
		(r'(\\ntkF{)([\s\S]*})', 1),
		(r'(\\ntkTF{)([\s\S]*})', 2),
		(r'(\\ntk{)([\s\S]*})', 1),
	]

	with open(p, 'r') as file_handle:
		resume_text = file_handle.read()

	for pattern, number_of_args in patterns:
		matches = re.findall(pattern, resume_text)

		while matches != []:
			for match in matches:
				boilerplate, inner_text = match
				full_text = f'{boilerplate}{inner_text}'

				start_brace_index = len(boilerplate) - 1
				end_brace_index = find_matching_brace(
						full_text, start_brace_index, number_of_args - 1
				)

				full_string_to_remove = full_text[:end_brace_index + 1]
				resume_text = resume_text.replace(
						full_string_to_remove, ''
				)

			matches = re.findall(pattern, resume_text)

	print(resume_text)


main()
endef
export scrub_resume_command

define helper_scrub_resume
	python3 -c "$$scrub_resume_command" > src/working_temp.tex
	mv src/working_temp.tex src/working.tex
endef

