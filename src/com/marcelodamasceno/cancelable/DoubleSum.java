package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;
import java.util.Enumeration;

import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Utils;

public class DoubleSum {

    private Instances originalDataSet;
    /*private Instances transformedDataSet;

    public Instances getTransformedDataSet() {
	return transformedDataSet;
    }

    public void setTransformedDataSet(Instances transformedDataSet) {
	this.transformedDataSet = transformedDataSet;
    }*/

    public DoubleSum(Instances originalDataSet) {
	super();
	this.originalDataSet = originalDataSet;
    }

    private double[] generateRandomArray(int min, int max, int length) {
	return Utils.createRandomArray(0, max - 2, length);
    }

    private Instance permuteArray(Instance instance, double[] key) {
	for (int i = 0; i < key.length; i++) {
	    double value = instance.value((int) key[i]);
	    instance.setValue((int) key[i], instance.value(i));
	    instance.setValue(i, value);
	}
	return instance;
    }

    private Instances doublesum(Instances betaDataSet,double[] c1, double[] c2) {
	Enumeration<Instance> en = originalDataSet.enumerateInstances();
	Instances transformedDataSet=new Instances(originalDataSet);
	Instance instance=new DenseInstance(originalDataSet.instance(0));
	instance.setDataset(originalDataSet);
	transformedDataSet.clear();
	int index=0;
	System.out.println("Number Instances Original"+originalDataSet.numInstances());
	while (en.hasMoreElements()) {
	    Instance originalInstance = en.nextElement();
	    for (int i = 0; i < originalInstance.numAttributes()-1; i++) {
		double beta= betaDataSet.instance(index).value(i);
		double temp = originalInstance.value((int) c1[i])
			+ originalInstance.value((int) c2[i]);
		if(!instance.attribute(i).isNominal())
		    instance.setValue(i, beta+temp);				
	    }	   
	    transformedDataSet.add(instance);
	    index++;
	}
	return transformedDataSet;
    }

    /**
     * @param args
     * @throws FileNotFoundException
     */
    public static void main(String[] args) throws FileNotFoundException {
	ArffConector conector = new ArffConector();
	Instances dataset = null;
	String projectPath = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";
	String folderResults = "IntraSession/";

	dataset = conector.openDataSet(projectPath + folderResults
		+ "IntraSession-User_41_Day_1_Scrolling.arff");
	
	

	DoubleSum sum = new DoubleSum(dataset);
	double[] key = sum.generateRandomArray(0, dataset.numAttributes(),
		dataset.numAttributes());
	Enumeration<Instance> en = dataset.enumerateInstances();
	Instances betaDataSet = new Instances(dataset);
	betaDataSet.clear();
	// Permuting all the dataset
	while (en.hasMoreElements()) {
	    Instance instance = en.nextElement();
	    betaDataSet.add(sum.permuteArray(instance, key));
	}
	

	double[] c1 = sum.generateRandomArray(0, dataset.numAttributes(),
		dataset.numAttributes());
	double[] c2 = sum.generateRandomArray(0, dataset.numAttributes(),
		dataset.numAttributes());
	
	for(int i=0;i<10;i++){
	    Instances transformed=sum.doublesum(betaDataSet, c1, c2);	    
	    conector.save(transformed, "DoubleSum"+i+".arff");
	    c1=sum.generateRandomArray(0, dataset.numAttributes(),
			dataset.numAttributes());
	    c2=sum.generateRandomArray(0, dataset.numAttributes(),
			dataset.numAttributes());	    
	}	
    }

}
