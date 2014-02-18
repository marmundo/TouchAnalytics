package com.marcelodamasceno.util;

import java.util.ArrayList;

import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.matrix.Matrix;

/**
 * Class that saves methods to convert differents objects in another compatives
 * objects
 * 
 * @author marcelo
 * 
 */
public class Transformations {

    /**
     * Convert a Instances object to a bidimensional Array
     * 
     * @param dataset
     * @return
     */
    public static double[][] instancestoArray(Instances dataset) {
	int nrow = dataset.numInstances();
	int ncol = dataset.numAttributes();
	double[][] double_dataset = new double[nrow][ncol];
	for (int row = 0; row < dataset.numInstances(); row++) {
	    double_dataset[row] = dataset.get(row).toDoubleArray();
	}
	return double_dataset;
    }

    /**
     * Creates a attribute list using a fixed number of attributes
     * 
     * @param numAttributes
     * @return
     */
    private static ArrayList<Attribute> createAttributeListWithoutClass(
	    int numAttributes) {
	ArrayList<Attribute> attributeList = new ArrayList<Attribute>(
		numAttributes);
	for (int i = 0; i < numAttributes; i++) {
	    Attribute attr = new Attribute("a" + String.valueOf(i));
	    attributeList.add(attr);
	}
	return attributeList;
    }

    /**
     * Creates a attribute list using a fixed number of attributes
     * 
     * @param numAttributes
     * @return
     */
    private static ArrayList<Attribute> createAttributeList(int numAttributes) {
	ArrayList<Attribute> attributeList = new ArrayList<Attribute>(
		numAttributes);
	for (int i = 0; i < numAttributes - 1; i++) {
	    Attribute attr = new Attribute("a" + String.valueOf(i));
	    attributeList.add(attr);
	}
	Attribute classe = new Attribute("class");
	attributeList.add(classe);
	return attributeList;
    }

    /**
     * Transform a double array in Instance object
     * 
     * @param data
     * @return
     */
    public static Instance doubleToInstance(double[] data) {
	Instance instance = new DenseInstance(data.length);
	for (int i = 0; i < data.length; i++) {
	    instance.setValue(i, data[i]);
	}
	return instance;
    }

    /**
     * Transform a Double array in a double array
     * 
     * @param data
     * @return
     */
    public static double[] doubletoDouble(Double[] data) {
	double[] doubleData = new double[data.length];
	for (int i = 0; i < data.length; i++) {
	    doubleData[i] = data[i];
	}
	return doubleData;
    }

    /**
     * Transform a bidimensional double array in a Instances object
     * 
     * @param dataset
     *            Instances object used to set the reader of the return
     * @param transformedDataSet
     *            Bidimensional double Array
     * @return
     */
    public static Instances doubleToInstances(Instances dataset,
	    double[][] transformedDataSet) {
	Instances dataSet = new Instances(dataset);
	for (int row = 0; row < transformedDataSet.length; row++) {
	    dataSet.add(doubleToInstance(transformedDataSet[row]));
	}
	return dataSet;
    }

    /**
     * Transform a doubleArray in Instance Object with class
     * 
     * @param data
     * @param classe
     * @param dataset
     * @return
     */
    public static Instance doubleArrayToInstanceWithClass(double[] data,
	    Instances dataset) {
	DenseInstance instance = new DenseInstance(data.length + 1);
	instance.setDataset(dataset);
	for (int i = 0; i < data.length; i++) {
	    instance.setValue(i, data[i]);
	}
	return instance;
    }

    /**
     * Transform a double array in Instances object
     * 
     * @param data
     *            double array
     * @param numAttributes
     *            number of attributes of the Instances object
     * @return
     */
    public static Instances doubleToInstances(double[] data, int numAttributes) {
	ArrayList<Attribute> attributeList = createAttributeList(numAttributes);
	Instances dataset = new Instances("Transformed DataSet", attributeList,
		data.length);
	Instance instance = new DenseInstance(numAttributes);
	int counter = 0;
	for (int i = 0; i < data.length / numAttributes; i++) {
	    for (int j = 0; j < numAttributes; j++) {
		instance.setValue(j, data[counter]);
		counter++;
	    }
	    dataset.add(instance);
	}
	return dataset;
    }

    /**
     * Convert a Matrix object in a Instances object
     * 
     * @param matrix
     * @return
     */
    public static Instances MatrixtoInstances(Matrix matrix) {
	int m = matrix.getColumnDimension();
	ArrayList<Attribute> attributeList = createAttributeListWithoutClass(m);
	Instances inst = new Instances("dataset", attributeList, m);
	inst.setClassIndex(inst.numAttributes() - 1);
	for (int i = 0; i < matrix.getRowDimension(); i++) {
	    Instance instance = new DenseInstance(m);
	    for (int a = 0; a < m; a++) {
		instance.setValue(attributeList.get(a), matrix.get(i, a));
	    }
	    inst.add(instance);
	}
	return inst;
    }

    public static Instances MatrixtoInstances(Matrix matrix, Instances dataset) {
	int m = matrix.getColumnDimension();
	// ArrayList<Attribute> attributeList = createAttributeList(m);
	Instances inst = dataset;
	inst.clear();
	for (int i = 0; i < matrix.getRowDimension(); i++) {
	    Instance instance = new DenseInstance(m);
	    for (int a = 0; a <= m; a++) {
		instance.setValue(a, matrix.get(i, a));
	    }
	    instance.setClassValue(dataset.get(i).classValue());
	    inst.add(instance);
	}
	return inst;
    }

    /**
     * Transform a Double ArrayList in a double array
     * 
     * @param data
     *            Double ArrayList
     * @return
     */
    public static double[] doubleToDouble(ArrayList<Double> data) {
	double[] dataset = new double[data.size()];
	for (int i = 0; i < data.size(); i++) {
	    dataset[i] = data.get(i);
	}
	return dataset;
    }
}
