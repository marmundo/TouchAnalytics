package com.marcelodamasceno.ensemble;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Random;

import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.lazy.IBk;
import weka.classifiers.meta.Vote;
import weka.classifiers.trees.J48;
import weka.core.Instances;
import weka.core.Utils;
import weka.core.converters.ConverterUtils.DataSink;
import weka.filters.Filter;
import weka.filters.supervised.attribute.AddClassification;

public class VotingWithDifferentDataSets{    

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    /**
     * Array of classifiers
     */
    private Classifier[] classifiers=null;

    /**
     *Array of DataSets 
     */
    private Instances[] datasets=null;

    /**
     *Array with predicted data using each classifier aplied to dataset 
     */
    Instances[] predictedData = null;

    /**
     *Number of folds of cross validation 
     */
    private int nFolds=10;



    public VotingWithDifferentDataSets(Classifier[] classifiers, Instances[] datasets) throws Exception {
	if(classifiers.length==datasets.length){
	    this.classifiers=classifiers;
	    this.datasets=datasets;
	    setClassIndex(this.datasets);
	}else{
	    throw new Exception("The number of classifiers and datasets must be the same");
	}
    }

    private void setClassIndex(Instances[]datasets){
	for (Instances dataset : datasets) {
	    dataset.setClassIndex(dataset.numAttributes()-1);
	}
    }

    public VotingWithDifferentDataSets(Classifier[] classifiers, Instances[] instances,int nFolds) throws Exception {
	this.classifiers=classifiers;
	this.datasets=instances;
	equalizeClassifiersToInstances();
	this.nFolds=nFolds;
    }

    private void equalizeClassifiersToInstances() throws Exception{
	if(classifiers.length>datasets.length){
	    throw new Exception("The number of classifiers must be less than number of datasets");
	}else{
	    if(datasets.length>classifiers.length){
		for(int size=classifiers.length;size==datasets.length;){

		}
	    }
	}
    }

    private void preProcessCrossValidation() throws Exception{
	for (Instances dataset : datasets) {
	    if (dataset.classAttribute().isNominal())
		dataset.stratify(nFolds);	    
	}

    }

    private Instances getPredictions(Classifier cls,Instances train,Instances test) throws Exception{
	// add predictions
	Instances predictedData = null;
	AddClassification filter = new AddClassification();
	filter.setClassifier(cls);
	filter.setOutputClassification(true);
	filter.setOutputDistribution(true);
	filter.setOutputErrorFlag(true);
	filter.setInputFormat(train);
	Filter.useFilter(train, filter);  // trains the classifier
	Instances pred = Filter.useFilter(test, filter);  // perform predictions on test set
	if (predictedData == null)
	    predictedData = new Instances(pred, 0);
	for (int j = 0; j < pred.numInstances(); j++)
	    predictedData.add(pred.instance(j));
	return predictedData;
    }

   /* private Evaluation votingCrossValidation(Classifier cls,Instances dataset) throws Exception{
	//Balanced stratification based on number of folds
	dataset.stratify(nFolds);

	//Stores the quantity of votes that a [,c] class received in a [i,] instance
	//P.e: votes[1,2]=4 means 4 classifiers set the instance 1 as a class belonged in the class index 2
	//Remember that weka uses the class index ( classes(a,b,c), prediction of class a:index 0
	int[][] votes = new int[dataset.numInstances()][dataset.numClasses()];

	//Separating a training and test dataset for each fold of crossvalidation
	//Each column of row 0 has a training Instances for fold i
	//Each column of row 1 has a test Instances for fold i
	Instances[][] cross = new Instances[2][nFolds];
	for (int i = 0; i < nFolds; i++) {
	    cross[0][i] = dataset.trainCV(nFolds, i);
	    cross[1][i] = dataset.testCV(nFolds, i);
	}	
	
	
    }

    private void printResults(Classifier cls,Instances data,Evaluation eval) throws Exception{
	// output evaluation
	System.out.println();
	System.out.println("=== Setup ===");
	System.out.println("Classifier: " + cls.getClass().getName() + " " + Utils.joinOptions(((NaiveBayes) cls).getOptions()));
	System.out.println("Dataset: " + data.relationName());
	System.out.println("Folds: " + nFolds);	
	System.out.println();
	System.out.println(eval.toSummaryString("=== " + nFolds + "-fold Cross-validation ===", false));

	// output "enriched" dataset
	DataSink.write("Classifier: " + cls.getClass().getName(), predictedData);
    }

    public void train() throws Exception{
	int index=0;	
	for (Classifier classifier : classifiers) {	    
	    classifier.buildClassifier(datasets[index]);	    
	    index++;
	}

    }

    public void evaluate(Classifier clas,Instances dataset){

    }

    public void evaluate(){
	boolean isValid = false;
	//Verify if all classifiers objects in classifiers array is not null
	for(int i=0;i<classifiers.length;i++)
	    isValid = isValid || classifiers[i] != null;
	if(!isValid){
	    output[0] = dataset.numInstances();
	    output[1] = 0.0;
	    output[2] = dataset.numInstances() * classifiers.length;
	    return;
	}
    }


    public static void main(String[] args) throws FileNotFoundException, IOException {

	IBk ib4 = new IBk(4);
	IBk ib10 = new IBk(10);
	J48 j48 = new J48();
	NaiveBayes naive = new NaiveBayes();

	Instances iris = new Instances(new FileReader(new File("iris.arff")));
	Instances[] instances=new Instances[]{iris,iris,iris};


	Classifier [] classifiers = new Classifier[]{ib4, ib10, j48, naive};
	VotingWithDifferentDataSets voting = new VotingWithDifferentDataSets(classifiers,instances);


	//TODO: What this attributes attribute controls?
	boolean [][] attributes = new boolean [][]{{true,true,true,true},{true,true,true,true},{true,true,true,true},{true,true,true,true}}; // todos os atributos ativos
	//e.evaluate(classifiers, classifiersParamenters, attributes);

	for (int i = 0; i <e.output.length; i++) {
	    System.out.println(e.output()[i]); // resultado voto // soma dos folds
	}


    }*/

}
