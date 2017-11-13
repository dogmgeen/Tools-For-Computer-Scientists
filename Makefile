MD_PIECES = 00-FrontMatter.md	\
	01-Exploring-Text-Editors.md	\
	02-Bash-Basics.md	\
	03-Git-Basics.md	\
	04-Bash-Scripting.md	\
	05-Regular-Expressions.md	\
	06-Integrated-Development-Environments.md	\
	07-Building-with-Make.md	\
	08-Debugging-with-GDB.md	\
	09-Locating-memory-leaks-with-Memcheck.md	\
	10-Profiling.md	\
	11-Unit-testing.md	\
	12-Using-C++11-and-the-Standard-Template-Library.md	\
	13-Graphical-User-Interfaces-with-Qt.md	\
	14-Typesetting-with-LaTeX.md \
	15-Appendices.md

EXTENSIONS = raw_tex+fenced_code_attributes

.PHONY: all tex

all: cs1001_prelab.pdf

tex: cs1001_prelab.tex

quick: tex
	pdflatex cs1001_prelab.tex

book: cs1001_prelab.pdf
	pdfbook --short-edge --letterpaper cs1001_prelab.pdf
	@echo -e "\n\nDone! Be sure to print that bad-boy using short-edge duplexing."

cs1001_prelab.pdf: ${MD_PIECES} template.tex
	pandoc --latex-engine=xelatex --template=template.tex --from markdown+${EXTENSIONS} --output cs1001_prelab.pdf ${MD_PIECES}

cs1001_prelab.tex: ${MD_PIECES} template.tex
	pandoc --template=template.tex --standalone --from markdown+${EXTENSIONS} --output cs1001_prelab.tex ${MD_PIECES}

%.pdf: 00-FrontMatter.md %*.md
	pandoc --latex-engine=xelatex --template=template.tex --from markdown+${EXTENSIONS} --output $@ $^
