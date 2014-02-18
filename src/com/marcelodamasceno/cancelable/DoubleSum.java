package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;
import java.util.Enumeration;

import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Utils;

public class DoubleSum extends Cancelable {

    private Instances originalDataSet;

    /*
     * private Instances transformedDataSet;
     * 
     * public Instances getTransformedDataSet() { return transformedDataSet; }
     * 
     * public void setTransformedDataSet(Instances transformedDataSet) {
     * this.transformedDataSet = transformedDataSet; }
     */

    public DoubleSum(Instances originalDataSet) {
	super();
	this.originalDataSet = originalDataSet;
    }

    /**
     * Generates a RandowArray with min=0 and max=num of attributes of the
     * current instance
     * 
     * @param min
     * @param max
     * @param length
     * @return
     */
    private double[] generateRandomArray(int min, int max, int length) {
	return Utils.createRandomArray(0, max - 2, length);
    }

    /**
     * Change the place of the attribute value depending on the given key
     * 
     * @param instance
     * @param key
     * @return
     */
    private Instance permuteArray(Instance instance, double[] key) {
	for (int i = 0; i < key.length; i++) {
	    double value = instance.value((int) key[i]);
	    instance.setValue((int) key[i], instance.value(i));
	    instance.setValue(i, value);
	}
	return instance;
    }

    private Instances doublesum(Instances betaDataSet, double[] c1, double[] c2) {
	@SuppressWarnings("unchecked")
	Enumeration<Instance> en = originalDataSet.enumerateInstances();
	Instances transformedDataSet = new Instances(originalDataSet);
	Instance instance = new DenseInstance(originalDataSet.numAttributes());
	// (originalDataSet.instance(0));
	instance.setDataset(originalDataSet);
	transformedDataSet.clear();
	int index = 0;
	while (en.hasMoreElements()) {
	    Instance originalInstance = en.nextElement();
	    for (int i = 0; i < originalInstance.numAttributes() - 1; i++) {
		double beta = betaDataSet.instance(index).value(i);
		double temp = originalInstance.value((int) c1[i])
			+ originalInstance.value((int) c2[i]);
		if (!instance.attribute(i).isNominal())
		    instance.setValue(i, beta + temp);
	    }
	    instance.setClassValue(originalInstance.classValue());
	    transformedDataSet.add(instance);
	    index++;
	}
	return transformedDataSet;
    }

    /**
     * @param args
     * @throws FileNotFoundException
     */
    public static void main(String[] args) {
	ArffConector conector = new ArffConector();
	Instances dataset = null;
	String projectPath = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";
	String folderResults = "IntraSession-SemNominal/";

	try {
	    dataset = conector.openDataSet(projectPath + folderResults
		    + "IntraSession-User_41_Day_1_Scrolling.arff");
	} catch (FileNotFoundException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}

	DoubleSum sum = new DoubleSum(dataset);
	System.out.println(sum.generate());
    }

    @Override
    public Instances generate() {
	double[] key = generateRandomArray(0,
		originalDataSet.numAttributes() - 1,
		originalDataSet.numAttributes() - 1);
	@SuppressWarnings("unchecked")
	Enumeration<Instance> en = originalDataSet.enumerateInstances();
	Instances betaDataSet = new Instances(originalDataSet);
	betaDataSet.clear();
	// Permuting all the dataset
	while (en.hasMoreElements()) {
	    Instance instance = en.nextElement();
	    betaDataSet.add(permuteArray(instance, key));
	}

	double[] c1 = generateRandomArray(0, originalDataSet.numAttributes(),
		originalDataSet.numAttributes());
	double[] c2 = generateRandomArray(0, originalDataSet.numAttributes(),
		originalDataSet.numAttributes());

	// for (int i = 0; i < 1; i++) {
	Instances transformed = generateCancelableDataSet(betaDataSet, c1, c2);
	c1 = generateRandomArray(0, originalDataSet.numAttributes(),
		originalDataSet.numAttributes());
	c2 = generateRandomArray(0, originalDataSet.numAttributes(),
		originalDataSet.numAttributes());
	// }
	return transformed;
    }

    private Instances generateCancelableDataSet(Instances dataset, double[] c1,
	    double[] c2) {
	return doublesum(dataset, c1, c2);
    }
}
