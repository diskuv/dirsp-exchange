# Builds Sphinx documentation and the library

INSTALL_ARGS       := $(if $(PREFIX),--prefix $(PREFIX),)

DUNE_REPRODUCE_OPTS = --workspace dune-workspace.dev

build:
	dune build $(DUNE_REPRODUCE_OPTS) @all

build-noautogen:
	dune build --ignore-promoted-rules @all

utop-noautogen:
	dune utop --ignore-promoted-rules

test:
	dune runtest $(DUNE_REPRODUCE_OPTS)

test-noautogen:
	dune build --ignore-promoted-rules @runtest

doc: html
	dune build @doc

install:
	dune build @install $(DUNE_REPRODUCE_OPTS) $(INSTALL_ARGS)

uninstall:
	dune uninstall $(DUNE_REPRODUCE_OPTS) $(INSTALL_ARGS)

reinstall: uninstall install

clean:
	dune clean

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build

sphinx-help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: sphinx-help Makefile build build-noautogen doc install uninstall reinstall clean

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
