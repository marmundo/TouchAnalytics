package com.marcelodamasceno.util;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.math3.stat.StatUtils;
import org.apache.commons.math3.stat.descriptive.moment.Mean;
import org.apache.commons.math3.stat.descriptive.rank.Median;

import com.marcelodamasceno.methodology.Training;
import com.sun.xml.internal.bind.v2.model.impl.ModelBuilder;

import weka.classifiers.lazy.IBk;
import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.ProtectedProperties;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.AddValues;
import weka.filters.unsupervised.attribute.Normalize;

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
    public static Instances getInstances(Instances instances, String classe) {
	Instances subDataSet = new Instances(instances);
	subDataSet.clear();
	for (Instance instance : instances) {
	    if (instance.stringValue(instance.classAttribute()).equals(classe)) {
		subDataSet.add(instance);
	    }
	}
	return subDataSet;
    }

    public static Instances changeClassAttribute(Instances data, List<String> values){
	Instances copyData=new Instances(data);	
	copyData.setClassIndex(copyData.classIndex()-1);
	copyData.deleteAttributeAt(copyData.classIndex()+1);

	Attribute classe = new Attribute("user", values);	
	copyData.insertAttributeAt(classe, copyData.numAttributes());
	copyData.setClassIndex(copyData.numAttributes()-1);

	//Filling copyData;
	for (int i = 0; i < copyData.numInstances(); i++) {
	    String classValue=data.get(i).stringValue(data.classIndex());	    
	    copyData.get(i).setClassValue(classValue);;

	}
	return copyData;
    }

    public static ArrayList<Instances> getTrainingandTestDataSet(Instances datasetTemp,String targetUser){
	ArrayList<Instances> trainingTestDataSet= new ArrayList<Instances>();
	Training training=new Training(datasetTemp);
	Instances trainingDataSet=training.takeTrainingDataSet(datasetTemp,targetUser);	
	trainingTestDataSet.add(trainingDataSet);

	Instances testDataSet=takeTestDataSet(datasetTemp, training.getTrainingUsers());
	trainingTestDataSet.add(testDataSet);

	return trainingTestDataSet;

    }

    public static Instances removeInstancesWithClassValue(Instances dataset,String value){
	for (Instance instance : dataset) {
	    if(instance.classAttribute().value(instance.classIndex())==value){
		dataset.remove(instance);
	    }
	}
	return dataset;
    }

    public static Instances takeTestDataSet(Instances datasetTemp, String[] usersInTrainingDataSet){
	ArrayList<String> usersInTraining=Utils.stringArrayToStringArrayList(usersInTrainingDataSet);
	Instances testDataSet=new Instances(datasetTemp);
	testDataSet.clear();

	for (int testUser = 1; testUser <=41; testUser++) {
	    if(!usersInTraining.contains(String.valueOf(testUser))){
		try{
		    Instances temp=InstancesUtils.changeClassLabel(InstancesUtils.getInstances(datasetTemp,String.valueOf(testUser)),String.valueOf(testUser),"negative");
		    testDataSet.addAll(temp);
		}catch(Exception e){
		    e.printStackTrace();
		}		
	    }
	}
	return testDataSet;
    }



    public static Instances getInstancesWithClassValue(Instances dataset,double[] classValues){
	Instances output=new Instances(dataset);
	output.clear();
	for (int i = 0; i < classValues.length; i++) {
	    Instances temp=getInstances(dataset, String.valueOf(i));
	    output.addAll(temp);
	}
	return output;
    }

    public static Instances changeClassLabel(Instances datasetTemp, String oldLabel, String newLabel){
	datasetTemp.renameAttributeValue(datasetTemp.classAttribute(), oldLabel, newLabel);
	return datasetTemp;
    }

    /**
     * Return a subset of Instances without the instances with classe {@code classe}
     * @param instances
     * @param classe
     * @return
     */
    public static Instances getInstancesWithoutAClass(Instances instances, String classe){
	Instances subDataSet = new Instances(instances);
	subDataSet.clear();
	for (Instance instance : instances) {
	    if (!instance.stringValue(instance.classAttribute()).equals(classe)) {
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

    public static ArrayList<Double> getAttributeValues(Instances dataset){
	ArrayList<Double> attributeValuesArray = new ArrayList<Double>();	
	for(int index=0;index<dataset.numAttributes()-2;index++){	    
	    double[] attributeValues=dataset.attributeToDoubleArray(index);
	    //Transforming a double[] array in a ArrayList
	    for(double d : attributeValues){
		attributeValuesArray.add(d);
	    }
	}	
	return attributeValuesArray;
    }

    public static Instance normalize(Instance data) throws Exception{
	Instances dataset=data.dataset();
	Normalize filter= new Normalize();
	filter.setInputFormat(dataset);
	return Filter.useFilter(dataset, filter).get(0);
    }


    public static Instances normalize(Instances dataset) throws Exception{
	Normalize filter= new Normalize();
	filter.setInputFormat(dataset);
	return  Filter.useFilter(dataset,filter);
    }


    /**
     * Return the Mode
     * @param dataset
     * @return
     */
    public static double getModeInstances(Instances dataset){
	return StatUtils.mode( Utils.DoubleArrayListTodoubleArray(getAttributeValues(dataset)))[0];	
    }

    /**
     * Return the mode
     * @param data
     * @return
     */
    public static double getModeInstance(Instance data){
	return StatUtils.mode(data.toDoubleArray())[0];	
    }
    /**
     * Return the median of all the values in {@code dataset} 
     * @param data
     * @return
     */
    public static double getMedianInstance(Instance data){
	Median m= new Median();
	return m.evaluate(data.toDoubleArray());
    }

    /**
     * Return the median of all the values in {@code dataset} 
     * @param dataset
     * @return
     */
    public static double getMedianInstances(Instances dataset){
	Median m= new Median();
	double[] d=Utils.DoubleArrayListTodoubleArray(getAttributeValues(dataset));	    
	return m.evaluate(d);
    }

    /**
     * Return the mean of all the values in {@code data} 
     * @param data
     * @return
     */
    public static double getMeanInstance(Instance data){
	Mean m= new Mean();		    
	return m.evaluate(data.toDoubleArray());
    }
    /**
     * Return the mean of all the values in {@code dataset} 
     * @param dataset
     * @return
     */
    public static double getMeanInstances(Instances dataset){
	Mean m= new Mean();
	double[] d=Utils.DoubleArrayListTodoubleArray(getAttributeValues(dataset));	    
	return m.evaluate(d);
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

	try {
	    System.out.println(dataset.get(0).toString());
	    System.out.println(InstancesUtils.normalize(dataset.get(0)).toString());
	} catch (Exception e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}
	//System.out.println(InstancesUtils.getMeanAtributes(dataset).toString());

	//Utils.writeToFile("teste.R", InstancesUtils.getAttributeValues(dataset));
	//System.out.println("Median: "+InstancesUtils.getMedianInstances(dataset));
	//System.out.println("Mean: "+InstancesUtils.getMeanInstances(dataset));

    }

}
