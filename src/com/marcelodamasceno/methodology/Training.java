package com.marcelodamasceno.methodology;

import java.util.ArrayList;

import com.marcelodamasceno.util.InstancesUtils;
import com.marcelodamasceno.util.Utils;

import weka.classifiers.Classifier;
import weka.core.Instances;


public class Training {
    
    Classifier classifier;
    Instances trainingDataSet;
    String[] trainingUsers;
    
    public String[] getTrainingUsers() {
        return trainingUsers;
    }

    public void setTrainingUsers(String[] trainingUsers) {
        this.trainingUsers = trainingUsers;
    }

    public Training(Instances dataset){
	this.trainingDataSet=dataset;
   	trainingUsers=new String[trainingDataSet.classAttribute().numValues()/2+1];
       }
    public Training(Classifier classifier, Instances trainingDataset){
	this.classifier=classifier;
	this.trainingDataSet=trainingDataset;
	trainingUsers=new String[trainingDataSet.classAttribute().numValues()/2+1];
    }
    
    public Classifier train(){
	try {
	    classifier.buildClassifier(trainingDataSet);
	} catch (Exception e) {	    
	    e.printStackTrace();
	}
	return classifier;
    }
    
    public Instances takeTrainingDataSet(Instances datasetTemp, String targetUser){
	ArrayList<String> trainingUsersList=new ArrayList<String>();
	Instances temp=InstancesUtils.getInstances(datasetTemp, targetUser);
	Instances training=InstancesUtils.changeClassLabel(temp,targetUser,"positive");
	int targetUserInt=Integer.valueOf(targetUser);
	int quantityClassValues=datasetTemp.classAttribute().numValues();
	int count=1;
	trainingUsersList.add(targetUser);
	while(count!=(quantityClassValues-1)/2){
	    if(count!=targetUserInt){
		temp=InstancesUtils.getInstances(datasetTemp, String.valueOf(count));
		temp=InstancesUtils.changeClassLabel(temp,String.valueOf(count),"negative");
		training.addAll(temp);
	    }
	    trainingUsersList.add(String.valueOf(count));
	    count++;
	}
	setTrainingUsers(Utils.stringArrayListToStringArray(trainingUsersList));	
	return training;
    }

    
}
