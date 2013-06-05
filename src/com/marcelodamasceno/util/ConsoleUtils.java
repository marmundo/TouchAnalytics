package com.marcelodamasceno.util;

/**
 * @author marcelo
 *
 *This class is composed of methods to facility the console prints with diverses classes
 */
public class ConsoleUtils {
	
	public static void printArray(double[] array, String name){
		System.out.println("Array "+name+" :");
		for (int i = 0; i < array.length; i++) {
			System.out.print(array[i]+ " , ");
		}
		System.out.println();
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
