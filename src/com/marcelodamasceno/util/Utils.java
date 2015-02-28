package com.marcelodamasceno.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Random;

import org.apache.commons.math3.stat.descriptive.moment.Mean;

import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;

/**
 * Class with diverses facilities
 * 
 * @author marcelo
 * 
 */
public class Utils {

    /**
     * Transform a Double[] array in a double[] array
     * @param arrayDouble
     * @return
     */
    public static double[] transform(Double[] arrayDouble){
	double[] values= new double[arrayDouble.length];
	for (int i = 0; i < arrayDouble.length; i++) {
	    values[i]=arrayDouble[i].doubleValue();
	}
	return values;
    }

    /**
     * Write {@code dataset} to file
     * @param dataset
     * @param fileName
     */
    public static void writeToFile(Instances dataset, String folder, String fileName){
	ArffConector conector=new ArffConector();
	conector.save(dataset, folder, fileName);
    }
    
        
    public static double[] DoubleArrayListTodoubleArray(ArrayList<Double> arrayList){
	double[] output= new double[arrayList.size()];
	for (int i = 0; i < arrayList.size(); i++) {
	    output[i]=arrayList.get(i);
	}
	return output;
    }
    
    
    /**
     * Writes a ArrayList to a File
     * @param fileName File Name
     * @param arrayList ArrayList<Double>
     */
    public static void writeToFile(String fileName, ArrayList<Double> arrayList){
	    writeToFile(fileName, arrayList.toString());	
    }

    
    
    /**
     * Writes in a file
     * @param eerStatistics
     */
    public static void writeEERStatisticsToFile(ArrayList<EERStatistics> eerStatistics){
	for (EERStatistics eerStatistic : eerStatistics) {
	    String content="Mean= "+eerStatistic.getMean()+"\n";
	    content+="Standard Desviation= "+eerStatistic.getStd();			
	    writeToFile(eerStatistic.getName(), content);
	}			
    }

    /**
     * Returns a dataset with {@code percentage} of attributes. The attributes will be chossed from 
     * first attribute in {@code dataset}
     * @param dataset dataset which will be cutted
     * @param percentage percentage of attributes willbe selected
     * @return dataset with {@code percentage} attributes of {@code dataset}
     */
    public static Instances getAttributes(Instances dataset,double percentage){
	Instances newDataSet=new Instances(dataset);	
	int numAttributes=(int) Math.round(dataset.numAttributes()*percentage);	
	while(numAttributes+1!=newDataSet.numAttributes()){	
	    newDataSet.deleteAttributeAt(numAttributes);
	}
	return newDataSet;		
    }
    
  
    
    public static double mean(double[] attributeValues){
	Mean mean=new Mean();
	return mean.evaluate(attributeValues);
    }

    /**
     * Method creates a new DataSet based on {@code dataset} but with only the attributes in {@code attributesIndex}
     * @param dataset Dataset source
     * @param attributeIndexes List of attribute indexes
     * @return A new dataset with the attributes presented in {@code attributeIndexes}
     */
    public static Instances getAttributes(Instances dataset,ArrayList<Integer> attributeIndexes){
	Instances newDataSet=new Instances(dataset);

	/**Filling the Array with the name of attributes which index are in attributeIndexes array */
	ArrayList<String> attributeNames=new ArrayList<String>();
	for (Integer i : attributeIndexes) {
	    String attrName=newDataSet.attribute(i-1).name();
	    attributeNames.add(attrName);
	}	 

	int nAtributes=newDataSet.numAttributes();
	/**Delete the attribute name which is not present in attributeNames array*/
	for(int i=0;i<nAtributes-1;i++){	    
	    String name=newDataSet.attribute(i).name();
	    if(!attributeNames.contains(name) && !name.equals("class")){
		newDataSet.deleteAttributeAt(i);
		i=i-1;
		nAtributes=newDataSet.numAttributes();
	    }
	}

	return newDataSet;		
    }

    /**
     * Create a Instances Objects with {@code name} and number of attributes {@code nAttributes} and {@code nInstances}
     * @param name name of Instances Object
     * @param nAttributes number of attributes
     * @param capacity number max of instances
     * @return a new Instances object
     */
    public static Instances createInstances(String name, int nAttributes,int capacity){
	ArrayList<Attribute> attributeList = new ArrayList<Attribute>(nAttributes);
	for (int i = 1; i <= nAttributes; i++) {
	    Attribute attr = new Attribute("m" + String.valueOf(i));
	    attributeList.add(attr);
	}
	Instances randomDataSet = new Instances(name, attributeList,capacity);
	return randomDataSet;
    }

    /**
     * Generate a random array with size {@code arraySize} and seed {@code seed}.
     * This method generates the same array given the same seed.
     * @param arraySize
     * @param seed
     * @return
     */
    public static double[] generateRandomArray(int arraySize,long seed){	
	double[]output= new double[arraySize];
	Random r=new Random();
	r.setSeed(seed);
	for (int i=0;i<arraySize;i++){	   		
	    output[i]=r.nextInt();
	}
	return output;
    }

    /**
     * Write to a file a double array
     * @param fileName
     * @param content
     */
    public static void writeToFile(String fileName, double[] content){
	try {
	    File file=createAndCheckFile(fileName);
	    BufferedWriter bw = new BufferedWriter(new FileWriter(file.getAbsoluteFile(),true));			
	    for (int i = 0; i < content.length; i++) {
		bw.append(String.valueOf(content[i])+",");				
	    }					
	    bw.close();
	} catch (IOException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}

    }

    /**
     * Create a file and check if it's exists. If false, creates a new one, case false, append the new content in the end of file
     * @param fileName
     * @return
     * @throws IOException
     */
    public static File createAndCheckFile(String fileName) throws IOException{		
	File file=new File(fileName+".txt");
	// if file doesnt exists, then create it
	if (!file.exists())
	    file.createNewFile();
	return file;		
    }

    /**
     * Write the content to a file with a fileName
     * @param fileName Name of file
     * @param content Content
     */
    public static void writeToFile(String fileName,String content){
	try {
	    File file=createAndCheckFile(fileName);
	    BufferedWriter bw = new BufferedWriter(new FileWriter(file.getAbsoluteFile(),true));
	    bw.append(content);		
	    bw.close();
	} catch (IOException e) {			
	    fileName=fileName.substring(0,fileName.length()-20);
	    writeToFile(fileName, content);
	}
    }

    /**
     * Return a random number between <code>min</code> and <code>max</code>
     * @param min
     * @param max
     * @return a random number
     */
    public static int getRandomNumber(int min, int max) {
	Random rand = new Random();

	/**nextInt is normally exclusive of the top value, so add 1 to make it inclusive*/
	return rand.nextInt(max - min + 1) + min;
    }

    /**
     * Generates a array with random numbers with lenght <code> lenght</code>.
     * The elements have minimum <code>min</code> and maximum<code>max</code> values
     * @param min minimum value of elements 
     * @param max maximum value of elements
     * @param length lenght of array
     * @return array with random numbers
     */
    public static double[] createRandomArray(int min, int max, int length) {	
	max = max - 1;
	double[] randomArray = new double[length];

	int randomNum = 0;
	for (int i = 0; i < length; i++) {
	    randomNum = getRandomNumber(min, max);
	    randomArray[i] = randomNum;	   
	}
	return randomArray;
    }

  
   

   

    /**Example of Usage
     * 
    public static void main(String args[]){
	Utils util = new Utils();
	util.writeToFile("teste", "teste");
	util.writeToFile("teste", "testing");
    }*/
}
