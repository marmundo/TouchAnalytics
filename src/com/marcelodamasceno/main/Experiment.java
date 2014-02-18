package com.marcelodamasceno.main;

import java.util.ArrayList;
import java.util.Random;

import com.marcelodamasceno.util.Utils;

import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.evaluation.EER;
import weka.core.Instances;
import weka.core.WekaPackageManager;

public abstract class Experiment {

    public static final String INTERSESSION = "InterSession";
    public static final String INTERWEEK = "InterWeek";
    public static final String INTRASESSION = "IntraSession";

    protected ArrayList<Double> eerScroolingResult = new ArrayList<Double>();
    protected ArrayList<Double> eerHorizontalResult = new ArrayList<Double>();

    protected ArrayList<Double> correctScroolingResult = new ArrayList<Double>();
    protected ArrayList<Double> correctHorizontalResult = new ArrayList<Double>();

    protected ArrayList<Double> incorrectScroolingResult = new ArrayList<Double>();
    protected ArrayList<Double> incorrectHorizontalResult = new ArrayList<Double>();

    protected String projectPath = "/home/marcelo/Área de Trabalho/projeto/dataset/Base de Toque/";

    public String getProjectPath() {
	return projectPath;
    }

    public void setProjectPath(String projectPath) {
	this.projectPath = projectPath;
    }

    protected String folderResults = "";

    public String getFolderResults() {
	return folderResults;
    }

    public void setFolderResults(String folderResults) {
	this.folderResults = folderResults;
    }

    protected String fileName = "";

    public String getFileName() {
	return fileName;
    }

    public void setFileName(String fileName) {
	this.fileName = fileName;
    }

    public Experiment() {
	WekaPackageManager.loadPackages(false, false);
    }

    public abstract void classifyAllUsers(Classifier classifier,
	    boolean eerBool, boolean correctStatistics);

    public double classify(Instances train, Instances test,
	    Classifier classifier, boolean correctStatistics, boolean eerBool) {
	Evaluation eval;
	EER eer = null;
	if (test == null) {
	    try {
		eval = new Evaluation(train);
		eval.crossValidateModel(classifier, train, 10, new Random(1));
		if (eerBool) {
		    eer = (EER) eval.getPluginMetric("EER");
		    return eer.getStatistic("");
		}
		if (correctStatistics) {
		    return eval.pctCorrect();
		} else {
		    return eval.pctIncorrect();
		}
	    } catch (Exception e) {
		e.printStackTrace();
		return -1;
	    }
	} else {
	    try {
		classifier.buildClassifier(train);
		eval = new Evaluation(train);
		eval.evaluateModel(classifier, test);
		if (eerBool) {
		    eer = (EER) eval.getPluginMetric("EER");
		    return eer.getStatistic("");
		}
		if (correctStatistics) {
		    return eval.pctCorrect();
		} else {
		    return eval.pctIncorrect();
		}
	    } catch (Exception e) {
		e.printStackTrace();
		return -1;
	    }

	}
    }

    /**
     * Evaluates a classifier using 10 cross-validation and returns the Equal
     * Error Rate
     * 
     * @param train
     * @param test
     * @param classifier
     * @return
     */
    public double classifyEER(Instances train, Instances test,
	    Classifier classifier) {
	return classify(train, test, classifier, true, true);
    }

    /**
     * Save Results to a File
     * 
     * @param dataset
     *            Could be InterSession,InterWeek,IntraSession
     * @param scrollingResults
     *            Results from scrooling strokes
     * @param horizontalResults
     *            Results from horizontal strokes
     * @param eerBool
     *            Print EER Results
     * @param correctStatistics
     *            Print Correct Statistics
     */
    public void saveResults(String dataset, ArrayList<Double> scrollingResults,
	    ArrayList<Double> horizontalResults, boolean eerBool,
	    boolean correctStatistics) {
	Utils util = new Utils();
	util.writeToFile(dataset, "\n");
	if (eerBool) {
	    util.writeToFile(dataset, "EER Scrooling:\n ");

	} else {
	    if (correctStatistics) {
		util.writeToFile(dataset, "Scrooling-Correct Statistics:\n ");
	    } else {
		util.writeToFile(dataset, "Scrooling-Incorrect Statistics:\n ");
	    }
	}
	for (int i = 0; i < scrollingResults.size(); i++) {
	    util.writeToFile(dataset, scrollingResults.get(i) + "\n");
	}

	if (eerBool) {
	    util.writeToFile(dataset, "\nEER Horizontal:\n ");
	} else {
	    if (correctStatistics) {
		util.writeToFile(dataset, "Horizontal-Correct Statistics:\n ");
	    } else {
		util.writeToFile(dataset,
			"\nHorizontal-Incorrect Statistics:\n ");
	    }
	}
	for (int i = 0; i < horizontalResults.size(); i++) {
	    util.writeToFile(dataset, horizontalResults.get(i) + "\n");
	}
    }

    public void printResults(ArrayList<Double> scrollingResults,
	    ArrayList<Double> horizontalResults, boolean eerBool,
	    boolean correctStatistics) {
	if (eerBool) {
	    System.out.println("EER Scrooling: ");
	} else {
	    if (correctStatistics) {
		System.out.println("Scrooling-Correct Statistics: ");
	    } else {
		System.out.println("Scrooling-Incorrect Statistics: ");
	    }
	}
	for (int i = 0; i < scrollingResults.size(); i++) {
	    System.out.print(scrollingResults.get(i) + "\n");
	}

	if (eerBool) {
	    System.out.println("\nEER Horizontal: ");
	} else {
	    if (correctStatistics) {
		System.out.println("\nHorizontal-Correct Statistics: ");
	    } else {
		System.out.println("\nHorizontal-Incorrect Statistics: ");
	    }
	}
	for (int i = 0; i < horizontalResults.size(); i++) {
	    System.out.print(horizontalResults.get(i) + "\n");
	}
    }

}
