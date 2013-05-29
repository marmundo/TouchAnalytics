package com.marcelodamasceno.utils;

import java.util.ArrayList;

import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.matrix.Matrix;

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

	/**
	 * Convert a Matrix object in a Instance object
	 * @param matrix
	 * @return
	 */
	public Instances MatrixtoInstances(Matrix matrix){		
		int m=matrix.getColumnDimension();
		ArrayList<Attribute> attributeList=new ArrayList<Attribute>(m);
		for(int i=0;i<m;i++){
			Attribute attr = new Attribute("m"+String.valueOf(i));
			attributeList.add(attr);			
		}
		Instances inst=new Instances("dataset", attributeList, m);
		for(int i=0;i<matrix.getRowDimension();i++){			
			Instance instance=new DenseInstance(m);
			for(int a=0;a<m;a++){
				instance.setValue(attributeList.get(a), matrix.get(i, a));
			}
			inst.add(instance);
		}
		return inst;
	}
}
