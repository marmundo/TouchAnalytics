package com.marcelodamasceno.util;

import java.io.FileNotFoundException;

import com.marcelodamasceno.util.ArffConector;

import weka.core.Instances;
import weka.core.matrix.Matrix;

public class GramSchmidt {

    Matrix dataset;

    public GramSchmidt(Instances dataset) {
	this.dataset = new Matrix(Transformations.instancestoArray(dataset));
    }

    /**
     * Projects u over v
     * 
     * @param u
     * @param v
     * @return the projected vector
     */
    private Matrix proj(Matrix u, Matrix v) {
	double temp = Matriz.innerProduct(u.transpose(), v);
	temp = temp / Matriz.innerProduct(u.transpose(), u);
	return u.times(temp);
    }

    private Matrix orthogonalization() {
	int nrow = dataset.getRowDimension() - 1;
	int ncol = dataset.getColumnDimension() - 1;
	Matrix u = new Matrix(nrow + 1, ncol + 1);
	Matrix v = dataset;
	// doing a copy of dataset
	u.setMatrix(0, 0, 0, ncol, dataset.getMatrix(0, 0, 0, ncol));
	// A matrix with one line
	Matrix temp = new Matrix(1, ncol + 1);
	//
	for (int i = 1; i < nrow; i++) {
	    // making the projection for each vector (line) of the data set
	    for (int j = 0; j < i; j++) {
		temp = proj(u.getMatrix(j, j, 0, ncol),
			v.getMatrix(i, i, 0, ncol));
		temp = temp.plus(temp);
	    }
	    // doing the orthogonalization
	    temp = v.getMatrix(i, i, 0, ncol).minus(temp);
	    // doing the orthomalization
	    temp = temp.times(Math.pow(temp.norm1(), -1.0));
	    // putting the new vector into u
	    u.setMatrix(i, i, 0, ncol, temp);
	}
	return u;
    }

    public Instances execute() {
	Matrix matrix = orthogonalization();
	return Transformations.MatrixtoInstances(matrix);
    }

    /**
     * @param args
     * @throws FileNotFoundException
     */
    public static void main(String[] args) throws FileNotFoundException {
	ArffConector conector = new ArffConector();
	Instances dataset = null;
	String projectPath = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";
	String folderResults = "IntraSession/";
	dataset = conector.openDataSet(projectPath + folderResults
		+ "IntraSession-User_41_Day_1_Scrolling.arff");

	GramSchmidt gram = new GramSchmidt(dataset);
	gram.orthogonalization();

    }

}
