package com.marcelodamasceno.key.experiment;

import java.util.ArrayList;

import weka.core.Instances;



/**
 * Abstract Class that Generates the Cancelable Datasets
 * @author marcelo
 *
 */
public abstract class CancelableExperiment {

    /**
     * File Name
     */
    private String fileName;

    /**
     * Cancelable Function Name 
     */
    protected String cancelableFunctionName;

    protected String orientation;

    protected String tempResults;

    protected Instances dataset;


    public CancelableExperiment(String cancelableFunctionName, String orientation){
	this.setCancelableFunctionName(cancelableFunctionName);    
	this.setOrientation(orientation);
    }

   
    public String getTempResults() {
	return tempResults;
    }

    public void setDataset(Instances dataset) {
	this.dataset = dataset;
    }

   

    public void setTempResults(String tempResults) {
	this.tempResults = tempResults;
    }

    public Instances getDataset() {
	return dataset;
    }

    /**
     * Method execute the experiment with a big key
     */
    abstract protected void differentKeyBig();

    /**
     * Method execute the experiment each user has its own key with big size
     * and selected by feature selection
     */
    abstract protected void differentKeyBigFS(ArrayList<Integer> big);

    /**
     * Method execute the experiment with a medium key
     */
    abstract protected void differentKeyMedium();

    /**
     * Method execute the experiment each user has its own key with medium size
     * and selected by feature selection
     */
    abstract protected void differentKeyMediumFS(ArrayList<Integer> medium);

    /**
     * Method execute the experiment with a small key
     */
    abstract protected void differentKeySmall();

    /**
     * Method execute the experiment each user has its own key with small size
     * and selected by feature selection
     */
    abstract protected void differentKeySmallFS(ArrayList<Integer> small);

    /**
     * Method execute the experiment each user has its own key with standard size
     */
    abstract protected void differentKeyStandard(); 

    /**
     * Methods Call the experiments where each user has its key/password
     * @throws Exception
     */
    private void executeDifferentExperiment() throws Exception{
	differentKeyStandard();
	differentKeySmall();
	differentKeyMedium();
	differentKeyBig();	
    } 

    /**
     * Method execute the experiments where each user has its own key/password.
     * When the cancelable function needs to decrease the number of attributes
     * it is used the arrays {@code small}, {@code medium} and {@code big}
     * which contains the list of attributes when the kye is small, medium
     * and big respectivelly.
     * 
     * @param small
     * @param medium
     * @param big
     * @throws Exception
     */
    protected void executeDifferentExperimentFS(ArrayList<Integer> small, ArrayList<Integer> medium, ArrayList<Integer> big) throws Exception{
	differentKeyStandard();
	differentKeySmallFS(small);
	differentKeyMediumFS(medium);
	differentKeyBigFS(big);
    }

    /**
     * Execute the experiments with fixed and different key/password
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     * @param  
     * @throws Exception
     */
    protected void executeExperiment(boolean saveBeforeDiscretization) throws Exception{
	executeFixedExperiment(saveBeforeDiscretization);
	executeDifferentExperiment();
    }

    /**
     * Execute the experiments with fixed and different key/password 
     * using feature selection
     * @param saveBeforeDiscretization  true, when you wanna see the dataset before discretization
     * @param small List with attributes
     * @param medium List with attributes
     * @param big List with attributes
     * @throws Exception
     */
    protected void executeFeatureSelectionExperiment(boolean saveBeforeDiscretization, ArrayList<Integer> small,ArrayList<Integer> medium,ArrayList<Integer> big) throws Exception{
	executeFixedExperimentFS(small, medium, big,saveBeforeDiscretization);
	executeDifferentExperimentFS(small, medium, big);
    }

    /**
     * Execute the experiments with fixed key/password
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     * @throws Exception
     */
    protected void executeFixedExperiment(boolean saveBeforeDiscretization) throws Exception{
	fixedKeyStandard(saveBeforeDiscretization);
	fixedKeySmall(saveBeforeDiscretization);
	fixedKeyMedium(saveBeforeDiscretization);
	fixedKeyBig(saveBeforeDiscretization);
    }

    /**
     * Execute the experiments with fixed key/password with feature selection
     * @param small list with attributes
     * @param medium list with attributes
     * @param big list with attributes
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     * @throws Exception
     */
    protected void executeFixedExperimentFS(ArrayList<Integer> small, ArrayList<Integer> medium, ArrayList<Integer> big,boolean saveBeforeDiscretization) throws Exception{
	fixedKeyStandard(saveBeforeDiscretization);
	fixedKeySmallFS(small,saveBeforeDiscretization);
	fixedKeyMediumFS(medium,saveBeforeDiscretization);
	fixedKeyBigFS(big,saveBeforeDiscretization);
    }


    /**
     * Executes the experiment with a fixed big key for all users
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     */
    abstract protected void fixedKeyBig(boolean saveBeforeDiscretization);

    /**
     * Executes the experiment with a fixed big key for all users
     * with feature selection
     * @param big list of attributes
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     */
    abstract protected void fixedKeyBigFS(ArrayList<Integer> big,boolean saveBeforeDiscretization);

    /**
     * Executes the experiment with a fixed medium key for all users
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     */
    abstract protected void fixedKeyMedium(boolean saveBeforeDiscretization);

    /**
     * Executes the experiment with a fixed medium key for all users
     * with feature selection
     * @param medium
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     */
    abstract protected void fixedKeyMediumFS(ArrayList<Integer> medium,boolean saveBeforeDiscretization);

    /**
     * Executes the experiment with a fixed small key for all users
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     */
    abstract protected void fixedKeySmall(boolean saveBeforeDiscretization);


    /**
     * Executes the experiment with a fixed small key for all users
     * with feature selection
     * @param small
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     */
    abstract protected void fixedKeySmallFS(ArrayList<Integer> small,boolean saveBeforeDiscretization);


    /**
     * Executes the experiment with a fixed standard key for all users
     * @param saveBeforeDiscretization true, when you wanna see the dataset before discretization
     */
    abstract protected void fixedKeyStandard(boolean saveBeforeDiscretization);


    /**
     * Return the name of cancelable function
     * @return name of cancelable function
     */
    public String getCancelableFunctionName() {
	return cancelableFunctionName;
    }

    /**
     * Return the name of the cancelable dataset file
     * @return the name of the cancelable dataset file
     */
    protected String getFileName() {
	return fileName;
    }

    /**
     * Set the name of cancelable function
     * @param cancelableFunctionName 
     */
    public void setCancelableFunctionName(String cancelableFunctionName) {
	this.cancelableFunctionName = cancelableFunctionName;
    }

    /**
     * set the name of cancelable dataset file
     * @param fileName the name of cancelable dataset file
     */
    protected void setFileName(String fileName) {
	this.fileName=fileName;
    }

    public String getOrientation() {
	return orientation;
    }

    public void setOrientation(String orientation) {
	this.orientation = orientation;
    }


}


