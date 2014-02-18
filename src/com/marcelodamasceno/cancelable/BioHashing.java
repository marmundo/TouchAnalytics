package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;
import java.util.ArrayList;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.GramSchmidt;
import com.marcelodamasceno.util.InstancesUtils;
import com.marcelodamasceno.util.Matriz;

import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

public class BioHashing extends Cancelable {

    private Instances dataset;

    public BioHashing(Instances data) {
	this.dataset = data;
    }

    /**
     * Creates the cancelable biometric dataset using bioHashing
     * 
     * @param m
     *            number of attributes of the cancelable biometric
     * @return
     */
    public Instances generate() {
	/* Creating the m attributes */
	int m = dataset.numAttributes() - 1;
	ArrayList<Attribute> attributeList = new ArrayList<Attribute>(m);
	for (int i = 1; i <= m; i++) {
	    Attribute attr = new Attribute("m" + String.valueOf(i));
	    attributeList.add(attr);
	}
	Instances randowDataSet = new Instances("randow", attributeList,
		dataset.numInstances());
	/* Gerando n vetores randomicos */
	for (int row = 1; row <= m; row++) {
	    Instance inst = new DenseInstance(m);
	    for (int a = 0; a < m; a++) {
		inst.setValue(attributeList.get(a), Math.random());
	    }
	    randowDataSet.add(inst);
	}
	/* Aplicando o processo de Gram-Schimdth */
	GramSchmidt gram = new GramSchmidt(randowDataSet);
	Instances orthonormalInstances = gram.execute();
	// randowDataSet=null;

	Attribute classe = dataset.classAttribute();
	Instances copyDataset = new Instances(dataset);
	copyDataset.setClassIndex(copyDataset.numAttributes() - 2);
	copyDataset.deleteAttributeAt(copyDataset.numAttributes() - 1);

	/* Produto interno entre o dataset biométrico e o vetor orthornormal */
	Instances product = Matriz.innerProduct(copyDataset,
		orthonormalInstances);
	// product = discretization(product, 0.55);
	product = discretization(product);
	product.insertAttributeAt(classe, product.numAttributes());
	InstancesUtils.copyAttributeValue(dataset, dataset.classAttribute()
		.index(), product, product.numAttributes() - 1);

	return product;
    }

    /**
     * Discretizes the dataset to 1 when the value is higher than thereshold,
     * else ortherwise
     * 
     * @param data
     *            Instances that will be discretized
     * @param thereshold
     *            Thereshold
     * @return
     */
    private Instances discretization(Instances data, double thereshold) {
	for (int i = 0; i < data.numInstances(); i++) {
	    for (int j = 0; j < data.numAttributes(); j++) {
		if (data.get(i).value(j) > thereshold) {
		    data.get(i).setValue(j, 1.0);
		} else {
		    data.get(i).setValue(j, 0.0);
		}
	    }
	}
	return data;
    }

    /**
     * Discretizes the dataset using 4 thereshold (0, 0.33, 0.66, 1)
     * 
     * @param data
     * @return Discretized data
     */
    private Instances discretization(Instances data) {
	for (int i = 0; i < data.numInstances(); i++) {
	    for (int j = 0; j < data.numAttributes(); j++) {
		double instanceValue = data.get(i).value(j);
		if (instanceValue < 0.25) {
		    data.get(i).setValue(j, 0);
		} else {
		    if (instanceValue >= 0.25 && instanceValue < 0.5) {
			data.get(i).setValue(j, 0.33);
		    } else {
			if (instanceValue >= 0.5 && instanceValue < 0.75) {
			    data.get(i).setValue(j, 0.66);
			} else {
			    data.get(i).setValue(j, 1);
			}
		    }
		}
	    }
	}
	return data;
    }

    /**
     * @param args
     * @throws FileNotFoundException
     */
    public static void main(String[] args) {

	ArffConector conector = new ArffConector();
	Instances dataset = null;
	String projectPath = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";
	String folderResults = "IntraSession-SemNominal/";

	try {
	    dataset = conector.openDataSet(projectPath + folderResults
		    + "IntraSession-User_41_Day_1_Scrolling.arff");
	} catch (FileNotFoundException e) {
	    e.printStackTrace();
	}
	BioHashing bio = new BioHashing(dataset);
	System.out.println(bio.generate());

    }

}
