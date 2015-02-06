package com.marcelodamasceno.util;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import org.apache.commons.math3.stat.descriptive.moment.Mean;
import org.apache.commons.math3.stat.descriptive.moment.StandardDeviation;

import com.marcelodamasceno.gui.FileGui;


public class CalculateEERStatistics {

    private final String parentPath="Experimentos/";
    private String combinationArray[];
    private String experiments[][]=new String[4][6];
    private String path="";
    private String orientation="";
    private int combination=4;
    private String classifierName="";

    public CalculateEERStatistics(String orientation, int combination){
	this.orientation=orientation;
	this.combination=combination;		
	fillCombinacao(combination);
	fillExperiments();
    }


    public CalculateEERStatistics(String orientation, int combination, int experiment){
	this.orientation=orientation;
	this.combination=combination;
	fillCombinacao(combination);
	fillExperiments();
    }

    public CalculateEERStatistics(String orientation){
	fillCombinacao(combination);		
	fillExperiments();		
	this.orientation=orientation;
    }

    public CalculateEERStatistics(){
	fillCombinacao(combination);		
	fillExperiments();		
    }
    
    public CalculateEERStatistics(File file){
	saveEERExperimentsToFile(file);
    }

    /**
     * Constructor
     * @param experiment name of Experiment
     * @param combination number of combination of biometric samples
     */
    public CalculateEERStatistics(String experiment,String combination){
	fillCombinacao(experiment,Integer.parseInt(combination));
	fillExperiments();
    }

    /**
     * Constructor
     * @param experiment name of Experiment
     * @param combination number of combination of biometric samples
     */
    public CalculateEERStatistics(String experiment,String start, String end){
	int startInt=Integer.parseInt(start);
	int endInt=Integer.parseInt(end);
	fillCombinacao(experiment,startInt,endInt);
	if(endInt-startInt==0){
	    fillExperiments(endInt);
	}else{
	    fillExperiments();
	}

    }


    /**
     * Method to calculate the EER median by user
     * @param combination combination number (k x k). From 1 to 4 (k)
     */
    public CalculateEERStatistics(int combination){		
	this.combination=combination;
	fillCombinacao(combination);		
	fillExperiments();		
    }


    /**
     * Method to fill the combinationArray.
     * P.ex: I want to calculate the EER from experiments combination 2x2 and 3x3.
     * So, the calling will be fillCombination("SVM",2,3)
     * @param experiment classifierName
     * @param start start of combination number.
     * @param end end of combination number
     */
    private void fillCombinacao(String experiment,int start, int end){	
	if(end==1){
	    combinationArray=new String[1];
	    combinationArray[0]="IJCNN";
	}else{
	    int diff=end-start;
	    combinationArray=new String[diff+1];
	    for(int comb=0;comb<=diff;comb++){
		int temp=start+comb;
		combinationArray[comb]=experiment+"/"+"Combinacao"+temp+"x"+temp;
	    }		
	}
    }


    /**
     * Method to fill the combinationArray
     * @param experiment classifierName
     * @param combination combination number (k x k). From 1 to 4 (k)
     */
    private void fillCombinacao(String experiment,int combination){
	fillCombinacao(experiment, 2, combination);
    }

    /**
     * Method to fill the combinationArray
     * @param combination combination number (k x k). From 1 to 4 (k)
     */
    private void fillCombinacao(int combination){
	if(combination==1){
	    combinationArray=new String[1];
	    combinationArray[0]="IJCNN";
	}else{
	    combinationArray=new String[combination-1];
	    for(int comb=0;comb+2<=combination;comb++){
		int temp=comb+2;
		combinationArray[comb]="Combinacao"+temp+"x"+temp;
	    }		
	}
    }

