package com.marcelodamasceno.experiments;

import weka.classifiers.Classifier;
import weka.classifiers.lazy.IBk;
import weka.classifiers.meta.Bagging;

public class MyBagging extends com.marcelodamasceno.experiments.Classifier {

    public MyBagging (Classifier classifier) {
	super(classifier);	
    }
    /**
     * @param args
     */
    public static void main(String[] args) {
	Bagging bagging = new Bagging();
	bagging.setClassifier(new IBk(5));
	bagging.setNumIterations(6);
	
	
	MyBagging mybagg = new MyBagging(bagging);
	mybagg.executeInterpolationCancelaveis("Incorrect");
	// knn.executeExperiments("EER");
	// knn.executeBioHashingCancelaveis("EER");
	// knn.executeBioHashingCancelaveis("Incorrect");
	// knn.executeBioConvolvingCancelaveis("EER");
	// knn.executeBioConvolvingCancelaveis("Incorrect");
	// knn.executeDoubleSumCancelaveis("EER");
	// knn.executeDoubleSumCancelaveis("Incorrect");

    }

}
