package com.marcelodamasceno.main.experiments;

import weka.classifiers.Classifier;
import weka.classifiers.lazy.IBk;

import com.marcelodamasceno.main.InterSession;
import com.marcelodamasceno.main.InterWeek;
import com.marcelodamasceno.main.IntraSession;

public class KNN {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		KNN knn=new KNN();
		knn.executeExperiments();
	}
	
	private void executeExperiments(){
		InterSession interSession=new InterSession();
		InterWeek interWeek = new InterWeek();
		IntraSession intraSession=new IntraSession();
		
		Classifier ibk=new IBk(5);
		interWeek.classifyAllUsers(ibk,false, false);
		interSession.classifyAllUsers(ibk, false, false);
		intraSession.classifyAllUsers(ibk, false, false);
	}

}
