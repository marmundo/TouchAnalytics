package com.marcelodamasceno.experiments;

import weka.classifiers.Classifier;
import weka.classifiers.functions.SMO;

public class SVM extends com.marcelodamasceno.experiments.Classifier {

    public SVM(Classifier classifier) {
	super(classifier);
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
	Classifier classifier = new SMO();
	SVM svm = new SVM(classifier);
	// svm.executeInterpolationCancelaveis("EER");
	// svm.executeInterpolationCancelaveis("Incorrect");
	// svm.executeExperiments("EER");
	// svm.executeBioHashingCancelaveis("EER");
	// svm.executeBioHashingCancelaveis("Incorrect");
	// svm.executeBioConvolvingCancelaveis("EER");
	// svm.executeBioConvolvingCancelaveis("Incorrect");
	// svm.executeDoubleSumCancelaveis("EER");
	// svm.executeDoubleSumCancelaveis("Incorrect");
	svm.executeOriginal("Incorrect");
    }

}
