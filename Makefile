update-nixpkgs: 
	niv update nixpkgs -b nixpkgs-unstable

reload: 
	direnv reload

build: 
	cabal build

test: 
	cabal test

run: 
	cabal run karmaDM

clean:
	cabal clean

repl:
	cabal repl

format:
	fourmolu -i src/**/*.hs app/**/*.hs
	stylish-haskell -i src/**/*.hs app/**/*.hs

docs:
	cabal haddock --haddock-html --haddock-hoogle
	hoogle generate
	hoogle server --local --port=8080

lint:
	hlint src app

install:
	cabal install --installdir=$HOME/.local/bin

release:
	cabal build --enable-executable-stripping

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  update-nixpkgs     Update nixpkgs to latest unstable version"
	@echo "  reload             Reload direnv"
	@echo "  build              Build the project"
	@echo "  test               Run tests"
	@echo "  run                Run the application"
	@echo "  clean              Clean up build artifacts"
	@echo "  repl               Start an interactive REPL session"
	@echo "  format             Format Haskell source code with fourmolu and stylish-haskell"
	@echo "  docs               Generate Haddock documentation and start a Hoogle server on port 8080"
	@echo "  lint               Run hlint on source code"
	@echo "  install            Install the executable to $HOME/.local/bin"
	@echo "  release            Create a release build with optimizations"
	@echo "  help               Show this help message"

.PHONY: update-nixpkgs reload build test run clean repl format docs lint install release help
