SHELL := /bin/bash
.PHONY: figs modeling_figs

figs: modeling_figs \
	  spatial_pedigree.png \
	  locator_spatial_tree_sequence.png \
	  locator_methods.png \
	  locator_results.png \
	  shic_cnn.png \
	  shic_images.png


modeling_figs: modeling_reality.png \
			   modeling_model_parameters.png \
			   modeling_model_parameters_inverse.png \
			   modeling_parameters_inverse_computer.png

modeling_%.pdf: modeling.ink.svg
	./export-layers-svg.sh $< $@ data $(subst _, ,$*)

include ../rules.mk
