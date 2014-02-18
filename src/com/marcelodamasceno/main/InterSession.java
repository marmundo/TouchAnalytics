package com.marcelodamasceno.main;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import weka.classifiers.Classifier;
import weka.classifiers.lazy.IBk;
import weka.core.Instances;
import com.marcelodamasceno.util.ArffConector;

public class InterSession extends Experiment {

    public InterSession() {
	setFolderResults("InterSession/");
	setFileName("InterSession-User_");
    }

    /**
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
	InterSession main = new InterSession();
	System.out.println("OK");
	Classifier ibk = new IBk(5);
	main.classifyAllUsers(ibk, false, false);
    }

    public void classifyAllUsers(Classifier classifier, boolean eerBool,
	    boolean correctStatistics) {
	
	System.out.println("Starting InterSession...");
	// Classifier classifier=new IBk(5);
	ArffConector conector = new ArffConector();

	Instances scrolling = null;
	Instances horizontal = null;

	ArrayList<Double> scrollingResults = new ArrayList<Double>();
	ArrayList<Double> horizontalResults = new ArrayList<Double>();

	// It will save the temporary result classifiers
	double eer = 0.0;
	double correctPercentage = 0.0;
	double incorrectPercentage = 0.0;

	for (int user = 1; user <= 41; user++) {
	    try {
		System.out.println("Executing for user "+user);
		scrolling = conector.openDataSet(getProjectPath() + getFolderResults()
			+ getFileName() + user + "_Day_1_Scrolling.arff");
		if (eerBool) {
		    eer = classifyEER(scrolling, null, classifier);
		    scrollingResults.add(eer);
		    // System.out.println("InterSession-Scrolling-User " + user
		    // + " - EER: " + eer);

		} else {
		    if (correctStatistics) {
			correctPercentage = classify(scrolling, null,
				classifier, true, false);
			scrollingResults.add(correctPercentage);
			// System.out.println("InterSession-Scrolling-User "+user+" - Correct: "+correctPercentage+"%");

		    } else {
			incorrectPercentage = classify(scrolling, null,
				classifier, false, false);
			scrollingResults.add(incorrectPercentage);
			// System.out.println("InterSession-Scrolling-User "+user+" - Incorrect: "+incorrectPercentage+"%");

		    }
		}

		horizontal = conector.openDataSet(getProjectPath() + getFolderResults()
			+ getFileName() + user + "_Day_1_Horizontal.arff");
		if (eerBool) {
		    eer = classifyEER(horizontal, null, classifier);
		    horizontalResults.add(eer);
		    // System.out.println("InterSession-Horizontal-User " + user
		    // + " - EER: " + eer);

		} else {
		    if (correctStatistics) {
			correctPercentage = classify(horizontal, null,
				classifier, true, false);
			horizontalResults.add(correctPercentage);
			// System.out.println("InterSession-Horizontal-User "+user+" - Correct: "+correctPercentage+"%");

		    } else {
			incorrectPercentage = classify(horizontal, null,
				classifier, false, false);
			horizontalResults.add(incorrectPercentage);
			// System.out.println("InterSession-Horizontal-User "+user+" - Incorrect: "+incorrectPercentage+"%");

		    }
		}
	    } catch (FileNotFoundException e1) {
		e1.printStackTrace();
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
	printResults(scrollingResults, horizontalResults, eerBool,
		correctStatistics);
    }
}
