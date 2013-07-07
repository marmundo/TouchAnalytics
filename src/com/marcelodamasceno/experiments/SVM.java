package com.marcelodamasceno.experiments;


import weka.classifiers.Classifier;
import weka.classifiers.functions.SMO;



public class SVM extends com.marcelodamasceno.experiments.Classifier{

    public SVM(Classifier classifier) {
 	super(classifier);
     }

     /**
      * @param args
      */
     public static void main(String[] args) {
 	Classifier classifier = new SMO();
 	SVM svm = new SVM(classifier);
 	svm.executeInterpolationCancelaveis("EER");
 	// knn.executeExperiments("EER");
 	// knn.executeBioHashingCancelaveis("EER");
 	// knn.executeBioHashingCancelaveis("Incorrect");
 	// knn.executeBioConvolvingCancelaveis("EER");
 	// knn.executeBioConvolvingCancelaveis("Incorrect");
 	// knn.executeDoubleSumCancelaveis("EER");
 	// knn.executeDoubleSumCancelaveis("Incorrect");
     }

}
