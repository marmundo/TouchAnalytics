package com.marcelodamasceno.generators;

import java.io.FileNotFoundException;

import weka.core.Instances;

import com.marcelodamasceno.util.ArffConector;

public class InterWeekGenerator extends Generator {

    ArffConector conector = new ArffConector();

    /**
     * @param args
     */
    public static void main(String[] args) {
	String projectPath = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";
	String folderResults = "InterWeek-SemNominal/";

	String cancelableFunction = Generator.INTERPOLATOR;

	// Generating the cancelable dataset for each user
	for (int user = 1; user <= 41; user++) {
	    Generator generator = new InterSessionGenerator();
	    try {
		String fileName = "InterWeek-User_" + user
			+ "_Day_1_Horizontal_Training.arff";
		Instances dataset = generator.getConector().openDataSet(projectPath
			+ folderResults + fileName);

		generator.generateInterWeek(dataset, fileName,
			cancelableFunction);

		fileName = "InterWeek-User_" + user
			+ "_Day_1_Scrolling_Training.arff";
		dataset = generator.getConector().openDataSet(projectPath
			+ folderResults + fileName);
		generator.generateInterWeek(dataset, fileName,
			cancelableFunction);

		fileName = "InterWeek-User_" + user
			+ "_NextWeek_Horizontal_Testing.arff";
		dataset = generator.getConector().openDataSet(projectPath
			+ folderResults + fileName);
		generator.generateInterWeek(dataset, fileName,
			cancelableFunction);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    } catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	    }

	}

    }
}
