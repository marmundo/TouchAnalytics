package com.marcelodamasceno.test;

import java.util.Arrays;
import java.util.Random;

public class Randomtest {
    
    public static double[] generateARandomArray(int arraySize,long seed){	
	double[]output= new double[arraySize];
	Random r=new Random();
	r.setSeed(seed);
	for (int i=0;i<arraySize;i++){	   		
	    output[i]=r.nextInt(10);
	}
	return output;
    }

    public static void main(String[] args) {
	
	System.out.println(Arrays.toString(generateARandomArray(10, 123456789)));
	System.out.println(Arrays.toString(generateARandomArray(10, 123456781)));
	System.out.println("###############");
	System.out.println(Arrays.toString(generateARandomArray(10, 123456789)));
	System.out.println(Arrays.toString(generateARandomArray(10, 123456781)));
	
    }
    

}
