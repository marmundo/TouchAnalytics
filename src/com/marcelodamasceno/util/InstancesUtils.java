package com.marcelodamasceno.util;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Enumeration;

import weka.core.Instance;
import weka.core.Instances;

public class InstancesUtils {

    /**
     * Generates a subset of instances which class attribute is classe
     * 
     * @param instances
     *            Instances object
     * @param classe
     *            String value of class
     * @return A subset of instances
     */
    public Instances getInstances(Instances instances, String classe) {
	Instances subDataSet = new Instances(instances);
	subDataSet.clear();
	for (Instance instance : instances) {
	    if (instance.stringValue(instance.classAttribute()).equals(classe)) {
		subDataSet.add(instance);
	    }
	}
	return subDataSet;
    }

    /**
     * Copies the values of the attribute in the attrIndexOrigin position to the
     * attrIndexDestiny position of the destiny Instance
     * 
     * @param origin
     *            Origin DataSet
     * @param attrIndexOrigin
     *            Index of the origin attribute
     * @param destiny
     *            Destiny DataSet
     * @param attrIndexDestiny
     *            Index of the destiny attribute
     */
    public static void copyAttributeValue(Instances origin,
	    int attrIndexOrigin, Instances destiny, int attrIndexDestiny) {
	if (origin.numInstances() == destiny.numInstances()) {
	    for (int instance = 0; instance < origin.numInstances(); instance++) {
		destiny.instance(instance).setValue(attrIndexDestiny,
			origin.instance(instance).value(attrIndexOrigin));
	    }
	}
    }

    public static ArrayList<Double> getMeanAtributes(Instances dataset){
	ArrayList<Double> meanAttributes = new ArrayList<Double>();
	for(int index=0;index<dataset.numAttributes()-2;index++){
	    
	    double[] attributeValues = dataset.attributeToDoubleArray(index); 
	    meanAttributes.add(Double.valueOf(Utils.mean(attributeValues)));
	}	    
	return meanAttributes;
    }



    /**
     * @param args
     */
    public static void main(String[] args) {
	 String fileName="IntraSession-User_1_Day_1_Scrolling.arff";	
	    Instances dataset = null;
	    try {
		ArffConector conector = new ArffConector();
		dataset=conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	System.out.println(InstancesUtils.getMeanAtributes(dataset).toString());

    }

}
