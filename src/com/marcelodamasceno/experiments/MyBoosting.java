package com.marcelodamasceno.experiments;

import weka.classifiers.Classifier;
import weka.classifiers.functions.SMO;
import weka.classifiers.meta.AdaBoostM1;

/**
 * Class which performs the Boosting Experiments
 * 
 * @author marcelo
 * 
 */
public class MyBoosting extends com.marcelodamasceno.experiments.Classifier {

    /**
     * @param classifier
     */
    public MyBoosting(Classifier classifier) {
	super(classifier);
    }

    /**
     * @param args
     */
    /**
     * @param args
     */
    public static void main(String[] args) {
	AdaBoostM1 adaBoost = new AdaBoostM1();
	adaBoost.setClassifier(new SMO());
	adaBoost.setNumIterations(1000);
	
	MyBoosting myboost = new MyBoosting(adaBoost);

	/* Original */

	// myboost.executeOriginal("EER");
	// myboost.executeOriginal("Incorrect");

	// myboost.executeOriginal("EER", "IntraSession");
	// myboost.executeOriginal("Incorrect", "IntraSession");

	/* Interpolation */

	// myboost.executeInterpolationCancelaveis("EER");
	// myboost.executeInterpolationCancelaveis("Incorrect");

	// myboost.executeInterpolationCancelaveis("EER", "IntraSession");
	// myboost.executeInterpolationCancelaveis("Incorrect", "IntraSession");

	/* BioHashing */
	// myboost.executeBioHashingCancelaveis("EER");
	// myboost.executeBioHashingCancelaveis("Incorrect");

	// myboost.executeBioHashingCancelaveis("EER", "IntraSession");
	// myboost.executeBioHashingCancelaveis("Incorrect", "IntraSession");

	/* BioConvolving */
	// myboost.executeBioConvolvingCancelaveis("EER");
	// myboost.executeBioConvolvingCancelaveis("Incorrect");

	// myboost.executeBioConvolvingCancelaveis("EER", "IntraSession");
	// myboost.executeBioConvolvingCancelaveis("Incorrect", "IntraSession");

	/* Double Sum */
	// myboost.executeDoubleSumCancelaveis("EER");
	// myboost.executeDoubleSumCancelaveis("Incorrect");

	myboost.executeDoubleSumCancelaveis("EER", "IntraSession");
	myboost.executeDoubleSumCancelaveis("Incorrect", "IntraSession");

    }

}
