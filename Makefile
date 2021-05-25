SHELL := /bin/bash
# use bash for <( ) syntax

.PHONY : setup

osu-may-2021.slides.html : setup

setup :
	$(MAKE) -C figs

include rules.mk
