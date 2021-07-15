#!/bin/env bash

CURRENT=$(basename $(pwd))

if [ "$CURRENT" = "Docker" ];
then
	cp ../Scripts ./
	cp ../CapstoneShiny ./
	docker build -t "capstone-project" .
fi
