package com.marcelodamasceno.utils;

import weka.core.matrix.Matrix;



public class Matriz  {

	//TODO: See how to use this class as a Matrix. Use innerProduct and the other Matrix features
	
	/**
	 * Inner Product
	 * @param xM
	 * @param yM
	 * @return
	 */
	public static double innerProduct(Matrix xM, Matrix yM){
		//TODO: Implement a rotine to verify the compatible dimensions between the matrix
		double r=0;
		double[][]xD=xM.getArray();		
		double[][]yD=yM.getArray();		
		for(int i=0;i<xM.getRowDimension()-1;i++){				
			r=r+xD[i][0]*yD[0][i];			
		}		
		return r;
	}
}
