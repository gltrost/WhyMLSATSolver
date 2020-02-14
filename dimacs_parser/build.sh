#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: ./build.sh <filename.mlw>"
	exit 1
fi

mkdir -p exec
cp main.ml exec/main.ml
why3 extract -D ocaml64 $1 -o exec/sat.ml
cd exec
ocamlbuild -pkg zarith main.native