package com.marcelodamasceno.ensemble;



import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;

import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.lazy.IBk;
import weka.classifiers.trees.J48;
import weka.core.Instances;

public class Ensemble {

    public static void main (String [] args) throws Exception{
	IBk ib4 = new IBk(4);
	IBk ib10 = new IBk(10);
	J48 j48 = new J48();
	NaiveBayes naive = new NaiveBayes();

	Instances instances = new Instances(new FileReader(new File("iris.arff")));

	Ensemble e = new Ensemble(instances, 10);
	Classifier [] classifiers = new Classifier[]{ib4, ib10, j48, naive};
	String [] classifiersParamenters = new String [] {"", "", "", ""}; // default

	//TODO: What this attributes attribute controls?
	boolean [][] attributes = new boolean [][]{{true,true,true,true},{true,true,true,true},{true,true,true,true},{true,true,true,true}}; // todos os atributos ativos
	e.evaluate(classifiers, classifiersParamenters, attributes);

	for (int i = 0; i <e.output.length; i++) {
	    System.out.println(e.output()[i]); // resultado voto // soma dos folds
	}


    }

    protected int folds;
    //TODO: what the information that output array stores in each index?
    /*output[0] = instances.numInstances()?
    output[1] stores how many classifiers made the predictions in a wrong class
    output[2] stores how many votes was set to the right class index when the voting method wrong
    In the end of software the output receives [6,9,4]. It is wrong the assumption that output[0]
    is the number of instances*/ 
    protected double[] output;

    private Instances instances;

    public Ensemble(Instances arff, int folds) throws FileNotFoundException, IOException {
	this.instances = arff;
	this.instances.setClassIndex(this.instances.numAttributes() - 1);
	this.folds = folds;
	this.output = new double[3];
    }

    public void evaluate(Classifier[] classifiers, String[] parans, boolean[][] attributes) throws Exception {

	boolean isValid = false;
	//Verify if all classifiers objects in classifiers array is not null
	for(int i=0;i<classifiers.length;i++)
	    isValid = isValid || classifiers[i] != null;
	if(!isValid){
	    output[0] = instances.numInstances();
	    output[1] = 0.0;
	    output[2] = instances.numInstances() * classifiers.length;
	    return;
	}

	//Balanced stratification based on number of folds
	instances.stratify(folds);

	//Stores the quantity of votes that a [,c] class received in a [i,] instance
	//P.e: votes[1,2]=4 means 4 classifiers set the instance 1 as a class belonged in the class index 2
	//Remember that weka uses the class index ( classes(a,b,c), prediction of class a:index 0
	int[][] votes = new int[instances.numInstances()][instances.numClasses()];

	//Separating a training and test dataset for each fold of crossvalidation
	//Each column of row 0 has a training Instances for fold i
	//Each column of row 1 has a test Instances for fold i
	Instances[][] cross = new Instances[2][folds];
	for (int i = 0; i < folds; i++) {
	    cross[0][i] = instances.trainCV(folds, i);
	    cross[1][i] = instances.testCV(folds, i);
	}

	int testInstanceNumber = 0;
	for (int fold = 0; fold < folds; fold++) {
	    //for each fold, train and test all classifiers in classifiers array
	    for (int c = 0; c < classifiers.length; c++) {
		if (classifiers[c] != null) {

		    Instances train = new Instances(cross[0][fold]);
		    Instances test = new Instances(cross[1][fold]);

		    //TODO: undestand what the function of attributes matrix
		    for (int i = instances.numAttributes() - 2; i > 0; i--) {
			if (!attributes[c][i]) {
			    train.deleteAttributeAt(i);
			    test.deleteAttributeAt(i);
			}
		    }

		    //Training the classifier with training dataset colected in cross-fold object
		    if (train.numAttributes() > 1) {
			classifiers[c].buildClassifier(train);
			for (int i = 0; i < test.numInstances(); i++) {
			    //set 1 to the class index position in votes object. 
			    //P.e: vote matrix receives a 1 in column at the same index classifyInstance().  
			    //classifyInstance returns the class index predicted by classifier

			    votes[testInstanceNumber + i][(int) classifiers[c].classifyInstance(test.get(i))]++;
			}
		    }
		}
	    }
	    testInstanceNumber += cross[1][fold].numInstances();
	}

	Arrays.fill(output, 0);
	output[0] = instances.numInstances();
	//check if a classifier is null. If yes, inactives++
	int inactives = 0;
	for (int i = 0; i < classifiers.length; i++)
	    if (classifiers[i] == null)
		inactives++;

	testInstanceNumber = 0;
	//cross[1][j] is test dataset of fold j 
	for (int i = 0; i < folds; i++) {
	    for (int j = 0; j < cross[1][i].numInstances(); j++) {
		//y store the classValue of instance j of test set-fold i
		int classIndex = (int) cross[1][i].get(j).classValue();

		//majorityVoteIndex is the index of class which receives more votes (majority vote)
		int majorityVoteIndex = 0;
		for (int k = 0; k < instances.numClasses(); k++)
		    if (votes[testInstanceNumber][k] > votes[testInstanceNumber][majorityVoteIndex])
			majorityVoteIndex = k;

		//check if the majority vote index is the same of classindex
		if (classIndex == majorityVoteIndex) {
		    //votes[testInstanceNumber][classIndex]= how many votes the real class receives
		    //output[1] stores how many classifiers made the predictions in a wrong class
		    output[1] += (classifiers.length - inactives) - votes[testInstanceNumber][classIndex];
		    output[0]--;
		} else {
		    //output[2] stores how many votes was set to the right class index when the voting method wrong
		    output[2] += votes[testInstanceNumber][classIndex];
		}
		testInstanceNumber++;
	    }
	}
    }

    public double[] output() {
	return output;
    }
}
