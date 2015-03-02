package com.marcelodamasceno.sessions;

import java.io.FileNotFoundException;

import com.marcelodamasceno.generators.Generator;
import com.marcelodamasceno.generators.InterSessionGenerator;

import weka.core.Instances;
import weka.filters.Filter;
import weka.filters.unsupervised.instance.RemoveWithValues;

/**
 * Class to separate a InterSession dataset in training and testing sets
 * 
 * @author marcelo
 * 
 */
public class InterWeek {

    private Generator generator;
    private String savePath;

    /**
     * Constructor
     * 
     * @param savePath
     *            Path which the training or testing data will be saved
     */
    public InterWeek(String savePath) {
	generator = new InterSessionGenerator();
	this.savePath = savePath;
    }

    /**
     * Generates the training and testing data
     * 
     * @param filePath
     *            Path of the file
     * @param fileName
     *            Name of the file
     */
    public void generateTrainingAndTestingData(String filePath, String fileName) {
	try {

	    if (fileName.contains("Scrolling")) {
		generateTraining(filePath, fileName, true);
		generateTesting(filePath, fileName, true);
	    } else {
		generateTraining(filePath, fileName, false);
		generateTesting(filePath, fileName, false);
	    }

	} catch (FileNotFoundException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}
    }

    /**
     * Generates the training data
     * 
     * @param filePath
     *            Path of the file
     * @param fileName
     *            File Name - Must be the full file name (path+file name)
     * @param scrooling
     *            true if is transforming a scrooling data
     * @throws FileNotFoundException
     *             If the file is not found
     */
    private void generateTraining(String filePath, String fileName,
	    boolean scrolling) throws FileNotFoundException {
	Instances dataset = generator.getConector().openDataSet(
		filePath + fileName);
	RemoveWithValues filter = new RemoveWithValues();
	try {
	    filter.setAttributeIndex("1");
	    if (scrolling) {
		filter.setNominalIndices("5");
	    } else {
		filter.setNominalIndices("4");
	    }
	    filter.setInvertSelection(false);
	    filter.setInputFormat(dataset);
	    Instances trainingDataSet = Filter.useFilter(dataset, filter);
	    fileName = fileName.substring(0, fileName.length() - 5)
		    + "_Training.arff";
	    generator.getConector().save(trainingDataSet, savePath, fileName);
	} catch (Exception e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}
    }

    private void generateTesting(String filePath, String fileName,
	    boolean scrooling) throws FileNotFoundException {
	Instances dataset = generator.getConector().openDataSet(
		filePath + fileName);
	RemoveWithValues filter = new RemoveWithValues();
	try {

	    filter.setAttributeIndex("1");
	    if (scrooling) {
		filter.setNominalIndices("3");
	    } else {
		filter.setNominalIndices("5");
	    }
	    filter.setInvertSelection(true);
	    filter.setInputFormat(dataset);
	    Instances trainingDataSet = Filter.useFilter(dataset, filter);
	    fileName = fileName.substring(0, fileName.length() - 5)
		    + "_Testing.arff";

	    generator.getConector().save(trainingDataSet, savePath, fileName);
	} catch (Exception e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}
    }

    public void executeOriginal() {
	/* Original */
	for (int user = 1; user <= 41; user++) {
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/InterSession/",
		    "InterSession-User_" + user + "_Day_1_Scrolling.arff");
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/InterSession/",
		    "InterSession-User_" + user + "_Day_1_Horizontal.arff");
	}
    }

    public void executeInterpolation() {
	/* Interpolation */
	setSavePath("/home/marcelo/TouchAnalytics/Interpolation/Intersession");
	for (int user = 1; user <= 41; user++) {
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/Interpolation/InterSession/",
		    "Interpolation-InterSession-User_" + user
			    + "_Day_1_Scrolling.arff");
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/Interpolation/InterSession/",
		    "Interpolation-InterSession-User_" + user
			    + "_Day_1_Horizontal.arff");
	}
    }

    public void executeBioHashing() {
	/* BioHashing */
	setSavePath("/home/marcelo/TouchAnalytics/BioHashing/Intersession");
	for (int user = 1; user <= 41; user++) {
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/BioHashing/InterSession/",
		    "InterSession-User_" + user + "_Day_1_Scrolling.arff");
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/BioHashing/InterSession/",
		    "InterSession-User_" + user + "_Day_1_Horizontal.arff");
	}
    }

    public void executeBioConvolving() {
	/* BioConvolving */
	setSavePath("/home/marcelo/TouchAnalytics/BioConvolving/Intersession");
	for (int user = 1; user <= 41; user++) {
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/BioConvolving/InterSession/",
		    "Bioconvolving-InterSession-User_" + user
			    + "_Day_1_Scrolling.arff");
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/BioConvolving/InterSession/",
		    "Bioconvolving-InterSession-User_" + user
			    + "_Day_1_Horizontal.arff");
	}
    }

    public void executeDoubleSum() {
	/* DoubleSum */
	setSavePath("/home/marcelo/TouchAnalytics/DoubleSum/Intersession");
	for (int user = 1; user <= 41; user++) {
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/DoubleSum/InterSession/",
		    "InterSession-User_" + user + "_Day_1_Scrolling.arff");
	    generateTrainingAndTestingData(
		    "/media/marcelo/Acer/Users/Marcelo/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/DoubleSum/InterSession/",
		    "InterSession-User_" + user + "_Day_1_Horizontal.arff");
	}
    }

    public static void main(String args[]) {
	InterWeek inter = new InterWeek(
		"/home/marcelo/TouchAnalytics/Original/InterSession");
	// inter.executeOriginal();

	// inter.executeInterpolation();

	// inter.executeBioHashing();

	inter.executeBioConvolving();

	// inter.executeDoubleSum();

    }

    public String getSavePath() {
	return savePath;
    }

    public void setSavePath(String savePath) {
	this.savePath = savePath;
    }

}