    /**
     * Fill experiments matrix with the name of combination experiments
     */
    private void fillExperiments(int comb){
	//row controls combination
	//column controls experiment

	if(comb==1){
	    experiments[0][0]="Inte";
	    experiments[0][1]="BioH";
	    experiments[0][2]="BioC";
	    experiments[0][3]="Doub";
	}
	if(comb==2){					
	    experiments[0][0]="BioCBioH";
	    experiments[0][1]="DoubBioC";
	    experiments[0][2]="DoubBioH";
	    experiments[0][3]="InteBioC";
	    experiments[0][4]="InteBioH";
	    experiments[0][5]="InteDoub";
	}
	if(comb==3){
	    experiments[0][0]="DoubBioCBioH";
	    experiments[0][1]="InteBioCBioH";
	    experiments[0][2]="InteDoubBioC";
	    experiments[0][3]="InteDoubBioH";
	    experiments[0][4]="InteDoubBioCBioH";
	}
	if(comb==4){
	    experiments[0][0]="InteDoubBioCBioH";	
	}
    }

    /**
     * Fill experiments matrix with the name of combination experiments
     */
    private void fillExperiments(){
	//row controls combination
	//column controls experiment

	if(combination==1){
	    experiments[0][0]="Inte";
	    experiments[0][1]="BioH";
	    experiments[0][2]="BioC";
	    experiments[0][3]="Doub";
	}

	if(combination==4){
	    experiments[2][0]="InteDoubBioCBioH";	
	}else{
	    if(combination>=3){
		experiments[1][0]="DoubBioCBioH";
		experiments[1][1]="InteBioCBioH";
		experiments[1][2]="InteDoubBioC";
		experiments[1][3]="InteDoubBioH";
		experiments[2][0]="InteDoubBioCBioH";
	    }
	}
	if(combination>=2){					
	    experiments[0][0]="BioCBioH";
	    experiments[0][1]="DoubBioC";
	    experiments[0][2]="DoubBioH";
	    experiments[0][3]="InteBioC";
	    experiments[0][4]="InteBioH";
	    experiments[0][5]="InteDoub";
	}


    }


    /**
     * Method calculates the EER
     * @throws IOException
     */
    public void createExperiments(String ensembleType) throws IOException{
	ArrayList<File> eerFiles;
	if(orientation.equals("")){
	    orientation=Const.HORIZONTAL;
	    if(ensembleType.endsWith(Const.HETEROGENEOUS)){
		eerFiles=createPath(orientation);
	    }else{
		eerFiles=getFilePaths(orientation,classifierName);
		//eerFiles=createPath(orientation,classifierName,combination);
	    }
	    //Utils.WriteToFile(createEERStatisticsArray(eerFiles));
	    saveEERExperimentsToFile(eerFiles);

	    orientation=Const.SCROOLING;
	    if(ensembleType.endsWith(Const.HETEROGENEOUS)){
		eerFiles=createPath(orientation);
	    }else{
		eerFiles=getFilePaths(orientation, classifierName);
		//eerFiles=createPath(orientation, classifierName,combination);
	    }
	    //Utils.WriteToFile(createEERStatisticsArray(eerFiles));
	    saveEERExperimentsToFile(eerFiles);
	}else{
	    if(orientation.equals(Const.HORIZONTAL)){
		if(ensembleType.endsWith(Const.HETEROGENEOUS)){
		    eerFiles=createPath(orientation);
		}else{
		    eerFiles=getFilePaths(orientation, classifierName);
		}
		//Utils.WriteToFile(createEERStatisticsArray(eerFiles));
		saveEERExperimentsToFile(eerFiles);

	    }else{
		if(ensembleType.endsWith(Const.HETEROGENEOUS)){
		    eerFiles=createPath(orientation);
		}else{
		    eerFiles=getFilePaths(orientation, classifierName);
		}
		//Utils.WriteToFile(createEERStatisticsArray(eerFiles));
		saveEERExperimentsToFile(eerFiles);
	    }
	}
    }

