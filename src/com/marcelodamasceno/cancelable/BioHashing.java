package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;
import java.util.ArrayList;

import org.omg.CORBA.NVList;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Const;
import com.marcelodamasceno.util.GramSchmidt;
import com.marcelodamasceno.util.InstancesUtils;
import com.marcelodamasceno.util.Matriz;
import com.marcelodamasceno.util.Utils;

import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

public class BioHashing extends Cancelable {

    /**
     * Original Dataset
     */
    private Instances originalDataset;

    /**
     * Constructor
     * @param data Original Dataset
     */
    public BioHashing(Instances data) {
	this.originalDataset = data;
    }

    /* (non-Javadoc)
     * @see com.marcelodamasceno.cancelable.Cancelable#generate()
     */
    public Instances generate(){
	int m=originalDataset.numAttributes() - 1;
	return generate(m);
    }

    /**
     * Generate {@code nVectors} randomicos
     * @param nVectors
     * @return {@code nVectors} randomicos
     */
    private Instances generateRandomVectors(int nVectors){

	ArrayList<Attribute> attributeList = new ArrayList<Attribute>(nVectors);
	for (int i = 1; i <= nVectors; i++) {
	    Attribute attr = new Attribute("m" + String.valueOf(i));
	    attributeList.add(attr);
	}

	Instances randowDataSet = new Instances("randow", attributeList,
		originalDataset.numInstances());
	/* Gerando n vetores randomicos */
	for (int row = 1; row <= nVectors; row++) {
	    Instance inst = new DenseInstance(nVectors);
	    for (int a = 0; a < nVectors; a++) {
		inst.setValue(attributeList.get(a), Math.random());
	    }
	    randowDataSet.add(inst);
	}
	return randowDataSet;
    }

    /**
     * Generates the cancelable dataset
     * @param keyArray Random array used to produce orthornormal vectors
     * @return cancelable BioHashing dataset
     */
    public Instances generate(Instances keyArray) {
	Instances orthonormalInstances=applyGramShimidth(keyArray);
	Attribute classe = originalDataset.classAttribute();
	Instances copyDataset = new Instances(originalDataset);
	copyDataset.setClassIndex(copyDataset.numAttributes() - 2);
	copyDataset.deleteAttributeAt(copyDataset.numAttributes() - 1);


	/* Produto interno entre o dataset biométrico e o vetor orthornormal */

	Instances product = Matriz.innerProduct(copyDataset,
		orthonormalInstances);
	// product = discretization(product, 0.55);
	product = discretization(product);
	product.insertAttributeAt(classe, product.numAttributes());
	InstancesUtils.copyAttributeValue(originalDataset, originalDataset.classAttribute()
		.index(), product, product.numAttributes() - 1);

	return product;

    }

    /**
     * Apply the GramShimidth to get a set of orthonormal vectors from {@code randowDataSet}
     * @param randowDataSet
     * 		Random array used to produce orthornormal vectors
     * @return Orthonormal vectors
     */
    private Instances applyGramShimidth(Instances randowDataSet){
	/* Aplicando o processo de Gram-Schimdth */
	GramSchmidt gram = new GramSchmidt(randowDataSet);
	return gram.execute();	
    }

    /**
     * Creates the cancelable biometric dataset using bioHashing
     * 
     * @param m number of attributes of the cancelable biometric.
     * m can be considered a key. 
     * @return cancelable biometric
     */
    public Instances generate(int m) {    
	/* Creating the m attributes */
	int nAttributes = m;	
	Instances randowDataSet=generateRandomVectors(nAttributes);
	return generate(randowDataSet);	
    }

    /**
     * Discretizes the dataset to 1 when the value is higher than <code>thereshold</code>,
     * else ortherwise
     * 
     * @param data
     *            Instances that will be discretized
     * @param thereshold
     *            Thereshold
     * @return Discretized dataset
     */
    protected Instances discretization(Instances data, double thereshold) {
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
	int numAttributes=0;
	Instances keyArray=null;
	Instances tempDataSet=null;
	BioHashing bio=null;
	String projectPath = Const.DATASETPATH;
	String folderResults = "IntraSession-SemNominal/";
	String tempResults="";
	String fileName="";
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }



	    /**Fixed key*/

	    /**Standard key*/
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Standard/";
	    tempDataSet=dataset;
	    numAttributes=tempDataSet.numAttributes()-1;
	    bio = new BioHashing(tempDataSet);
	    keyArray=bio.generateRandomVectors(numAttributes);
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Std_"+fileName);

	    /**Small key*/

	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Small/";
	    tempDataSet=Utils.getAttributes(dataset, 0.25);	
	    int size=tempDataSet.numAttributes()-1;
	    bio=new BioHashing(tempDataSet);
	    keyArray=bio.generateRandomVectors(size);
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Sml_"+fileName);

	    /**Medium key*/

	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Medium/";
	    tempDataSet=Utils.getAttributes(dataset, 0.5);	
	    size=tempDataSet.numAttributes()-1;
	    bio=new BioHashing(tempDataSet);
	    keyArray=bio.generateRandomVectors(size);
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Med_"+fileName);

	    /**Big key*/

	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Big/";
	    tempDataSet=Utils.getAttributes(dataset, 0.75);	
	    size=tempDataSet.numAttributes()-1;
	    bio=new BioHashing(tempDataSet);
	    keyArray=bio.generateRandomVectors(size);
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Big_"+fileName);

	    /**Different key*/

	    /**Standard key*/
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Standard/";	
	    Utils.WriteToFile(bio.generate(),tempResults,"BioHashing_Different_Std_"+fileName);

	    /**Small key*/

	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Small/";		
	    tempDataSet=Utils.getAttributes(dataset, 0.25);	
	    size=tempDataSet.numAttributes()-1;
	    bio=new BioHashing(tempDataSet);
	    Utils.WriteToFile(bio.generate(size),tempResults,"BioHashing_Different_Sml_"+fileName);

	    /**Medium key*/

	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Medium/";
	    tempDataSet=Utils.getAttributes(dataset, 0.75);	
	    size=tempDataSet.numAttributes()-1;
	    bio=new BioHashing(tempDataSet);		
	    Utils.WriteToFile(bio.generate(size),tempResults,"BioHashing_Different_Med_"+fileName);

	    /**Big key*/

	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Big/";
	    tempDataSet=Utils.getAttributes(dataset, 0.75);	
	    size=tempDataSet.numAttributes()-1;
	    bio=new BioHashing(tempDataSet);	
	    Utils.WriteToFile(bio.generate(size),tempResults,"BioHashing_Different_Big_"+fileName);

	    user++;

	}
    }

}
