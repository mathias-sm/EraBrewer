README.html: README.md
	pandoc dev/header.yaml README.md --lua-filter=vignettes/color_span.lua --css dev/style.css --embed-resources --standalone -o README.html

README.md: README.Rmd R/PaletteCode.R dev/test_plots.R
	Rscript -e "devtools::build_readme(output_format = 'md_document')"

docs/index.html: README.Rmd dev/test_plots.R R/PaletteCode.R
	Rscript -e "devtools::check('.')"
	Rscript -e "pkgdown::build_site()"

all: README.md README.Rmd docs/index.html

clean:
	rm -Rf README.md README.html docs
