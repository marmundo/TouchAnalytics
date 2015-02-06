package com.marcelodamasceno.main;

import java.util.ArrayList;

import com.marcelodamasceno.combination.Combination;
import com.marcelodamasceno.combination.Combination2x2;
import com.marcelodamasceno.combination.Combination3x3;
import com.marcelodamasceno.combination.Combination4x4;
import com.marcelodamasceno.ensemble.VotingDifferentDataSets;
import com.marcelodamasceno.util.Alarm;
import com.marcelodamasceno.util.Const;

public class Main {



    /**
     * Method applyes voting decision fusion using homogeneous approach
     * @param classifier Type of Classifier
     * @param nClassifiers Number of Classifiers used
     * @param combination Combination Type: 2,3,4
     * @param orientation Stroke orientation
     * @throws Exception
     */
    private void homogeneusVotingDifferentDatasets(String classifier,int nClassifiers,int combination, String orientation) throws Exception{

	ArrayList<String> classifiers = new ArrayList<String>();	
	//feeding the classifiers arrayList
	for(int i=0;i<nClassifiers;i++){
	    classifiers.add(classifier);
	}
	String[] classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);

	//VotingDifferentDataSets teste=new VotingDifferentDataSets(10);
	Combination comb=null;
	if(combination==2){
	    comb=new Combination2x2();
	    comb.combination(orientation,classifiersArray);
	}else{
	    if(combination==3){
		comb=new Combination3x3();
		comb.combination(orientation,classifiersArray);
	    }else{
		comb=new Combination4x4();
		comb.combination(orientation,classifiersArray);
	    }
	}	
    }
    /**
     * Evaluates the combination of homogeneous voting classifiers
     * @param classifier classifier type
     * @param nClassifiers number of classifiers in ensemble
     * @throws Exception 
     */
    private void homogeneusVotingDifferentDatasets(String classifier, int nClassifiers) throws Exception{
	String orientation="";

	//Horizontal Experiments

	orientation=Const.HORIZONTAL;
	//combination 2x2
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,2,orientation);
	//combination 3x3
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,3,orientation);
	//combination 4x4
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,4,orientation);

	//Scrolling experiments

	orientation=Const.SCROOLING;
	//combination 2x2
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,2,orientation);
	//combination 3x3
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,3,orientation);
	//combination 4x4
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,4,orientation);
    }

    private void executeExperiment(String classifier,String orientation) throws Exception{
	Combination comb=null;

	ArrayList<String> classifiers = new ArrayList<String>();

	classifiers.add(classifier);
	classifiers.add(classifier);
	String[] classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);
	comb = new Combination2x2();
	comb.combination(orientation, classifiersArray);


	classifiers.add(classifier);
	classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);
	comb = new Combination3x3();
	comb.combination(orientation, classifiersArray);


	classifiers.add(classifier);
	classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);
	comb = new Combination4x4();
	comb.combination(orientation, classifiersArray);

	classifiers.clear();
    }

    /**
     * Method applyes voting decision fusion using homogeneous approach
     * @param classifier Type of Classifier
     * @throws Exception
     */
    private void homogeneusVotingDifferentDatasets(String classifier) throws Exception{
	//VotingDifferentDataSets teste=new VotingDifferentDataSets(10);
	String orientation="";
	
	//Horizontal
	orientation=Const.HORIZONTAL;
	executeExperiment(classifier, orientation);


	orientation=Const.SCROOLING;
	executeExperiment(classifier, orientation);	
    }


    /**
     * Example of code
     * @param args
     */
    public static void main(String[] args){	
	Main main=new Main();
	try{
	    //main.homogeneusVotingDifferentDatasets(Const.SVM_GAMMA_0_01);	    
	    //main.homogeneusVotingDifferentDatasets(Const.SVM_GAMMA_0_01,5);
	    int k=3;
	    String knn_k=Const.KNN+" -K "+k;
	    //main.homogeneusVotingDifferentDatasets(knn_k, 5, 4,Const.HORIZONTAL);
	    main.homogeneusVotingDifferentDatasets(knn_k, 5);

	}catch(Exception e){
	    e.printStackTrace();
	}
	long t= System.currentTimeMillis();
	long end = t+15000;
	while(System.currentTimeMillis() < end) {
	    Alarm.play();
	}
    }



}
