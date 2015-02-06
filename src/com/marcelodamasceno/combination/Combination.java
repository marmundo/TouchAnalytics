package com.marcelodamasceno.combination;

import com.marcelodamasceno.ensemble.VotingDifferentDataSets;
import com.marcelodamasceno.util.Const;


/**
 * Class models the Combination Experiment
 * @author marcelo
 *
 */
public abstract class Combination {   
    
    VotingDifferentDataSets voting;
    
    /**
     * Constructor
     */
    public Combination(){
	voting=new VotingDifferentDataSets(10);
    }
    
    /**
     * Constructor
     * @param nFolds number of Folds used in CrossValidation
     */
    public Combination(int nFolds){
	voting=new VotingDifferentDataSets(nFolds);
    }
    
    public abstract void combination(String orientation, String[]classifiers) throws Exception;
    
    protected String getCombinationName(String[]cancelableDataSets){
	String cancelableName="";
	for (String name : cancelableDataSets) {
	    cancelableName+=name.substring(0,4);
	}
	return cancelableName;
    }
    /**
     * Method executes the combination experiment
     * @param combinationName Name of combination experiment
     * @param orientation Stroke Orientation
     * @param votingDataSets Used datasets
     * @param classifiers used classifiers
     * @throws Exception
     */
    protected void executeCombination(String combinationName,String orientation,String[] votingDataSets,String[]classifiers) throws Exception{
	if(orientation.equals(Const.HORIZONTAL))	
	    voting.horizontalExperiment(combinationName,votingDataSets, classifiers);
	else
	    voting.scroolingExperiment(combinationName,votingDataSets, classifiers);
    }

}
