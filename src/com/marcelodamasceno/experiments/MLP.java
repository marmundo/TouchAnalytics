package com.marcelodamasceno.experiments;

import weka.classifiers.Classifier;
import weka.classifiers.functions.MultilayerPerceptron;
import static com.marcelodamasceno.util.Const.*;

/**
 * Class that implements MLP
 * 
 * @author marcelo
 *
 */
public class MLP extends com.marcelodamasceno.experiments.Classifier {
    
    public MLP(Classifier classifier) {
	super(classifier);
    }

    public static void main(String[] args) {
	Classifier classifier = new MultilayerPerceptron();
	MLP mlp = new MLP(classifier);
	mlp.executeOriginal(INCORRECT, INTERSESSION);
	//mlp.executeInterpolationCancelaveis("Incorrect");
	// mlp.executeExperiments("EER");
	// mlp.executeBioHashingCancelaveis("EER");
	// mlp.executeBioHashingCancelaveis("Incorrect");
	// mlp.executeBioConvolvingCancelaveis("EER");
	// mlp.executeBioConvolvingCancelaveis("Incorrect");
	// mlp.executeDoubleSumCancelaveis("EER");
	// mlp.executeDoubleSumCancelaveis("Incorrect");

    }

}  
