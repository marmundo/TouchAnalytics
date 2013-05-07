package com.marcelodamasceno.main;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import weka.classifiers.Classifier;
import weka.classifiers.lazy.IBk;
import weka.core.Instances;
import weka.core.WekaPackageManager;
import com.marcelodamasceno.util.ArffConector;

public class InterSession extends Experiment {

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		WekaPackageManager.loadPackages(false, false);
		//ArffConector conector=new ArffConector();		
		//Instances train=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterSession/InterSession-User_2_Day_1_Scrolling.arff");
		//Instances test=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterSession/InterSession-User_2_Day_2_Scrolling.arff");
		InterSession main = new InterSession();
		main.classifyAllUsers(false, false);
		//IBk ibk=new IBk(5);
		//System.out.println("Perc. Correct: "+main.classify(train,test,ibk)+"%");
	}

	protected void classifyAllUsers(boolean eerBool, boolean correctStatistics){
		Classifier classifier=new IBk(5);
		ArffConector conector=new ArffConector();

		Instances scrolling=null;
		Instances horizontal=null;

		ArrayList<Double> scrollingResults=new ArrayList<Double>();
		ArrayList<Double> horizontalResults=new ArrayList<Double>();

		//It will save the temporary result classifiers
		double eer=0.0;
		double correctPercentage=0.0;
		double incorrectPercentage=0.0;
		
		for(int user=1;user<=41;user++){			
			try {
				scrolling = conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterSession/InterSession-User_"+user+"_Day_1_Scrolling.arff");
				if(eerBool){
					eer=classifyEER(scrolling, null, classifier);
					scrollingResults.add(eer);
					System.out.println("InterSession-Scrolling-User "+user+" - EER: "+eer);
				}
				if(correctStatistics){
					correctPercentage=classify(scrolling, null, classifier, true,false);
					scrollingResults.add(correctPercentage);
					System.out.println("InterSession-Scrolling-User "+user+" - Correct: "+correctPercentage+"%");
				}else{
					incorrectPercentage=classify(scrolling, null, classifier, false,false);
					scrollingResults.add(incorrectPercentage);
					System.out.println("InterSession-Scrolling-User "+user+" - Incorrect: "+incorrectPercentage+"%");
				}				
				
				horizontal=conector.openDataSet("/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/InterSession/InterSession-User_"+user+"_Day_1_Horizontal.arff");
				if(eerBool){
					eer=classifyEER(horizontal,null, classifier);
					horizontalResults.add(eer);
					System.out.println("InterSession-Horizontal-User "+user+" - EER: "+eer);
				}
				if(correctStatistics){
					correctPercentage=classify(horizontal,null, classifier, true,false);
					horizontalResults.add(correctPercentage);
					System.out.println("InterSession-Horizontal-User "+user+" - Correct: "+correctPercentage+"%");
				}else{
					incorrectPercentage=classify(horizontal,null, classifier, false,false);
					horizontalResults.add(incorrectPercentage);
					System.out.println("InterSession-Horizontal-User "+user+" - Incorrect: "+incorrectPercentage+"%");
				}				
			}catch (FileNotFoundException e1) {
				e1.printStackTrace();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		printResults(scrollingResults, horizontalResults, eerBool, correctStatistics);
	}

}
