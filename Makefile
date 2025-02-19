WIDTH=120
DEPTH=120
HEIGHT=80
THICKNESS=2
# normal | vase | vase-inside
MODE=normal

FILENAME=dist/$(shell basename $(PWD))-$(WIDTH)x$(DEPTH)x$(HEIGHT)-$(THICKNESS)-$(MODE).stl

.PHONY: build
build: $(FILENAME)

.PHONY: preview
preview:
	openscad --hardwarnings main.scad

.PHONY: $(FILENAME)
$(FILENAME): main.scad
	mkdir -p dist
	openscad \
		--hardwarnings \
		-o $(FILENAME) \
		-D "width=$(WIDTH)" \
		-D "depth=$(DEPTH)" \
		-D "height=$(HEIGHT)" \
		-D "thickness=$(THICKNESS)" \
		-D "mode=\"$(MODE)\"" \
		main.scad
