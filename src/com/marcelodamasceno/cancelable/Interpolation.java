package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;
import java.util.Enumeration;

import org.apache.commons.math3.analysis.UnivariateFunction;
import org.apache.commons.math3.analysis.interpolation.SplineInterpolator;
import org.apache.commons.math3.analysis.interpolation.UnivariateInterpolator;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.InstancesUtils;
import com.marcelodamasceno.util.Transformations;
import com.marcelodamasceno.util.Utils;

import weka.core.Instance;
import weka.core.Instances;

/**
 * This class creates a cancelable dataset using the interpolation approach
 * 
 * @author marcelo
 * 
 */
public class Interpolation {

    /**
     * X array - Number of attributes
     */
    private double[] x;
    
    /**
     * Random X array
     */
    private double[] xRandom;


    /**
     * Y array
     */
    private double[] y;
    /**
     * Y array with the aplication of the poli object using the xRandom array.
     * yTransformed=poli(xRandom)
     */
    private double[] yTransformed;

    
    /**
     * Interpolator
     */
    UnivariateInterpolator interpolator;

    
    /**
     * Polynomial 
     */
    UnivariateFunction poli;

    
    /**
     *Original dataSet 
     */
    Instances dataSet;


    /**
     * Constructor
     * @param data
     */
    public Interpolation(Instance data) {
	x = new double[data.numAttributes() - 1];
	y = new double[data.numAttributes() - 1];
	xRandom = new double[data.numAttributes() - 1];
	yTransformed = new double[data.numAttributes() - 1];
	feedArrays(data);
	interpolator = new SplineInterpolator();
    }

    /**
     * Crates a Polynomial Interpolation using the data present in the dataset
     * 
     * @param data
     *            Dataset
     */
    public Interpolation(Instances data) {
	dataSet = data;
	x = new double[data.numAttributes() - 1];
	y = new double[data.numAttributes() - 1];
	xRandom = new double[data.numAttributes() - 1];
	yTransformed = new double[data.numAttributes() - 1];
	interpolator = new SplineInterpolator();
    }

    /**
     * Generate the cancelableDataSet
     * 
     * @return
     */
    private Instances interpolateInstances() {
	Instances transformedDataSet = new Instances(dataSet);
	transformedDataSet.clear();
	for (Instance instance : dataSet) {
	    feedArrays(instance);
	    transformedDataSet.add(interpolate());
	}
	return transformedDataSet;
    }

    /**
     * Generate the transformed instance with the interpolate function
     * 
     * @return
     */
    public Instance interpolate() {
	poli = interpolator.interpolate(x, y);
	return createTransformedInstance();
    }

    /**
     * Feed the x and y array
     * 
     * @param data
     *            DataSet will be converted
     */
    private void feedArrays(Instance data) {
	for (int i = 0; i < data.numAttributes() - 1; i++) {
	    x[i] = i;
	    if (data.attribute(i).isNominal()) {
		y[i] = Double.parseDouble(data.stringValue(i));
	    } else {
		y[i] = data.value(i);
	    }
	}
    }

    /**
     * Feed the x and y array
     * 
     * @param data
     *            DataSet will be converted
     */
    @SuppressWarnings("unused")
    private void feedArrays(Instances data) {
	for (int i = 0; i < data.numInstances(); i++) {
	    // data.numAttributes*i is the position the data will be included.
	    // This is because the data is placed in sequential order.
	    addInstance(data.get(i), data.numAttributes() * i);
	}
    }

    /**
     * Add the instance in x and y array
     * 
     * @param instance
     *            Instance
     * @param position
     *            position in sequential order
     */
    private void addInstance(Instance instance, int position) {
	// feeding the arrays y and x
	for (int i = 0; i < instance.numAttributes(); i++) {
	    y[position] = instance.value(i);
	    x[position] = position;
	}
    }

    /**
     * Return the created polynomial
     * 
     * @return Polynomial
     */
    public UnivariateFunction getPolynomial() {
	return poli;
    }

    public Instances createCancelableDataSetOneFunctionForAllDataSet() {
	Utils.createRandomArray(0, dataSet.numAttributes(),
		dataSet.numAttributes());
	Instances cancelableDataSet = Transformations.doubleToInstances(
		yTransformed, dataSet.numAttributes());
	return cancelableDataSet;
    }

    /**
     * Generate the transformed instance with the interpolate function and the
     * random array xRandom
     * 
     * @return
     */
    private Instance createTransformedInstance() {
	for (int i = 0; i < xRandom.length; i++) {
	    yTransformed[i] = poli.value(xRandom[i]);
	}
	return Transformations.doubleArrayToInstanceWithClass(yTransformed,
		dataSet);
    }

    public void printArray(double[] a) {
	System.out.print("{");
	for (int i = 0; i < a.length; i++)
	    System.out.print(a[i] + " , ");
	System.out.print("}");
    }

    public static void main(String[] args) throws FileNotFoundException {
	ArffConector conector = new ArffConector();
	Instances dataset = null;
	String projectPath = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";
	String folderResults = "IntraSession/";

	dataset = conector.openDataSet(projectPath + folderResults
		+ "IntraSession-User_41_Day_1_Scrolling.arff");
	/*
	 * Create the revocable database where it was used a interpolation for
	 * each instance
	 */
	Instances cancelableDataSet = new Instances(dataset);
	cancelableDataSet.clear();
	@SuppressWarnings("unchecked")
	Enumeration<String> en = dataset.classAttribute().enumerateValues();
	InstancesUtils iUtils = new InstancesUtils();

	// Creating the key d
	Utils.createRandomArray(0, dataset.numAttributes(),
		dataset.numAttributes());

	while (en.hasMoreElements()) {
	    String classe = (String) en.nextElement();
	    Instances subDataSet = iUtils.subInstances(dataset, classe);
	    Interpolation inter2 = new Interpolation(subDataSet);
	    Instances instances = inter2.interpolateInstances();
	    cancelableDataSet.addAll(instances);

	}
	System.out.println("****Original********");
	System.out.println(dataset);
	System.out.println("****Cancelável********");
	System.out.println(cancelableDataSet);
    }

}
