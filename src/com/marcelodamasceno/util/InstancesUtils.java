package com.marcelodamasceno.util;

import weka.core.Instance;
import weka.core.Instances;

public class InstancesUtils {
	
	/**
	 * Generates a subset of instances which class attribute is classe
	 * @param instances Instances object
	 * @param classe String value of class
	 * @return A subset of instances
	 */
	public Instances subInstances(Instances instances,String classe){
		Instances subDataSet=new Instances(instances);
		subDataSet.clear();
		for (Instance instance : instances) {
			if(instance.stringValue(instance.classAttribute())==classe){				
				subDataSet.add(instance);
			}
		}
		return subDataSet;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
