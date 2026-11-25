[![Publish CV](https://github.com/cicci8ino/cv/actions/workflows/build.yaml/badge.svg)](https://github.com/cicci8ino/cv/actions/workflows/build.yaml)

Run `make build` with [uv](https://docs.astral.sh/uv/) installed. It uses Python 3.12
and locked dependencies to render `.build/cv.pdf`. `make clean` removes `.build/`.

Edit the CV in `src/`. `render_input.py` maps the published JSON fields into
[RenderCV input](https://docs.rendercv.com/user_guide/yaml_input_structure/cv/);
`design.yaml` configures the `engineeringresumes` theme. Projects and unpublished
metadata remain in the source JSON and are not included in the PDF.

Tags matching `v*` publish [cv.pdf](https://cicci8ino.github.io/cv/cv.pdf)
to GitHub Pages. The `github-pages` environment must allow deployments from these tags.
