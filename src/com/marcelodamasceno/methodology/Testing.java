package com.marcelodamasceno.methodology;

import java.util.ArrayList;

import weka.classifiers.Classifier;
import weka.core.Instance;
import weka.core.Instances;

public class Testing {
    private Classifier classifier;
    private Instances testDataSet;

    public Testing(Classifier classifier, Instances testDataset){
	this.classifier=classifier;
	this.testDataSet=testDataset;
    }

    public ArrayList<Double> getScores() throws Exception{
	ArrayList<Double> scores=new ArrayList<Double>();
	for (Instance testInstance : testDataSet) {
	    double classIndex= classifier.classifyInstance(testInstance);	    
	    int position=(int) Math.floor(classIndex);	    
	    scores.add(classifier.distributionForInstance(testInstance)[position]);	    
	}
	return scores;
    }
}
