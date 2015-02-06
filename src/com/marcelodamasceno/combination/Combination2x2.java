package com.marcelodamasceno.combination;

import com.marcelodamasceno.util.Const;

public class Combination2x2 extends Combination{

    
    
   public Combination2x2(){
       super(10);
   }
    /**
     * Methods combines 2 datasets per experiment
     * @param orientation Stroke Orientation
     * @param classifiers Used Classifiers
     * @throws Exception
     */
    public void combination(String orientation, String[] classifiers) throws Exception{
	String[]cancelableDataSets=new String[2];
	int nClassifiers=classifiers.length;
	String[] votingDataSets=null;
	
	String cancelableName="";
	
	//INTERPOLATION-DOUBLESUM	
	
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.DOUBLESUM;
	
	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);
	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);

	//INTERPOLATION-BIOCONVOLVING
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.BIOCONVOLVING;

	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);
	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);
	
	//INTERPOLATION-BIOHASHING
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.BIOHASHING;

	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);
	
	//DOUBLESUM-BIOCONVOLVING
	cancelableDataSets[0]=Const.DOUBLESUM;
	cancelableDataSets[1]=Const.BIOCONVOLVING;

	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);
	
	//DOUBLESUM-BIOHASHING
	cancelableDataSets[0]=Const.DOUBLESUM;
	cancelableDataSets[1]=Const.BIOHASHING;

	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);
	
	//BIOCONVOLVING-BIOHASHING
	cancelableDataSets[0]=Const.BIOCONVOLVING;
	cancelableDataSets[1]=Const.BIOHASHING;

	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);
	
	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);
    }
       
}