    private String getWekaClassifierName(String classifier){
	if(classifier.equals("SVM")){
	    return Const.SVM;
	}else{
	    if(classifier.equals("KNN")){
		return Const.KNN;
	    }else{
		if(classifier.equals("Naive")){
		    return Const.NAIVE;
		}else{
		    return Const.MLP;
		}
	    }
	}
    }

    /**
     * Returns all the file paths of all combination experiments by stroke orientation and classifier name and combination experiment
     * @param orientation stroke orientation
     * @param classifierName Classifier name 
     * @param combination Combination experiment type
     * @return ArrayList with all file paths
     */
    private ArrayList<File> getFilePaths(String orientation, String classifierName, int combination){

	classifierName=getWekaClassifierName(classifierName);


	ArrayList<File> eerFiles=new ArrayList<File>();
	for (int i = 0; i < combinationArray.length; i++) {
	    String comb = combinationArray[i];
	    for (int j = 0; j < experiments[i].length; j++) {
		if(experiments[i][j]==null)
		    break;
		path=parentPath+comb+"/"+orientation+"/"+experiments[i][j]+"/";
		if(combination==1){
		    String experiment="";
		    for(int e=0;e<6;e++){
			experiment+=experiments[i][j];
		    }
		    path+="EER|-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+"|-|-|"+classifierName+" |-|-|"+experiment;
		}else{
		    if(combination==2){
			path+="EER|-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+experiments[i][j];
		    }else{
			if(combination==3){
			    path+="EER|-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+experiments[i][j];
			}else{
			    path+="EER|-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+experiments[i][j];
			}
		    }
		}
		File eerFile= new File(path);
		eerFiles.add(eerFile);
		path="";
	    }
	}
	return eerFiles;
    }

    /**
     * Returns all the file paths of all combination experiments by stroke orientation and classifier name
     * @param orientation stroke orientation
     * @param classifierName Classifier name
     * @return ArrayList with all file paths
     */
    private ArrayList<File> getFilePaths(String orientation, String classifierName){

	classifierName=getWekaClassifierName(classifierName);


	ArrayList<File> eerFiles=new ArrayList<File>();
	for (int i = 0; i < combinationArray.length; i++) {
	    String comb = combinationArray[i];
	    for (int j = 0; j < experiments[i].length; j++) {
		if(experiments[i][j]==null)
		    break;
		path=parentPath+comb+"/"+orientation+"/"+experiments[i][j]+"/";
		if(combination==1){
		    String experiment="";
		    for(int e=0;e<6;e++){
			experiment+=experiments[i][j];
		    }
		    path+="EER|-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+"|-|-|"+classifierName+" |-|-|"+experiment;
		}else{
		    if(i==0){
			path+="EER|-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+experiments[i][j];
		    }else{
			if(i==1){
			    path+="EER|-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+experiments[i][j];
			}else{
			    path+="EER|-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+classifierName+" |-|-|"+experiments[i][j];
			}
		    }
		}
		File eerFile= new File(path);
		eerFiles.add(eerFile);
		path="";
	    }
	}
	return eerFiles;
    }

