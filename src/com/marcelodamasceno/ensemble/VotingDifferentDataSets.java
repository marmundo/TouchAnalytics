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

    private String takeOptions(String combinationName,String[]datasets,String[]classifiers,int user,String orientation){		
	String nameOfFile=combinationName;		
	//for (String string : datasets) {
	//    nameOfFile+=string.substring(0, 4);
	//}
	nameOfFile+="-User-"+user+"-"+orientation;

	String options=nFolds+" "+nameOfFile+"test.arff "+ nameOfFile+"vali.arff "+nameOfFile+"media.txt "+classifiers.length+" ";

	String path=Const.DATASETPATH+"Cancelaveis/";
	int count=0;
	for (String dataset : datasets) {
	    path+=dataset+"/IntraSession/IntraSession-User_"+user+"_Day_1_"+orientation+".arff ";
	    options+=classifiers[count]+" -t "+path;
	    path=Const.DATASETPATH+"Cancelaveis/";
	    count++;
	}		
	return options;
    }


    public void horizontalExperiment(String combinationName,String[]datasets,String[]classifiers) throws Exception{
	for(int user=1;user<=nUsers;user++){
	    String options=takeOptions(combinationName,datasets, classifiers, user, Const.HORIZONTAL);
	    String[] classifierOptions=Utils.splitOptions(options);
	    callExperiment(classifierOptions);
	}
    }

    public void scroolingExperiment(String combinationName,String[]datasets,String[]classifiers) throws Exception{
	for(int user=1;user<=nUsers;user++){
	    String options=takeOptions(combinationName,datasets, classifiers, user, Const.SCROOLING);
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
    public String[] fillClassifiersArray(String[]cancelable,int nClassifiers){
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
     * Executes the experiment
     * @param options Full string off options
     */
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
	//teste.combination2per2(orientation,classifiers);
	
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	classifiers[2]=Const.DECISIONTREE;
	//teste.combination3per3(orientation,classifiers);
	
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	classifiers[2]=Const.DECISIONTREE;
	classifiers[3]=Const.MLP;
	//teste.combination4per4(orientation,classifiers);
	
	orientation=Const.SCROOLING;
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	//teste.combination2per2(orientation,classifiers);
	
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	classifiers[2]=Const.DECISIONTREE;
	//teste.combination3per3(orientation,classifiers);
	
	
	classifiers[0]=Const.KNN;
	classifiers[1]=Const.SVM;
	classifiers[2]=Const.DECISIONTREE;
	classifiers[3]=Const.MLP;
	//teste.combination4per4(orientation,classifiers);
    }


}
