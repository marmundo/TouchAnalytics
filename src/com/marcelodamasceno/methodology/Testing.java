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
	    double[] probability=classifier.distributionForInstance(testInstance);
	    double score=Math.log(probability[0]/probability[1]);
	    scores.add(score);
	}
	return scores;
    }
}
