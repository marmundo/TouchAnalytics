package com.marcelodamasceno.experiments;

import javax.sound.sampled.LineUnavailableException;

import com.marcelodamasceno.util.Alarm;

import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.SMO;
import weka.classifiers.lazy.IBk;
import weka.classifiers.meta.Vote;

/**
 * Class which performs the Voting Experiments
 * 
 * @author marcelo
 * 
 */
public class MyVoting extends com.marcelodamasceno.experiments.Classifier {

    /**
     * @param classifier
     */
    public MyVoting(Classifier classifier) {
	super(classifier);
    }

    /**
     * @param args
     */
    /**
     * @param args
     */
    public static void main(String[] args) throws LineUnavailableException {
	Vote voteClassifier = new Vote();
	Classifier[] classifiers = new Classifier[] { new IBk(5), new IBk(5), new SMO(), new SMO(),
		new NaiveBayes(),new NaiveBayes() };

	// Classifier[] classifiers = new Classifier[]{new NaiveBayes(), new
	// SMO(), bagging};

	voteClassifier.setClassifiers(classifiers);

	MyVoting myvoting = new MyVoting(voteClassifier);

	/* Original */

	

	//myvoting.executeOriginal("EER", "IntraSession");
	//myvoting.executeOriginal("Incorrect", "IntraSession");

	/* Interpolation */

	// myvoting.executeInterpolationCancelaveis("EER");
	// myvoting.executeInterpolationCancelaveis("Incorrect");

//	 myvoting.executeInterpolationCancelaveis("EER", "IntraSession");
//	 myvoting.executeInterpolationCancelaveis("Incorrect","IntraSession");

	/* BioHashing */
	// myvoting.executeBioHashingCancelaveis("EER");
	// myvoting.executeBioHashingCancelaveis("Incorrect");

//	 myvoting.executeBioHashingCancelaveis("EER", "IntraSession");
//	 myvoting.executeBioHashingCancelaveis("Incorrect", "IntraSession");

	/* BioConvolving */
//	 myvoting.executeBioConvolvingCancelaveis("EER");
	// myvoting.executeBioConvolvingCancelaveis("Incorrect");

// myvoting.executeBioConvolvingCancelaveis("EER", "IntraSession");
//	 myvoting.executeBioConvolvingCancelaveis("Incorrect","IntraSession");

	/* Double Sum */
	// myvoting.executeDoubleSumCancelaveis("EER");
	// myvoting.executeDoubleSumCancelaveis("Incorrect");

	 myvoting.executeDoubleSumCancelaveis("EER", "IntraSession");
//	 myvoting.executeDoubleSumCancelaveis("Incorrect", "IntraSession");

	 Alarm.play();
    }

}
