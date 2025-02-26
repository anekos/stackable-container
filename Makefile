.PHONY: build
build:
	./generate

.PHONY: preview
preview:
	openscad --hardwarnings main.scad
