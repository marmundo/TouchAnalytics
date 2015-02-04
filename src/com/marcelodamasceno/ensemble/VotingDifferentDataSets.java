package com.marcelodamasceno.ensemble;

import weka.core.Utils;

import com.marcelodamasceno.util.Const;



/**
 * @author marcelo
 *
 */
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

	String path=Const.PROJECTPATH+"Cancelaveis/";
	int count=0;
	for (String dataset : datasets) {
	    path+=dataset+"/IntraSession/IntraSession-User_"+user+"_Day_1_"+orientation+".arff ";
	    options+=classifiers[count]+" -t "+path;
	    path=Const.PROJECTPATH+"Cancelaveis/";
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
	    //String[] classifierOptions=options.split(" ");
	    callExperiment(classifierOptions);
	}
    }

    /**
     * Method to fill a array with the cancelable datasets when the number of cancelable 
     * datasets is inferior the number of classifier
     * @param cancelable name of cancelable functions
     * @param nClassifiers number of classifiers
     * @return
     */
    private String[] fillClassifiersArray(String[]cancelable,int nClassifiers){
	if(cancelable.length==nClassifiers){
	    return cancelable;
	}else{
	    String[] datasets=new String[nClassifiers];
	    int count=0;
	    for(int i=0;i<nClassifiers;i++){		
		datasets[i]=cancelable[count];
		count++;
		//restart the count because its the end of cancelable array
		if(count==cancelable.length){
		    count=0;
		}
	    }
	    return datasets;
	}
    }


    /**
     * Methods combines 2 datasets per experiment
     * @param orientation Stroke Orientation
     * @param classifiers Used Classifiers
     * @throws Exception
     */
    public void combination2per2(String orientation, String[] classifiers) throws Exception{
	String[]cancelableDataSets=new String[2];
	int nClassifiers=classifiers.length;
	String[] votingDataSets=null;
	
	//INTERPOLATION-DOUBLESUM	
	
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.DOUBLESUM;
	
	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);

	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);

	//INTERPOLATION-BIOCONVOLVING
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.BIOCONVOLVING;

	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);

	//INTERPOLATION-BIOHASHING
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.BIOHASHING;

	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);

	//DOUBLESUM-BIOCONVOLVING
	cancelableDataSets[0]=Const.DOUBLESUM;
	cancelableDataSets[1]=Const.BIOCONVOLVING;

	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);

	//DOUBLESUM-BIOHASHING
	cancelableDataSets[0]=Const.DOUBLESUM;
	cancelableDataSets[1]=Const.BIOHASHING;

	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);

	//BIOCONVOLVING-BIOHASHING
	cancelableDataSets[0]=Const.BIOCONVOLVING;
	cancelableDataSets[1]=Const.BIOHASHING;

	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);
    }


    /**
     * Methods combines 3 datasets per experiment
     * @param orientation Stroke Orientation
     * @param classifiers Used Classifiers
     * @throws Exception
     */
    public void combination3per3(String orientation, String[] classifiers) throws Exception{
	String[]cancelableDataSets=new String[2];
	int nClassifiers=classifiers.length;
	String[] votingDataSets=null;
	
	

	//INTERPOLATION-DOUBLESUM-BIOCONVOLVING

	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.DOUBLESUM;
	cancelableDataSets[2]=Const.BIOCONVOLVING;

	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);

	//INTERPOLATION-DOUBLESUM-BIOHASHING
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.DOUBLESUM;
	cancelableDataSets[2]=Const.BIOHASHING;

	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);

	//INTERPOLATION-BIOCONVOLVING-BIOHASHING
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.BIOCONVOLVING;
	cancelableDataSets[2]=Const.BIOHASHING;

	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);

	//DOUBLESUM-BIOCONVOLVING-BIOHASHING
	cancelableDataSets[0]=Const.DOUBLESUM;
	cancelableDataSets[1]=Const.BIOCONVOLVING;
	cancelableDataSets[2]=Const.BIOHASHING;		

	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);


    }

    /**
	 * Methods combines 4 datasets per experiment
	 * @param orientation Stroke Orientation
	 * @param classifiers Used Classifiers
	 * @throws Exception
	 */
    public void combination4per4(String orientation, String[]classifiers) throws Exception{

	String[]cancelableDataSets=new String[4];
	int nClassifiers=classifiers.length;
	String[] votingDataSets=null;
	
	//INTERPOLATION-DOUBLESUM-BIOCONVOLVING
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.DOUBLESUM;
	cancelableDataSets[2]=Const.BIOCONVOLVING;
	cancelableDataSets[3]=Const.BIOHASHING;
	
	votingDataSets=fillClassifiersArray(cancelableDataSets, nClassifiers);

	if(orientation.equals(Const.HORIZONTAL))	
	    HorizontalExperiment(votingDataSets, classifiers);
	else
	    ScroolingExperiment(votingDataSets, classifiers);


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
	
	String[]classifiers = new String[4];
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	teste.combination2per2(orientation,classifiers);
	
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	classifiers[2]=Const.DECISIONTREE;
	teste.combination3per3(orientation,classifiers);
	
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	classifiers[2]=Const.DECISIONTREE;
	classifiers[3]=Const.MLP;
	teste.combination4per4(orientation,classifiers);
	
	orientation=Const.SCROOLING;
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	teste.combination2per2(orientation,classifiers);
	
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	classifiers[2]=Const.DECISIONTREE;
	teste.combination3per3(orientation,classifiers);
	
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	classifiers[2]=Const.DECISIONTREE;
	classifiers[3]=Const.MLP;
	teste.combination4per4(orientation,classifiers);
    }


}
