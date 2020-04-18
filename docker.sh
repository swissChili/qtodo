#!/bin/bash

docker image build -t qtodo:1 .
docker container run --name qtodo qtodo:1
