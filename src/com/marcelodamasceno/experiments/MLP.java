package com.marcelodamasceno.experiments;

import com.marcelodamasceno.util.Alarm;
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
     
    
    public MLP(final Classifier classifier) {
	super(classifier);
    }

    /**
     * @param args
     */
    public static void main(final String[] args) {
	System.out.println("Starting...");
	
	/*Weka MultiLayer Perceptron */
	MultilayerPerceptron mlpWeka = new MultilayerPerceptron();
	
	/*MLP Configuration */
	/*
	mlpWeka.setHiddenLayers("a");
	mlpWeka.setLearningRate(0.2);
	mlpWeka.setMomentum(0.3);
	mlpWeka.setSeed(0);
	mlpWeka.setTrainingTime(500);
	*/
	
	MLP mlp = new MLP(mlpWeka);
	/*
	 * ArffConector conector = new ArffConector();
	 * 
	 * Instances scrolling; try { System.out.println("Abrindo dataset...");
	 * scrolling = conector.openDataSet(PROJECTPATH + "InterSession/" +
	 * "InterSession-User_" + 1 + "_Day_1_Scrolling.arff");
	 * System.out.println("Treinando...");
	 * classifier.buildClassifier(scrolling); Evaluation eTest= new
	 * Evaluation(scrolling); System.out.println("Avaliando...");
	 * eTest.evaluateModel(classifier, scrolling);
	 * 
	 * String strSummary = eTest.toSummaryString();
	 * System.out.println(strSummary);
	 * 
	 * // Get the confusion matrix double[][] cmMatrix =
	 * eTest.confusionMatrix(); } catch (Exception e) { // TODO
	 * Auto-generated catch block e.printStackTrace(); }
	 */

	// mlp.executeOriginal(INCORRECT, INTERSESSION);
	mlp.executeInterpolationCancelaveis(INCORRECT);
	// mlp.executeExperiments("EER");
	// mlp.executeBioHashingCancelaveis("EER");
	// mlp.executeBioHashingCancelaveis("Incorrect");
	// mlp.executeBioConvolvingCancelaveis("EER");
	// mlp.executeBioConvolvingCancelaveis("Incorrect");
	// mlp.executeDoubleSumCancelaveis("EER");
	// mlp.executeDoubleSumCancelaveis("Incorrect");

	try {
	    Alarm.play();
	} catch (final Exception e) {
	    System.err.println("Não possível tocar o som!");
	}

    }

}
