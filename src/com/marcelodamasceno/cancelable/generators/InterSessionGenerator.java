package com.marcelodamasceno.cancelable.generators;

import java.io.FileNotFoundException;

import weka.core.Instances;

import com.marcelodamasceno.util.ArffConector;

public class InterSessionGenerator extends Generator {

    ArffConector conector = new ArffConector();

    /**
     * @param args
     */
    public static void main(String[] args) {
	String projectPath = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";
	String folderResults = "InterSession-SemNominal/";

	String cancelableString = Generator.BIOHASHING;

	// Generating the cancelable dataset for each user
	for (int user = 1; user <= 41; user++) {
	    Generator generator = new InterSessionGenerator();
	    try {
		String fileName = "InterSession-User_" + user
			+ "_Day_1_Scrolling.arff";
		Instances dataset = generator.conector.openDataSet(projectPath
			+ folderResults + fileName);

		generator.generateInterSession(dataset,
			"BioHashing-InterSession-User_" + user
				+ "_Day_1_Scrolling.arff", cancelableString);

		fileName = "InterSession-User_" + user
			+ "_Day_1_Horizontal.arff";
		dataset = generator.conector.openDataSet(projectPath
			+ folderResults + fileName);
		generator.generateInterSession(dataset,
			"BioHashing-InterSession-User_" + user
				+ "_Day_1_Horizontal.arff", cancelableString);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	}

    }
}
