package com.marcelodamasceno.cancelable.generators;

import weka.core.Instances;

import com.marcelodamasceno.cancelable.BioConvolving;
import com.marcelodamasceno.cancelable.BioHashing;
import com.marcelodamasceno.cancelable.Cancelable;
import com.marcelodamasceno.cancelable.DoubleSum;
import com.marcelodamasceno.cancelable.Interpolation;
import com.marcelodamasceno.util.ArffConector;

public abstract class Generator {

    public static final String INTERPOLATOR="Interpolator";
    public static final String BIOHASHING="Biohashing";
    public static final String BIOCONCOLVING="BioConvolving";
    public static final String DOUBLESUM="DoubleSum";
    
    ArffConector conector = new ArffConector();

    /**
     * Generates the cancelable DataSet using the cancelable function.
     * @param dataset
     * @param user
     * @param fileName
     * @param cancelable
     */
    public void generateInterSession(Instances dataset, String fileName,String cancelableString) {
	Cancelable cancelable;
	switch (cancelableString) {
	case INTERPOLATOR:
	    cancelable=new Interpolation(dataset);
	    String folder = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/Interpolation/InterSession/";
	    conector.save(cancelable.generate(), folder,fileName);
	    break;
	case BIOHASHING:
	    cancelable=new BioHashing(dataset);
	    folder = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/BioHashing/InterSession/";
	    conector.save(cancelable.generate(), folder,fileName);
	    break;
	case BIOCONCOLVING:
	    cancelable=new BioConvolving(dataset);
	    folder = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/BioConvolving/InterSession/";
	    conector.save(cancelable.generate(), folder,fileName);
	    break;
	case DOUBLESUM:
	    cancelable=new DoubleSum(dataset);
	    folder = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/Cancelaveis/DoubleSum/InterSession/";
	    conector.save(cancelable.generate(), folder,fileName);
	    break;
	default:	    
	    System.out.println("Cancelable function didn't found!");
	    break;
	}
	
	
    }

}
