package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;

import org.apache.commons.math3.analysis.UnivariateFunction;
import org.apache.commons.math3.analysis.interpolation.SplineInterpolator;
import org.apache.commons.math3.analysis.interpolation.UnivariateInterpolator;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Const;
import com.marcelodamasceno.util.Transformations;
import com.marcelodamasceno.util.Utils;

import weka.core.Instance;
import weka.core.Instances;

/**
 * This class creates a cancelable dataset using the interpolation approach
 * 
 *  A function f is created based on interpolation of the original dataset
 *  Inside the f domain, creates a array x with random numbers
 *  The x coefficients is applief to the function f created by Interpolation
 *  The output of f(x) is the transformed data, i.e, cancelable dataset
 * 
 * @author marcelo
 * 
 */
public class Interpolation extends Cancelable {

    /**
     * X array - Number of attributes
     * This array is used in Interpolation function
     */
    private double[] xAttributePosition;
    
    /**
     * Value of attributes. This array is used in Interpolation function
     */
    private double[] yAttributeValue;

    /**
     * Random X array
     */
    private double[] randomArrayKey;   

    public double[] getRandomArrayKey() {
        return randomArrayKey;
    }

    public void setRandomArrayKey(double[] randomArrayKey) {
        this.randomArrayKey = randomArrayKey;
    }

    
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
     * Original dataSet
     */
    Instances dataSet;

    /**
     * Constructor
     * 
     * @param data
     */
    public Interpolation(Instance data) {
	xAttributePosition = new double[data.numAttributes() - 1];
	yAttributeValue = new double[data.numAttributes() - 1];
	randomArrayKey = new double[data.numAttributes() - 1];
	yTransformed = new double[data.numAttributes() - 1];
	instanceToXY(data);
	interpolator = new SplineInterpolator();

    }

    /**
     * Constructor
     * 
     * @param data Original Dataset
     *            
     */
    public Interpolation(Instances data) {	
	this(data,new double[data.numAttributes() - 1]);	
    }   

    /**
     * Constructor
     * @param data Original DataSet
     * @param randomKey Array with random numbers which will be the key
     */
    public Interpolation(Instances data, double[] randomKey){
	dataSet=data;
	xAttributePosition = new double[data.numAttributes() - 1];
	yAttributeValue = new double[data.numAttributes() - 1];
	setRandomArrayKey(randomKey);
	yTransformed=new double[randomKey.length];
	interpolator = new SplineInterpolator();
    }

    /**
     * Interpolates the instances 
     * @return Instances interpolated
     */
    private Instances interpolateInstances() {
	Instances transformedDataSet = new Instances(dataSet);
	transformedDataSet.clear();
	for (Instance instance : dataSet) {
	    instanceToXY(instance);
	    Instance transformedInstance = interpolate();
	    transformedInstance.setClassValue(instance.classValue());
	    transformedDataSet.add(transformedInstance);
	}
	return transformedDataSet;
    }

    /**
     * Generate the transformed instance with the interpolate function
     * 
     * @return Intance interpolated
     */
    public Instance interpolate() {
	poli = interpolator.interpolate(xAttributePosition, yAttributeValue);
	return createTransformedInstance();
    }

    /**
     * Feed the x and y array
     * 
     * @param data
     *            DataSet will be converted
     */
    private void instanceToXY(Instance data) {
	
	for (int i = 0; i < data.numAttributes() - 1; i++) {	    
	    xAttributePosition[i] = i;
	    if (data.attribute(i).isNominal()) {
		yAttributeValue[i] = Double.parseDouble(data.stringValue(i));
	    } else {
		yAttributeValue[i] = data.value(i);
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
	    yAttributeValue[position] = instance.value(i);
	    xAttributePosition[position] = position;
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
	for (int i = 0; i < randomArrayKey.length; i++) {
	    yTransformed[i] = poli.value(randomArrayKey[i]);
	}
	return Transformations.doubleArrayToInstanceWithClass(yTransformed,
		dataSet);
    }

    /* (non-Javadoc)
     * @see com.marcelodamasceno.cancelable.Cancelable#generate()
     */
    public Instances generate(){
	int keySize=dataSet.numAttributes()-1;
	return generate(keySize);
    }

    /**
     * Generates the cancelable dataset using random key <code>randomArrayKey</code>
     * @param randomArrayKey
     * 		key which is a array with random numbers
     * @return cancelable dataset
     */
    public Instances generate(double[] randomArrayKey){
	/**Cancelable dataset*/
	Instances cancelableDataSet = new Instances(dataSet);
	cancelableDataSet.clear();
	setRandomArrayKey(randomArrayKey);
	cancelableDataSet.addAll(interpolateInstances());

	return cancelableDataSet;
    }
    
    /**
     * Generates the cancelable dataset using Interpolation with size of key <code>keySize</code>
     * @param keySize
     * @return cancalable dataset
     */
    public Instances generate(int keySize) {
	/**Cancelable dataset*/
	Instances cancelableDataSet = new Instances(dataSet);
	cancelableDataSet.clear();
	
	/**Creating the key d with size keySize*/
	randomArrayKey = Utils.createRandomArray(0, dataSet.numAttributes() - 1, keySize);

	cancelableDataSet.addAll(interpolateInstances());

	return cancelableDataSet;

    }

    public static void main(String[] args) {
	ArffConector conector = new ArffConector();
	Instances dataset = null;
	String projectPath = Const.DATASETPATH;
	String folderResults = "IntraSession/";

	try {
	    dataset = conector.openDataSet(projectPath + folderResults
		    + "IntraSession-User_41_Day_1_Scrolling.arff");
	} catch (FileNotFoundException e) {
	    e.printStackTrace();
	}

	Interpolation inter = new Interpolation(dataset);
	System.out.println("****Original********");
	System.out.println(dataset.get(0).toString());
	System.out.println("****Cancelável********");
	System.out.println(inter.generate().get(0).toString());
	
	/**Fixed key*/
	
		/**Standard key*/
	
		/**Small key*/
	
		/**Big key*/
	
	/**Different key*/
	
		/**Standard key*/
	
		/**Small key*/
	
		/**Big key*/
    }

}
