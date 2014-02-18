package com.marcelodamasceno.experiments;

import weka.classifiers.Classifier;
import weka.classifiers.lazy.IBk;

/**
 * Class that implements KNN
 * @author marcelo
 *
 */
public class KNN extends com.marcelodamasceno.experiments.Classifier {

    public KNN(Classifier classifier) {
	super(classifier);
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
	Classifier classifier = new IBk(5);
	KNN knn = new KNN(classifier);
	knn.executeInterpolationCancelaveis("Incorrect");
	// knn.executeExperiments("EER");
	// knn.executeBioHashingCancelaveis("EER");
	// knn.executeBioHashingCancelaveis("Incorrect");
	// knn.executeBioConvolvingCancelaveis("EER");
	// knn.executeBioConvolvingCancelaveis("Incorrect");
	// knn.executeDoubleSumCancelaveis("EER");
	// knn.executeDoubleSumCancelaveis("Incorrect");
    }

}
