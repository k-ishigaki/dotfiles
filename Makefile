# Makefile
# environment dependence
ifeq ($(OS),Windows_NT)
	fix-path = $(subst /,\,$1)
	DIR        = $(shell echo %HOMEPATH%)
	# make hard link at windows
	make-link  = mklink /H $(call fix-path,$(DIR)/$1 $1) &
else
	fix-path = $1
	# make symbolic link at linux
	make-link := ln -sf $1 ~/$1;
endif

# target
EXCLUDES := .git $(wildcard .*.swp)
TARGET   := $(wildcard .??*)
FILES    := $(filter-out $(EXCLUDES), $(TARGET))

# install
.PHONY: install
install:
	$(foreach f, $(FILES), $(call make-link,$(f)))

