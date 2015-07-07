#bin/bash

WEKA="/home/pkchen/wekaUT/weka-latest/weka.jar"
TargetDIR="/home/pkchen/wekaUT/standalone-pkc/src/"

java  -Xmx2024M -cp "/home/pkchen/weka-3-6-12/weka.jar":"/home/pkchen/weka-3-6-12/" pkchen.utils.CSV2Arff ./X.csv X.arff


i="X.arff"

	fnseeds=`echo $i|sed 's/arff/seeds.txt/g'`
	fnout=`echo $i|sed 's/arff/clustering.memb/g'`
	echo $i
	echo $fnseeds $'\n'

	java -cp $WEKA:$TargetDIR wekautpkchen.SeededKMeans  $i $fnseeds $fnout

#	Rscript step11.semi.seeded.clustering.results.R $i $fnseeds $fnout

	echo $'\n'
	date
	echo "\n##########################################\n"


Rscript step11.semi.seeded.clustering.results.R $i $fnseeds $fnout
 

