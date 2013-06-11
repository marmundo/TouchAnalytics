package com.marcelodamasceno.util;

import java.util.Random;

/**
 * Class with diverses facilities
 * @author marcelo
 *
 */
public class Utils {

	
	public static int getRandowNumber(int min, int max){
		Random rand= new Random();	

		// nextInt is normally exclusive of the top value,
		// so add 1 to make it inclusive
		return rand.nextInt(max - min + 1) + min;
	}
	
	/**
	 * Generates a RandowArray with min=0 and max=num of attributes of the current instance
	 * @return
	 */
	public static double[] createRandomArray(int min, int max, int length){
		Random rand= new Random();
		max=max-1;
		
		double []randomArray=new double[length];

		// nextInt is normally exclusive of the top value,
		// so add 1 to make it inclusive
		int randomNum = rand.nextInt(max - min + 1) + min;
		for(int i=0;i<length;i++){
			randomArray[i]=randomNum;			
			randomNum = rand.nextInt(max - min + 1) + min;
		}
		return randomArray;
	}
}
