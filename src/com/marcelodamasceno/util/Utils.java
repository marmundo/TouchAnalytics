package com.marcelodamasceno.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.Random;


import weka.core.Attribute;
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
    public static void WriteToFile(Instances dataset, String folder, String fileName){
	ArffConector conector=new ArffConector();
	conector.save(dataset, folder, fileName);
    }
    
    /**
     * Writes in a file
     * @param eerStatistics
     */
    public static void WriteToFile(ArrayList<EERStatistics> eerStatistics){
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
    public static int getRandowNumber(int min, int max) {
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
	    randomNum = getRandowNumber(min, max);
	    randomArray[i] = randomNum;	   
	}
	return randomArray;
    }

    public static void main(String args[]){
	Utils util = new Utils();
	util.writeToFile("teste", "teste");
	util.writeToFile("teste", "testing");
    }
}
