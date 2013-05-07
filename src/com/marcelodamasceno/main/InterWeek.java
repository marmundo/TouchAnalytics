package com.marcelodamasceno.main;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Random;

import com.marcelodamasceno.util.ArffConector;

import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.evaluation.EER;
import weka.classifiers.lazy.IBk;
import weka.core.Instances;
import weka.core.WekaPackageManager;

public class InterWeek extends Experiment {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		WekaPackageManager.loadPackages(false, false);
		//ArffConector conector=new ArffConector();		
		//Instances train=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterSession/InterSession-User_2_Day_1_Scrolling.arff");
		//Instances test=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterSession/InterSession-User_2_Day_2_Scrolling.arff");
		InterWeek main = new InterWeek();
		main.classifyAllUsers(false, false);
		//IBk ibk=new IBk(5);
		//System.out.println("Perc. Correct: "+main.classify(train,test,ibk)+"%");

	}

	protected void classifyAllUsers(boolean eerBool, boolean correctStatistics) {
		//Instances (dataSet)
		Instances scrollingTraining=null;
		Instances horizontalTraining=null;
		Instances scrollingTesting=null;
		Instances horizontalTesting=null;
		
		//Classifier
		Classifier classifier=new IBk(5);
		
		//Conector
		ArffConector conector=new ArffConector();
		
		//Array to save the results for scrooling and horizontal strokes
		ArrayList<Double> scrollingResults=new ArrayList<Double>();
		ArrayList<Double> horizontalResults=new ArrayList<Double>();
		
		//It will save the temporary result classifiers
		double eer=0.0;
		double correctPercentage=0.0;
		double incorrectPercentage=0.0;
		
		for(int user=1;user<=41;user++){
			try{				
				scrollingTraining=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterWeek/InterWeek-User_"+user+"_Day_1_Scrolling_Training.arff");
				scrollingTesting=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterWeek/InterWeek-User_"+user+"_NextWeek_Scrolling_Testing.arff");
				if(eerBool){
					eer=classifyEER(scrollingTraining, scrollingTesting, classifier);
					scrollingResults.add(eer);
					System.out.println("InterWeek-Scrolling-User "+user+" - EER: "+eer);
				}
				if(correctStatistics){
					correctPercentage=classify(scrollingTraining, scrollingTesting, classifier, true,false);
					scrollingResults.add(correctPercentage);
					System.out.println("InterWeek-Scrolling-User "+user+" - Correct: "+correctPercentage+"%");
				}else{
					incorrectPercentage=classify(scrollingTraining, scrollingTesting, classifier, false,false);
					scrollingResults.add(incorrectPercentage);
					System.out.println("InterWeek-Scrolling-User "+user+" - Incorrect: "+incorrectPercentage+"%");
				}


				horizontalTraining=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterWeek/InterWeek-User_"+user+"_Day_1_Horizontal_Training.arff");
				horizontalTesting=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterWeek/InterWeek-User_"+user+"_NextWeek_Horizontal_Testing.arff");
				if(eerBool){
					eer=classifyEER(horizontalTraining, horizontalTesting, classifier);
					horizontalResults.add(eer);
					System.out.println("InterWeek-Horizontal-User "+user+" - EER: "+eer);
				}
				if(correctStatistics){
					correctPercentage=classify(horizontalTraining, horizontalTesting, classifier, true,false);
					horizontalResults.add(correctPercentage);
					System.out.println("InterWeek-Horizontal-User "+user+" - Correct: "+correctPercentage+"%");
				}else{
					incorrectPercentage=classify(horizontalTraining, horizontalTesting, classifier, false,false);
					horizontalResults.add(incorrectPercentage);
					System.out.println("InterWeek-Horizontal-User "+user+" - Incorrect: "+incorrectPercentage+"%");
				}				
			}catch(FileNotFoundException e1){
				try {
					scrollingTraining=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterWeek/InterWeek-User_"+user+"_Day_1_Scrolling_Training.arff");
					if(eerBool){
						eer=classifyEER(scrollingTraining, null, classifier);
						scrollingResults.add(eer);
						System.out.println("InterWeek-Scrolling-User "+user+" - EER: "+eer);
					}
					if(correctStatistics){
						correctPercentage=classify(scrollingTraining, null, classifier, true,false);
						scrollingResults.add(correctPercentage);
						System.out.println("InterWeek-Scrolling-User "+user+" - Correct: "+correctPercentage+"%");
					}else{
						incorrectPercentage=classify(scrollingTraining, null, classifier, false,false);
						scrollingResults.add(incorrectPercentage);
						System.out.println("InterWeek-Scrolling-User "+user+" - Incorrect: "+incorrectPercentage+"%");
					}


					horizontalTraining=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterWeek/InterWeek-User_"+user+"_Day_1_Horizontal_Training.arff");
					if(eerBool){
						eer=classifyEER(horizontalTraining, null, classifier);
						horizontalResults.add(eer);
						System.out.println("InterWeek-Horizontal-User "+user+" - EER: "+eer);
					}
					if(correctStatistics){
						correctPercentage=classify(horizontalTraining, null, classifier, true,false);
						horizontalResults.add(correctPercentage);
						System.out.println("InterWeek-Horizontal-User "+user+" - Correct: "+correctPercentage+"%");
					}else{
						incorrectPercentage=classify(horizontalTraining, null, classifier, false,false);
						horizontalResults.add(incorrectPercentage);
						System.out.println("InterWeek-Horizontal-User "+user+" - Incorrect: "+incorrectPercentage+"%");
					}					
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}			

			}catch (Exception e) {
				e.printStackTrace();
			}			
		}
		printResults(scrollingResults, horizontalResults, eerBool, correctStatistics);

	}
	
	

	/*private double classify(Instances train, Instances test,Classifier classifier,boolean correctStatistics,boolean eerBool){
		Evaluation eval;
		EER eer=null;
		if (test==null) {			
			try {
				eval = new Evaluation(train);
				eval.crossValidateModel(classifier, train, 10, new Random(1));
				if(eerBool){
					eer = (EER) eval.getPluginMetric("EER");
					return eer.getStatistic("");
				}if(correctStatistics){
					return eval.pctCorrect();
				}else{
					return eval.pctIncorrect();
				}
			} catch (Exception e) {
				e.printStackTrace();
				return -1;
			}				
		}else {					
			try {
				classifier.buildClassifier(train);
				eval=new Evaluation(train);
				eval.evaluateModel(classifier,test);
				if(eerBool){
					eer = (EER) eval.getPluginMetric("EER");
					return eer.getStatistic("");
				}if(correctStatistics){
					return eval.pctCorrect();
				}else{
					return eval.pctIncorrect();
				}				
			} catch (Exception e) {			
				e.printStackTrace();
				return -1;
			}

		}	
	}*/

}
