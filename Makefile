CLANG ?= clang
GCC ?= gcc
PCC ?= pcc
TCC ?= tcc
ICC ?= icc

LEVELS := O0 O1 O2 O3
COMPILERS := CLANG GCC PCC TCC ICC

.PHONY: all clean

all:

define COMPILER_all_template =
ifneq ($$($(1)),)
ifneq ($$(shell which $$($(1)) 2> /dev/null),)
.PHONY: all-$(1)
all: all-$(1)
endif
endif
endef

$(foreach compiler,$(COMPILERS),$(eval $(call COMPILER_all_template,$(compiler))))
$(foreach compiler,$(COMPILERS),$(eval all-$(compiler): $(foreach level,$(LEVELS),$(compiler)-$(level) ) ;))
$(foreach compiler,$(COMPILERS),$(foreach level,$(LEVELS),$(compiler)-$(level) )): probe.c
	$($(firstword $(subst -, ,$@))) -$(lastword $(subst -, ,$@)) -o $@ $^

clean:
	$(RM) $(foreach compiler,$(COMPILERS),$(foreach level,$(LEVELS),$(compiler)-$(level) ))

