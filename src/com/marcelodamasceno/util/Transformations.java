package com.marcelodamasceno.util;

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

	private ArrayList<Attribute> createAttributeList(int numAttributes){
		ArrayList<Attribute> attributeList=new ArrayList<Attribute>(numAttributes);
		for(int i=0;i<numAttributes-1;i++){
			Attribute attr = new Attribute("a"+String.valueOf(i));
			attributeList.add(attr);			
		}
		Attribute classe=new Attribute("class");
		attributeList.add(classe);
		return attributeList;
	}

	public Instance doubleToInstance(double[]data){
		Instance instance=new DenseInstance(data.length);		
		for(int i=0;i<data.length;i++){							
			instance.setValue(i, data[i]);				
		}
		return instance;
	}
	
	public Instance doubleArrayToInstanceWithClass(double[]data,String classe){
		DenseInstance instance=new DenseInstance(data.length);		
		for(int i=0;i<data.length;i++){							
			instance.setValue(i, data[i]);				
		}
		//Isso vai sair. Feito isso por causa do bug***
		if(classe.equals("positive"))
			instance.setValue(instance.numAttributes()-1,1);
		else
			instance.setValue(instance.numAttributes()-1,0);
		return instance;
	}

	public Instances doubleToInstances(double[]data,int numAttributes){
		ArrayList<Attribute> attributeList=createAttributeList(numAttributes);
		Instances dataset=new Instances("Transformed DataSet", attributeList, data.length);
		Instance instance=new DenseInstance(numAttributes);
		int counter=0;
		for(int i=0;i<data.length/numAttributes;i++){
			for(int j=0;j<numAttributes;j++){				
				instance.setValue(j, data[counter]);
				counter++;
			}
			dataset.add(instance);
		}
		return dataset;
	}

	/**
	 * Convert a Matrix object in a Instances object
	 * @param matrix
	 * @return
	 */
	public Instances MatrixtoInstances(Matrix matrix){		
		int m=matrix.getColumnDimension();
		ArrayList<Attribute> attributeList=createAttributeList(m);
		Instances inst=new Instances("dataset", attributeList, m);
		inst.setClassIndex(inst.numAttributes()-1);
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
