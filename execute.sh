#!/bin/bash

java -cp ../weka-latest/weka.jar:./src wekautpkchen.SeededKMeans inputs.txt > out.log&
