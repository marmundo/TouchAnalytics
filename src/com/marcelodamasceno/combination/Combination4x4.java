package com.marcelodamasceno.combination;

import com.marcelodamasceno.util.Const;

public class Combination4x4 extends Combination {
    
    //VotingDifferentDataSets voting;
    
    public Combination4x4(){
        super();
    }

    /**
   	 * Methods combines 4 datasets per experiment
   	 * @param orientation Stroke Orientation
   	 * @param classifiers Used Classifiers
   	 * @throws Exception
   	 */
       public void combination(String orientation, String[]classifiers) throws Exception{

   	String[]cancelableDataSets=new String[4];
   	int nClassifiers=classifiers.length;
   	String[] votingDataSets=null;
   	String cancelableName="";
   	
   	
   	//INTERPOLATION-DOUBLESUM-BIOCONVOLVING
   	cancelableDataSets[0]=Const.INTERPOLATION;
   	cancelableDataSets[1]=Const.DOUBLESUM;
   	cancelableDataSets[2]=Const.BIOCONVOLVING;
   	cancelableDataSets[3]=Const.BIOHASHING;
   	
   	votingDataSets=voting.fillClassifiersArray(cancelableDataSets, nClassifiers);

   	cancelableName=getCombinationName(cancelableDataSets);
	executeCombination(cancelableName,orientation,votingDataSets,classifiers);
       }
       
  }