    private ArrayList<File> createPath(String orientation){
	ArrayList<File> eerFiles=new ArrayList<File>();
	for (int i = 0; i < combinationArray.length; i++) {
	    String comb = combinationArray[i];
	    for (int j = 0; j < experiments[i].length; j++) {
		if(experiments[i][j]==null)
		    break;
		path=parentPath+comb+"/"+orientation+"/"+experiments[i][j]+"/";
		if(combination==1){
		    String experiment="";
		    for(int e=0;e<6;e++){
			experiment+=experiments[i][j];
		    }
		    path+="EER|-|-|weka.classifiers.lazy.IBk |-|-|weka.classifiers.lazy.IBk |-|-|weka.classifiers.functions.SMO |-|-|weka.classifiers.functions.SMO |-|-|weka.classifiers.bayes.NaiveBayes |-|-|weka.classifiers.bayes.NaiveBayes |-|-|"+experiment;
		}else{
		    if(i==0){
			path+="EER|-|-|weka.classifiers.lazy.IBk |-|-|weka.classifiers.functions.SMO |-|-|"+experiments[i][j];
		    }else{
			if(i==1){
			    path+="EER|-|-|weka.classifiers.lazy.IBk |-|-|weka.classifiers.functions.SMO |-|-|weka.classifiers.trees.J48 |-|-|"+experiments[i][j];
			}else{
			    path+="EER|-|-|weka.classifiers.lazy.IBk |-|-|weka.classifiers.functions.SMO |-|-|weka.classifiers.trees.J48 |-|-|weka.classifiers.functions.MultilayerPerceptron |-|-|"+experiments[i][j];
			}
		    }
		}
		File eerFile= new File(path);
		eerFiles.add(eerFile);
		path="";
	    }
	}
	return eerFiles;
    }
    
      
    /**
     * Saves the EER values of <code>eerFile</code> file
     * @param eerFile
     */
    public void saveEERExperimentsToFile(File eerFile){
	ArrayList<File> fileList=new ArrayList<File>();
	fileList.add(eerFile);
	saveEERExperimentsToFile(fileList);
    }

    /**
     * Saves the EER values of <code>eerFiles</code> files
     * @param eerFiles
     */
    private void saveEERExperimentsToFile(ArrayList<File> eerFiles){
	for (File eerFile : eerFiles) {
	    try {
		Utils.writeToFile(orientation+" |-|toR|-| "+eerFile.getName(), readEERValues(eerFile));
	    } catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	    }			
	}	
    }


    private ArrayList<EERStatistics> createEERStatisticsArray(ArrayList<File> eerFiles) throws IOException{		
	ArrayList<EERStatistics> eerStatistics=new ArrayList<EERStatistics>();		
	for (File eerFile : eerFiles) {
	    eerStatistics.add(calculateStatistics(eerFile));			
	}	
	return eerStatistics;
    }



    private double[] readEERValues(File eerFile) throws IOException{
	BufferedReader br = new BufferedReader(new FileReader(eerFile));
	String line;		
	ArrayList<Double> eerValues=new ArrayList<Double>();

	int linha=1;
	while ((line = br.readLine()) != null) {
	    if(linha%2==0){
		eerValues.add(Double.parseDouble(line));
	    }
	    linha++;
	}
	br.close();
	return Utils.transform(eerValues.toArray(new Double[eerValues.size()]));		
    }


    /**
     * Method creates a EERStatistics object based on eerFile
     * @param eerFile
     * @return
     * @throws IOException
     */
    private EERStatistics calculateStatistics(File eerFile) throws IOException{
	double[] eerValues=readEERValues(eerFile);

	Mean mean=new Mean();
	double doubleMean=mean.evaluate(eerValues);

	StandardDeviation desviation=new StandardDeviation();
	double std=desviation.evaluate(eerValues);

	//	double[] statistics=new double[]{doubleMean,std};

	return new EERStatistics(orientation+" |-| "+eerFile.getName(),doubleMean, std);
    }



    public static void main(String args[]){

	//HOMOGENEOUS ENSEMBLE
	String classifierName="SVM";	
	CalculateEERStatistics s=new CalculateEERStatistics("Voting"+classifierName+"/RBF","4","4");
	s.classifierName=classifierName;
	try {
	    s.createExperiments(Const.HOMOGENEOUS);
	} catch (IOException e) {
	    e.printStackTrace();
	}

	//HETEROGENEOUS ENSEMBLE

	/*CalculateEERStatistics s=new CalculateEERStatistics(4);
	//CalculateEERStatistics s=new CalculateEERStatistics(1);


	try {
	    s.createExperiments(Const.HETEROGENEOUS);
	} catch (IOException e) {	   
	    e.printStackTrace();
	}*/
    }

}
