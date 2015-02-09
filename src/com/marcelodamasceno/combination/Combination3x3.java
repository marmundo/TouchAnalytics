package com.marcelodamasceno.combination;

import com.marcelodamasceno.ensemble.VotingDifferentDataSets;
import com.marcelodamasceno.util.Const;

public class Combination3x3 extends Combination {

    VotingDifferentDataSets voting;

    public Combination3x3(){
	super(10);
    }

    /**
     * Methods combines 3 datasets per experiment
     * @param orientation Stroke Orientation
     * @param classifiers Used Classifiers
     * @throws Exception
     */
    public void combination(String orientation, String[] classifiers) throws Exception{
	String[]cancelableDataSets=new String[3];
	int nClassifiers=classifiers.length;
	String[] votingDataSets=null;
	VotingDifferentDataSets voting=super.getVoting();

	String cancelableName="";

	//INTERPOLATION-DOUBLESUM-BIOCONVOLVING

	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.DOUBLESUM;
	cancelableDataSets[2]=Const.BIOCONVOLVING;

	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);

	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);

	//INTERPOLATION-DOUBLESUM-BIOHASHING
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.DOUBLESUM;
	cancelableDataSets[2]=Const.BIOHASHING;

	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);

	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);

	//INTERPOLATION-BIOCONVOLVING-BIOHASHING
	cancelableDataSets[0]=Const.INTERPOLATION;
	cancelableDataSets[1]=Const.BIOCONVOLVING;
	cancelableDataSets[2]=Const.BIOHASHING;

	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);

	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);

	//DOUBLESUM-BIOCONVOLVING-BIOHASHING
	cancelableDataSets[0]=Const.DOUBLESUM;
	cancelableDataSets[1]=Const.BIOCONVOLVING;
	cancelableDataSets[2]=Const.BIOHASHING;		

	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);

	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);


    }   
}
