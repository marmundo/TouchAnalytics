package com.marcelodamasceno.methodology;

import java.util.ArrayList;

import weka.classifiers.Classifier;
import weka.core.Instance;
import weka.core.Instances;

/**
 * Class test and generate scores matrix
 * 
 * @author marcelo
 *
 */
public class Testing {
    private Classifier classifier;
    private Instances testDataSet;

    /**
     * Constructor
     * 
     * @param classifier Classifier used to test the {@code testDataSet}
     * @param testDataset Instances will be tested
     */
    public Testing(Classifier classifier, Instances testDataset){
	this.classifier=classifier;
	this.testDataSet=testDataset;
    }

    /**
     * Generates the score of the instances presented in Testing object.
     * The scores is calculated using log(probability_class_1 / probability_class_2)
     * @return prediction score
     * @throws Exception
     */
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
