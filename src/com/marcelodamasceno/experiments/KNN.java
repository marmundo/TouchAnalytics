package com.marcelodamasceno.experiments;

import com.marcelodamasceno.util.Alarm;

import weka.classifiers.Classifier;
import weka.classifiers.lazy.IBk;
import static com.marcelodamasceno.util.Const.*;

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
	knn.executeInterpolationCancelaveis(INCORRECT);
	// knn.executeExperiments(EER);
	// knn.executeBioHashingCancelaveis(EER);
	// knn.executeBioHashingCancelaveis(INCORRECT);
	// knn.executeBioConvolvingCancelaveis(EER);
	// knn.executeBioConvolvingCancelaveis(INCORRECT);
	// knn.executeDoubleSumCancelaveis(EER);
	// knn.executeDoubleSumCancelaveis(INCORRECT);
	
	try {
	    Alarm.play();
	} catch (final Exception e) {
	    System.err.println("The sound is unable!");
	}
    }

}
