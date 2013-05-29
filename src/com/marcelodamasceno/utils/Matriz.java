package com.marcelodamasceno.utils;

import weka.core.Instances;
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
		if(xM.getColumnDimension()==yM.getRowDimension()){
			double r=0;
			double[][]xD=xM.getArray();		
			double[][]yD=yM.getArray();		
			for(int i=0;i<xM.getRowDimension()-1;i++){				
				r=r+xD[i][0]*yD[0][i];			
			}		
			return r;
		}throw new IllegalArgumentException("Matrix dimensions must agree.");
	}

	public static Instances innerProduct(Instances xM, Instances yM){
		Transformations t = new Transformations();
		Matrix x=new Matrix(t.instancestoArray(xM));
		Matrix y=new Matrix(t.instancestoArray(yM));
		Matrix times=x.transpose().times(y);
		return t.MatrixtoInstances(times);
	}
}
