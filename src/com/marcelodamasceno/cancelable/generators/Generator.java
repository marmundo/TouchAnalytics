package com.marcelodamasceno.cancelable.generators;

import weka.core.Instances;

import com.marcelodamasceno.cancelable.BioConvolving;
import com.marcelodamasceno.cancelable.BioHashing;
import com.marcelodamasceno.cancelable.Cancelable;
import com.marcelodamasceno.cancelable.DoubleSum;
import com.marcelodamasceno.cancelable.Interpolation;
import com.marcelodamasceno.util.ArffConector;

public abstract class Generator {

    public static final String INTERPOLATOR = "Interpolation";
    public static final String BIOHASHING = "BioHashing";
    public static final String BIOCONCOLVING = "BioConvolving";
    public static final String DOUBLESUM = "DoubleSum";

    private ArffConector conector = new ArffConector();

    private void generate(Instances dataset, String fileName,
	    String cancelableString, String session) {
	Cancelable cancelable;
	switch (cancelableString) {
	case INTERPOLATOR:
	    cancelable = new Interpolation(dataset);
	    String folder = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/Interpolation/"
		    + session + "/";
	    getConector().save(cancelable.generate(), folder, fileName);
	    break;
	case BIOHASHING:
	    cancelable = new BioHashing(dataset);
	    folder = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/BioHashing/"
		    + session + "/";
	    getConector().save(cancelable.generate(), folder, fileName);
	    break;
	case BIOCONCOLVING:
	    cancelable = new BioConvolving(dataset);
	    folder = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/BioConvolving/"
		    + session + "/";
	    getConector().save(cancelable.generate(), folder, fileName);
	    break;
	case DOUBLESUM:
	    cancelable = new DoubleSum(dataset);
	    folder = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/DoubleSum/"
		    + session + "/";
	    getConector().save(cancelable.generate(), folder, fileName);
	    break;
	default:
	    System.out.println("Cancelable function didn't found!");
	    break;
	}
    }

    /**
     * Generates the InterSession cancelable DataSet using the cancelable
     * function.
     * 
     * @param dataset
     * @param user
     * @param fileName
     * @param cancelable
     */
    public void generateInterSession(Instances dataset, String fileName,
	    String cancelableString) {
	generate(dataset, fileName, cancelableString, "InterSession");
    }

    /**
     * Generates the InterWeek cancelable DataSet using the cancelable function.
     * 
     * @param dataset
     * @param user
     * @param fileName
     * @param cancelable
     */
    public void generateInterWeek(Instances dataset, String fileName,
	    String cancelableString) {
	generate(dataset, fileName, cancelableString, "InterWeek");
    }

    /**
     * Generates the IntraSession cancelable DataSet using the cancelable
     * function.
     * 
     * @param dataset
     * @param user
     * @param fileName
     * @param cancelable
     */
    public void generateIntraSession(Instances dataset, String fileName,
	    String cancelableString) {
	generate(dataset, fileName, cancelableString, "IntraSession");
    }

    public ArffConector getConector() {
	return conector;
    }

    public void setConector(ArffConector conector) {
	this.conector = conector;
    }

}
