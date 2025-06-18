# dependencies:
# 	- xelatex, Fontawesome, Fontin (font)
# 	- python3, stripping ntk info
# 	- imagemagick, converting logos
SHELL := /bin/bash

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


src_folder = template
dest_folder = src/assets

dimension = 256
quality = 98

# requires imagemagick
images:
	echo "Converting this folder $(src_folder) and outputting to $(dest_folder)..."
	mkdir $(dest_folder) || true
	mkdir $(dest_folder)/tooling || true
	for s_file in "$(src_folder)"/*; do \
		dest_path="$(dest_folder)/`basename $$s_file`" ; \
		echo "- $$s_file -> $$dest_path" ; \
		convert $$s_file -resize "$(dimension)"x -quality "$(quality)"% $$dest_path ; \
		mogrify -strip $$dest_path ; \
	done

# Create white versions of tooling icons for dark mode
white_tooling_icons:
	echo "Creating white versions of tooling icons..."
	mkdir -p $(dest_folder)/tooling || true
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

sourcee: output_dir
	@$(call helper_copy_doc)
	@$(call helper_scrub_resume)

resumee: output_dir
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


source_export: sourcee
	mkdir resume/src || true
	mv src/working.tex resume/src/illya-starikov-resume.tex
	cp src/macros.tex resume/src/macros.tex
	cp makefile resume/src/makefile

cv_export: cv
	mv working.pdf resume/illya-starikov-cv.pdf

cv_dark_export: cv_dark
	mv working.pdf resume/illya-starikov-cv-dark.pdf

resume_export: resumee
	mv working.pdf resume/illya-starikov-resume.pdf

resume_dark_export: resume_dark
	mv working.pdf resume/illya-starikov-resume-dark.pdf

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

