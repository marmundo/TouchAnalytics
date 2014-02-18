package com.marcelodamasceno.experiments;

import com.marcelodamasceno.util.Alarm;
import com.marcelodamasceno.util.Utils;

import weka.classifiers.Classifier;
import weka.classifiers.functions.SMO;
import weka.classifiers.lazy.IBk;
import weka.classifiers.meta.Bagging;

/**
 * Class which performs the Bagging Experiments
 * 
 * @author marcelo
 * 
 */
public class MyBagging extends com.marcelodamasceno.experiments.Classifier {

    /**
     * @param classifier
     */
    public MyBagging(Classifier classifier) {
	super(classifier);
    }

    /**
     * @param args
     */
    /**
     * @param args
     */
    public static void main(String[] args) {
	Bagging bagging = new Bagging();
	bagging.setClassifier(new SMO());
	// bagging.setClassifier(new IBk(5));
	bagging.setNumIterations(12);

	MyBagging mybagg = new MyBagging(bagging);
	
	/* Original */
	
	// mybagg.executeOriginal("EER");
	// mybagg.executeOriginal("Incorrect");

	mybagg.executeOriginal("EER", "IntraSession");
	mybagg.executeOriginal("Incorrect", "IntraSession");

	
	/* Interpolation*/
	
	
	// mybagg.executeInterpolationCancelaveis("EER");
	// mybagg.executeInterpolationCancelaveis("Incorrect");
	
	//mybagg.executeInterpolationCancelaveis("EER", "IntraSession");
	//mybagg.executeInterpolationCancelaveis("Incorrect", "IntraSession");
	
	/*BioHashing*/	
	// mybagg.executeBioHashingCancelaveis("EER");
	// mybagg.executeBioHashingCancelaveis("Incorrect");

	//mybagg.executeBioHashingCancelaveis("EER", "IntraSession");
	//mybagg.executeBioHashingCancelaveis("Incorrect", "IntraSession");
	
	/*BioConvolving*/
	// mybagg.executeBioConvolvingCancelaveis("EER");
	// mybagg.executeBioConvolvingCancelaveis("Incorrect");

	//mybagg.executeBioConvolvingCancelaveis("EER", "IntraSession");
	//mybagg.executeBioConvolvingCancelaveis("Incorrect", "IntraSession");
	

	/*Double Sum*/
	// mybagg.executeDoubleSumCancelaveis("EER");
	// mybagg.executeDoubleSumCancelaveis("Incorrect");

	//mybagg.executeDoubleSumCancelaveis("EER", "IntraSession");
	//mybagg.executeDoubleSumCancelaveis("Incorrect", "IntraSession");

	Alarm.play();
    }

}
