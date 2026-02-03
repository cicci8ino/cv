template.cv:
	mkdir -p output
	poetry run jinja2 templates/cv.tex.j2 src/profile.json --block-start '<BLOCK>' --block-end '</BLOCK>' --variable-start '<VAR>' --variable-end '</VAR>' --format json > output/cv.tex

template.certifications:
	mkdir -p output
	poetry run jinja2 templates/section_certifications.tex.j2 src/certifications.json --block-start '<BLOCK>' --block-end '</BLOCK>' --variable-start '<VAR>' --variable-end '</VAR>' --format json > output/section_certifications.tex

template.experience:
	mkdir -p output
	poetry run jinja2 templates/section_experience.tex.j2 src/experencies.json --block-start '<BLOCK>' --block-end '</BLOCK>' --variable-start '<VAR>' --variable-end '</VAR>' --format json > output/section_experience.tex

template.headline:
	mkdir -p output
	poetry run jinja2 templates/section_headline.tex.j2 src/profile.json --block-start '<BLOCK>' --block-end '</BLOCK>' --variable-start '<VAR>' --variable-end '</VAR>' --format json > output/section_headline.tex

template.honors:
	mkdir -p output
	poetry run jinja2 templates/section_honors_awards.tex.j2 src/education.json --block-start '<BLOCK>' --block-end '</BLOCK>' --variable-start '<VAR>' --variable-end '</VAR>' --format json > output/section_honors_awards.tex

template.language:
	mkdir -p output
	poetry run jinja2 templates/section_languages.tex.j2 src/interests.json src/languages.json --block-start '<BLOCK>' --block-end '</BLOCK>' --variable-start '<VAR>' --variable-end '</VAR>' --format json > output/section_languages.tex

template.projects:
	mkdir -p output
	poetry run jinja2 templates/section_projects.tex.j2 src/projects.json --block-start '<BLOCK>' --block-end '</BLOCK>' --variable-start '<VAR>' --variable-end '</VAR>' --format json > output/section_projects.tex

template.skills:
	mkdir -p output
	poetry run jinja2 templates/section_skills.tex.j2 src/skills.json --block-start '<BLOCK>' --block-end '</BLOCK>' --variable-start '<VAR>' --variable-end '</VAR>' --format json > output/section_skills.tex

template.all: template.cv template.certifications template.experience template.headline template.honors template.language template.projects template.skills

clean:
	rm -rf output

copy_files:
	mkdir -p output
	cp -r latex/yaac-another-awesome-cv/fonts output/fonts
	cp -r latex/yaac-another-awesome-cv/yaac-another-awesome-cv.cls output/yaac-another-awesome-cv.cls
	cp src/picture.png output/picture.png

build.pdf:
	TEXINPUTS=output: lualatex -interaction=nonstopmode -halt-on-error -output-directory=output output/cv.tex

build: copy_files template.all build.pdf

install:
	brew install --cask basictex
