package com.marcelodamasceno.methodology;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

import weka.classifiers.Classifier;
import weka.classifiers.lazy.IBk;
import weka.core.Instances;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Const;
import com.marcelodamasceno.util.InstancesUtils;
import com.marcelodamasceno.util.Utils;


public class Main {

    ArffConector arff;
    String datasetFolder=Const.DATASETPATH;


    public void Experiment(){
	scrollingExperiment();
	horizontalExperiment();
    }

    public void horizontalExperiment(){
	generateTrainingandTestDataSet(Const.HORIZONTAL);
    }

    public void scrollingExperiment(){
	generateTrainingandTestDataSet(Const.SCROOLING);
    }

    private Instances getDataSet(String orientation){
	Instances dataset=null;
	if(orientation==Const.SCROOLING){
	    try {
		dataset=arff.openDataSet(datasetFolder+Const.ORIGINALSCROOLINGFILENAME);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	}else{
	    try {
		dataset=arff.openDataSet(datasetFolder+Const.ORIGINAHORIZONTALFILENAME);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	}
	return dataset;
    }

    private void generateTrainingandTestDataSet(String orientation){	
	arff=new ArffConector();	

	for(int user=1;user<=41;user++){
	    Instances copydataset=getDataSet(orientation);		
	    ArrayList<Instances> trainingTest=InstancesUtils.getTrainingandTestDataSet(copydataset, String.valueOf(user));		
	    Instances trainingDataset=trainingTest.get(0);
	    //Changing the class Value to only "positive" and "negative"
	    List<String> values = new ArrayList<String>(3); 
	    values.add("positive"); 
	    values.add("negative");		 
	    trainingDataset=InstancesUtils.changeClassAttribute(trainingDataset, values);
	    arff.save(trainingDataset, Const.PROJECTPATH+"/Norman Methodology/"+orientation+"/Original/User_"+user+"/", "training.arff");

	    Instances testDataset=trainingTest.get(1);		
	    testDataset=InstancesUtils.changeClassAttribute(testDataset, values);
	    arff.save(testDataset, Const.PROJECTPATH+"/Norman Methodology/"+orientation+"/Original/User_"+user+"/", "testing.arff");
	}

    }


    public Classifier train(Classifier classifier, Instances trainingDataset){
	Training training=new Training(new IBk(5),trainingDataset);
	return training.train();
    }

    public ArrayList<Double> teste(Classifier trainedClassifier, Instances testDataset){
	Testing testing=new Testing(trainedClassifier, testDataset);
	try {
	    return testing.getScores();	    
	} catch (Exception e) {
	    e.printStackTrace();
	}
	return null;
    }


    public static void main(String[] args){
	Main sub=new Main();
	//sub.Experiment();
	ArrayList<ArrayList<Double>> scoreMatrix=new ArrayList<ArrayList<Double>>();
	ArffConector arff=new ArffConector();
	Instances training;
	for(int user=1;user<=1;user++){
	    System.out.println("Experiment User "+user);
	    try {
		training = arff.openDataSet(Const.PROJECTPATH+"/Norman Methodology/Scrolling/Original/User_"+user+"/training.arff");
		System.out.println("Training");
		Classifier trainedClass=sub.train(new IBk(5), training);
		
		Instances testing=arff.openDataSet(Const.PROJECTPATH+"/Norman Methodology/Scrolling/Original/User_"+user+"/testing.arff");
		System.out.println("Testing");
		
		System.out.println("Generating Client ScoreMatrix");
		Instances clientInstances=InstancesUtils.getInstances(training, "positive");
		ArrayList<Double> userScoreMatrix=sub.teste(trainedClass, clientInstances);		
		Utils.writeToFile("KNN_Original_Client_ScoreMatrix_User_"+user, userScoreMatrix);
		scoreMatrix.add(userScoreMatrix);
		
		System.out.println("Generating Impostor ScoreMatrix");
		userScoreMatrix=sub.teste(trainedClass, testing);		
		Utils.writeToFile("KNN_Original_Impostor_ScoreMatrix_User_"+user, userScoreMatrix);
		scoreMatrix.add(userScoreMatrix);
		
	    } catch (FileNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	    }
	}	
	
    }


}
