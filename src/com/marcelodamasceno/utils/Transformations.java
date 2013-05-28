package com.marcelodamasceno.utils;

import weka.core.Instances;

/**
 * Class that saves methods to convert differents objects in another compatives objects
 * @author marcelo
 *
 */
public class Transformations {

	/**
	 * Convert a Instances object to a bidimensional Array
	 * @param dataset
	 * @return
	 */
	public double[][] instancestoArray(Instances dataset){
		int nrow=dataset.numInstances();
		int ncol=dataset.numAttributes();
		double[][] double_dataset= new double[nrow][ncol];
		for(int row=0;row<dataset.numInstances();row++){
			double_dataset[row]=dataset.get(row).toDoubleArray();
		}
		return double_dataset;
	}	

}
