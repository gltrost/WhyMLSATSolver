# WhyMLSATSolver
This is an implementation of a SAT Solver using Unit Propagation in WhyML. WhyML allows for writing correct-by-construction OCaml programs through automated extraction.

## Goals

This is a work in progress WhyML project for a Unit SAT-Solver.

The hope is to make the SAT-Solver competitive with other efficient SAT-Solvers written in WhyML, and by extension competitive with other efficient SAT-Solvers written in OCaml.

## Running this application

### Requirements

* Why3

```
brew install hg darcs opam gtk+ gmp gtksourceview libgnomecanvas z3 autoconf
opam init ; opam config setup -a ; eval $(opam config env)
opam install lablgtk zarith why3 why3-ide alt-ergo
why3 config --detect-provers
```

### Running this project

In `/WhyMLSATSolver`, you can launch `unit-sat.mlw` with

```
why3 ide unit-sat.mlw
```

or launch `final-sat.mlw` with

```
why3 ide final-sat.mlw
```

## Architecture
  1. `unit-sat.mlw` : The primary code for the SAT-solver.
  2. `final-sat.mlw` : Added capabilites to the SAT-solver that allow for improved run-time.

## Future Work

1. Some postconditions in `unit-sat.mlw` and `final-sat.mlw` still need to be proven.
1. Some tactics in `final-sat.mlw` need to be improved for better run-time capabilities.


## Testing
After launching Why3, go to *Tools*, then *Provers*, and select *Z3*.
