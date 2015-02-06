package com.marcelodamasceno.experiments;

import javax.sound.sampled.LineUnavailableException;

import com.marcelodamasceno.util.Alarm;
import com.marcelodamasceno.util.ClassifierFactory;
import com.marcelodamasceno.util.Const;

import weka.classifiers.AbstractClassifier;
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
	
	/*try {
	    Classifier classifier = AbstractClassifier.forName(Const.SVM,"-C 1.0 -L 0.001 -P 1.0E-12 -N 0 -V -1 -W 1 -K weka.classifiers.functions.supportVector.RBFKernel -G 0.01 -C 250007".split(" "));
	    System.out.println(classifier.getClass().toString());
	} catch (Exception e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}*/
		
	Vote voteClassifier = new Vote();
	
	ClassifierFactory cFactory=new ClassifierFactory();
	Classifier c1=cFactory.getClassifier(Const.KNN,5);
	Classifier c2=cFactory.getClassifier(Const.KNN,5);
	Classifier c3=cFactory.getClassifier(Const.KNN,5);
	
	Classifier[] classifiers = new Classifier[] {c1, c2,c3};

	//Classifier[] classifiers = new Classifier[] { new IBk(5), new IBk(5), new SMO(), new SMO(),new NaiveBayes(),new NaiveBayes() };

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

	// myvoting.executeDoubleSumCancelaveis("EER", "IntraSession");
//	 myvoting.executeDoubleSumCancelaveis("Incorrect", "IntraSession");

	 Alarm.play();
    }

}
