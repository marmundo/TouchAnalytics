package com.marcelodamasceno.experiments;

import java.awt.Toolkit;
import java.io.*;

import com.marcelodamasceno.util.Alarm;

import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.Logistic;
import weka.classifiers.functions.SMO;
import weka.classifiers.lazy.IBk;
import weka.classifiers.meta.Stacking;

/**
 * Class which performs the Stacking Experiments
 * 
 * @author marcelo
 * 
 */
public class MyStacking extends com.marcelodamasceno.experiments.Classifier {

    /**
     * @param classifier
     */
    public MyStacking(Classifier classifier) {
	super(classifier);
    }

    /**
     * @param args
     */
    /**
     * @param args
     */
    public static void main(String[] args) {
	Stacking stacking = new Stacking();
	// Classifier[] classifiers = new Classifier[]{new IBk(5), new
	// NaiveBayes(), new SMO()};
	Classifier[] classifiers = new Classifier[] { new IBk(5), new IBk(5), new SMO(), new SMO(),
		new NaiveBayes(),new NaiveBayes()};
	stacking.setClassifiers(classifiers);
//	stacking.setMetaClassifier(new IBk(5));
	 stacking.setMetaClassifier(new Logistic());

	MyStacking mystack = new MyStacking(stacking);

	/* Original */

//	mystack.executeOriginal("EER", "IntraSession");
//	mystack.executeOriginal("Incorrect", "IntraSession");

	/* Interpolation */

//	 mystack.executeInterpolationCancelaveis("EER", "IntraSession");
//	 mystack.executeInterpolationCancelaveis("Incorrect", "IntraSession");

	/* BioHashing */

//	 mystack.executeBioHashingCancelaveis("EER", "IntraSession");
//	 mystack.executeBioHashingCancelaveis("Incorrect", "IntraSession");

	/* BioConvolving */

//	 mystack.executeBioConvolvingCancelaveis("EER", "IntraSession");
//	 mystack.executeBioConvolvingCancelaveis("Incorrect", "IntraSession");

	/* Double Sum */

	 mystack.executeDoubleSumCancelaveis("EER", "IntraSession");
//	 mystack.executeDoubleSumCancelaveis("Incorrect", "IntraSession");

	try {
	    Alarm.play();   
	} catch (Exception e) {
	    System.err.println("Não possível tocar o som!");
	}
	 

    }

}
