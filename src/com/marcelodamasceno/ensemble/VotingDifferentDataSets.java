package com.marcelodamasceno.ensemble;

import weka.core.Utils;

import com.marcelodamasceno.util.Const;



public class VotingDifferentDataSets {
	
	
	private int nFolds;

	/**
	 * @param nFolds Quantity of folds in cross validation
	 */
	public VotingDifferentDataSets(int nFolds){
		this.nFolds=nFolds;
	}
	
	public final int nUsers=41;

	private String takeOptions(String[]datasets,String[]classifiers,int user,String orientation){		
		String nameOfFile="";		
		for (String string : datasets) {
			nameOfFile+=string.substring(0, 4);
		}
		nameOfFile+="-User-"+user+"-"+orientation;
		
		String options=nFolds+" "+nameOfFile+"test.arff "+ nameOfFile+"vali.arff "+nameOfFile+"media.txt "+classifiers.length+" ";

		String path="BasedeToque/Cancelaveis/";
		int count=0;
		for (String dataset : datasets) {
			path+=dataset+"/IntraSession/IntraSession-User_"+user+"_Day_1_"+orientation+".arff ";
			options+=classifiers[count]+" -t "+path;
			path="BasedeToque/Cancelaveis/";
			count++;
		}		
		return options;
	}

	
	private void HorizontalExperiment(String[]datasets,String[]classifiers) throws Exception{
		for(int user=1;user<=nUsers;user++){
			String options=takeOptions(datasets, classifiers, user, Const.HORIZONTAL);
			String[] classifierOptions=Utils.splitOptions(options);
			callExperiment(classifierOptions);
		}
	}
	
	private void ScroolingExperiment(String[]datasets,String[]classifiers) throws Exception{
		for(int user=1;user<=nUsers;user++){
			String options=takeOptions(datasets, classifiers, user, Const.SCROOLING);
			String[] classifierOptions=Utils.splitOptions(options);
			callExperiment(classifierOptions);
		}
	}
	

	public void combination2per2(String orientation) throws Exception{
		
		String[]classifiers = new String[2];
		classifiers[0]=Const.KNN;
		classifiers[1]=Const.SVM;
		
		String[]datasets = new String[2];	

		//INTERPOLATION-DOUBLESUM
			
		datasets[0]=Const.INTERPOLATION;
		datasets[1]=Const.DOUBLESUM;		
		
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);
		
		//INTERPOLATION-BIOCONVOLVING
		datasets[0]=Const.INTERPOLATION;
		datasets[1]=Const.BIOCONVOLVING;
		
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);

		//INTERPOLATION-BIOHASHING
		datasets[0]=Const.INTERPOLATION;
		datasets[1]=Const.BIOHASHING;
		
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);
		
		//DOUBLESUM-BIOCONVOLVING
		datasets[0]=Const.DOUBLESUM;
		datasets[1]=Const.BIOCONVOLVING;
		
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);
		
		//DOUBLESUM-BIOHASHING
		datasets[0]=Const.DOUBLESUM;
		datasets[1]=Const.BIOHASHING;
		
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);
		
		//BIOCONVOLVING-BIOHASHING
		datasets[0]=Const.BIOCONVOLVING;
		datasets[1]=Const.BIOHASHING;
		
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);
	}
	
	
public void combination3per3(String orientation) throws Exception{
		
		String[]classifiers = new String[3];
		classifiers[0]=Const.KNN;
		classifiers[1]=Const.SVM;
		classifiers[2]=Const.DECISIONTREE;
		String[]datasets = new String[3];

		//INTERPOLATION-DOUBLESUM-BIOCONVOLVING
				
		datasets[0]=Const.INTERPOLATION;
		datasets[1]=Const.DOUBLESUM;
		datasets[2]=Const.BIOCONVOLVING;
		
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);
		
		//INTERPOLATION-DOUBLESUM-BIOHASHING
		datasets[0]=Const.INTERPOLATION;
		datasets[1]=Const.DOUBLESUM;
		datasets[2]=Const.BIOHASHING;
				
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);

		//INTERPOLATION-BIOCONVOLVING-BIOHASHING
		datasets[0]=Const.INTERPOLATION;
		datasets[1]=Const.BIOCONVOLVING;
		datasets[2]=Const.BIOHASHING;
		
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);

		//DOUBLESUM-BIOCONVOLVING-BIOHASHING
		datasets[0]=Const.DOUBLESUM;
		datasets[1]=Const.BIOCONVOLVING;
		datasets[2]=Const.BIOHASHING;		
		
		if(orientation.equals(Const.HORIZONTAL))	
			HorizontalExperiment(datasets, classifiers);
		else
			ScroolingExperiment(datasets, classifiers);
		
		
	}

public void combination4per4(String orientation) throws Exception{
	
	String[]classifiers = new String[4];
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	classifiers[2]=Const.DECISIONTREE;
	classifiers[3]=Const.MLP;

	//INTERPOLATION-DOUBLESUM-BIOCONVOLVING
	String[]datasets = new String[4];		
	datasets[0]=Const.INTERPOLATION;
	datasets[1]=Const.DOUBLESUM;
	datasets[2]=Const.BIOCONVOLVING;
	datasets[3]=Const.BIOHASHING;
	
	if(orientation.equals(Const.HORIZONTAL))	
		HorizontalExperiment(datasets, classifiers);
	else
		ScroolingExperiment(datasets, classifiers);
	
	
}

public void combination(String[] classifiers, String[] datasets, String orientation) throws Exception{
	if(orientation.equals(Const.HORIZONTAL))	
		HorizontalExperiment(datasets, classifiers);
	else
		ScroolingExperiment(datasets, classifiers);
}

	public void callExperiment(String[]options){
		CallClassifierNEntradas.main(options);
	}
	
	public static void main(String args[]) throws Exception{
		VotingDifferentDataSets teste=new VotingDifferentDataSets(10);
		String orientation="";
		orientation=Const.HORIZONTAL;
		teste.combination2per2(orientation);
		teste.combination3per3(orientation);
		teste.combination4per4(orientation);
		orientation=Const.SCROOLING;
		teste.combination2per2(orientation);
		teste.combination3per3(orientation);
		teste.combination4per4(orientation);
	}


}
