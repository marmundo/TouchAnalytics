package com.marcelodamasceno.util;

import weka.core.Instance;
import weka.core.Instances;
import weka.core.matrix.Matrix;

public class Matriz {

    // TODO: See how to use this class as a Matrix. Use innerProduct and the
    // other Matrix features

    /**
     * Inner Product
     * 
     * @param xM
     * @param yM
     * @return
     */
    public static double innerProduct(Matrix xM, Matrix yM) {
	// TODO: Implement a rotine to verify the compatible dimensions between
	// the matrix
	if (xM.getColumnDimension() == yM.getRowDimension()) {
	    double r = 0;
	    double[][] xD = xM.getArray();
	    double[][] yD = yM.getArray();
	    for (int i = 0; i < xM.getRowDimension() - 1; i++) {
		r = r + xD[i][0] * yD[0][i];
	    }
	    return r;
	}
	throw new IllegalArgumentException("Matrix dimensions must agree.");
    }

    public static Instance innerProduct(Instance xM, Instances yM) {
	Matrix x = new Matrix(Transformations.instancetoArray(xM),1);
	Matrix y = new Matrix(Transformations.instancestoArray(yM));
	// Matrix xWithoutClass=x.getMatrix(0, x.getRowDimension()-1, 0,
	// x.getColumnDimension()-2);
	// y=y.getMatrix(0, y.getRowDimension()-2, 0, y.getColumnDimension()-1);
	Matrix times = x.times(y);
	// times.setMatrix(0, x.getRowDimension(), x.getColumnDimension(),
	// x.getColumnDimension(), x.getMatrix(0, x.getRowDimension(),
	// x.getColumnDimension(), x.getColumnDimension()));
	return Transformations.MatrixtoInstance(times);
    }
    
    public static Instances innerProduct(Instances xM, Instances yM) {
	Matrix x = new Matrix(Transformations.instancestoArray(xM));
	Matrix y = new Matrix(Transformations.instancestoArray(yM));
	// Matrix xWithoutClass=x.getMatrix(0, x.getRowDimension()-1, 0,
	// x.getColumnDimension()-2);
	// y=y.getMatrix(0, y.getRowDimension()-2, 0, y.getColumnDimension()-1);
	Matrix times = x.times(y);
	// times.setMatrix(0, x.getRowDimension(), x.getColumnDimension(),
	// x.getColumnDimension(), x.getMatrix(0, x.getRowDimension(),
	// x.getColumnDimension(), x.getColumnDimension()));
	return Transformations.MatrixtoInstances(times);
    }
}
