export UV_CACHE_DIR := $(CURDIR)/.build/cache
export UV_PROJECT_ENVIRONMENT := $(CURDIR)/.build/venv
export UV_PYTHON_INSTALL_DIR := $(CURDIR)/.build/python
export TMPDIR := $(CURDIR)/.build/tmp

.PHONY: build clean
build:
	mkdir -p "$(TMPDIR)"
	uv run --locked python render_input.py > .build/cv.yaml
	uv run --locked rendercv render .build/cv.yaml --design design.yaml --pdf-path cv.pdf --dont-generate-markdown --dont-generate-png

clean:
	rm -rf .build
