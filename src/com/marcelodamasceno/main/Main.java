package com.marcelodamasceno.main;

import java.util.ArrayList;

import com.marcelodamasceno.ensemble.VotingDifferentDataSets;
import com.marcelodamasceno.util.Alarm;
import com.marcelodamasceno.util.Const;

public class Main {

    
    
    private void homogeneusVotingDifferentDatasets(String classifier,int nClassifiers,int combination, String orientation) throws Exception{
		
	ArrayList<String> classifiers = new ArrayList<String>();	
	//feeding the classifiers arrayList
	for(int i=0;i<nClassifiers;i++){
	    classifiers.add(classifier);
	}
	String[] classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);

	VotingDifferentDataSets teste=new VotingDifferentDataSets(10);

	if(combination==2){
	    teste.combination2per2(orientation,classifiersArray);
	}else{
	    if(combination==3){
		teste.combination3per3(orientation,classifiersArray);
	    }else{
		teste.combination4per4(orientation,classifiersArray);
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
	//combination 2x2
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,3,orientation);
	//combination 2x2
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,4,orientation);

	//Scrolling experiments

	orientation=Const.SCROOLING;
	//combination 2x2
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,2,orientation);
	//combination 2x2
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,3,orientation);
	//combination 2x2
	homogeneusVotingDifferentDatasets(classifier,nClassifiers,4,orientation);
    }
    
    private void homogeneusVotingDifferentDatasets(String classifier) throws Exception{
	VotingDifferentDataSets teste=new VotingDifferentDataSets(10);
	String orientation="";
	orientation=Const.HORIZONTAL;
	
	ArrayList<String> classifiers = new ArrayList<String>();
	
	classifiers.add(classifier);
	classifiers.add(classifier);
	String[] classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);
	teste.combination2per2(orientation,classifiersArray);
	
	
	classifiers.add(classifier);
	classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);
	teste.combination3per3(orientation,classifiersArray);
	
	
	classifiers.add(classifier);
	classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);
	teste.combination4per4(orientation,classifiersArray);
	
	classifiers.clear();
	
	orientation=Const.SCROOLING;
	
	classifiers.add(classifier);
	classifiers.add(classifier);
	classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);
	teste.combination2per2(orientation,classifiersArray);
	
	
	classifiers.add(classifier);
	classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);
	teste.combination3per3(orientation,classifiersArray);
	
	
	classifiers.add(classifier);
	classifiersArray=(String[]) classifiers.toArray(new String[classifiers.size()]);
	teste.combination4per4(orientation,classifiersArray);
	
    }
    
    
    public static void main(String[] args){	
	Main main=new Main();
	try{
	    //main.homogeneusVotingDifferentDatasets(Const.SVM_GAMMA_0_01);	    
	    //main.homogeneusVotingDifferentDatasets(Const.SVM_GAMMA_0_01,5);
	    int k=5;
	    String knn_k=Const.KNN+" -K "+k;
	    main.homogeneusVotingDifferentDatasets(knn_k, 5, 4,Const.HORIZONTAL);
	    
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
