package com.marcelodamasceno.util;

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
    public Instances subInstances(Instances instances, String classe) {
	Instances subDataSet = new Instances(instances);
	subDataSet.clear();
	for (Instance instance : instances) {
	    if (instance.stringValue(instance.classAttribute()) == classe) {
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

    /**
     * @param args
     */
    public static void main(String[] args) {
	// TODO Auto-generated method stub

    }

}
