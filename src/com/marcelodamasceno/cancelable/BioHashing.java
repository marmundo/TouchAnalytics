package com.marcelodamasceno.cancelable;

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

    private double threshold=0;

    /**
     * Constructor
     * @param data Original Dataset 
     */
    public BioHashing(Instances data) {
	this.originalDataset = data;	
    }

    /**
     * Constructor
     * @param data Original Dataset
     * @param threshold 
     */
    public BioHashing(Instances data, double threshold) {
	this.originalDataset = data;
	this.threshold=threshold;
    }

    /* (non-Javadoc)
     * @see com.marcelodamasceno.cancelable.Cancelable#generate()
     */
    public Instances generate() throws Exception{
	int m=originalDataset.numAttributes() - 1;
	return generate(m);
    }



    /**
     * Generates a Instances object with {@code nVectors} random Instances based on {@code key}
     * The same {@code key} generates the same Instances Object.
     * @param nVectors Quantity of rows in Intances objects
     * @param key Key used to generates the random rows. 
     * @return
     */
    public Instances generateRandomVectors(int nVectors, long[] key){	
	Instances randomDataSet=Utils.createInstances("random", nVectors, originalDataset.numInstances());	
	double[] randomDoubleArray;
	/* Gerando n vetores randomicos */
	for (int row = 1; row <= nVectors; row++) {	  
	    randomDoubleArray=Utils.generateRandomArray(nVectors, key[row]);
	    Instance inst = new DenseInstance(nVectors);
	    for (int a = 0; a < nVectors; a++) {
		inst.setValue(randomDataSet.attribute(a), randomDoubleArray[a]);
	    }
	    randomDataSet.add(inst);
	}
	return randomDataSet;
    }

    /**
     * Generate {@code nVectors} randomicos
     * @param nVectors Number of random vectors
     * @return {@code nVectors} randomicos
     */
    public Instances generateRandomVectors(int nVectors){	
	Instances randomDataSet=Utils.createInstances("random", nVectors, originalDataset.numInstances());
	/* Gerando n vetores randomicos */
	for (int row = 1; row <= nVectors; row++) {
	    Instance inst = new DenseInstance(nVectors);
	    for (int a = 0; a < nVectors; a++) {
		inst.setValue(randomDataSet.attribute(a), Math.random());
	    }
	    randomDataSet.add(inst);
	}
	return randomDataSet;
    }

    public Instance generate(Instance bioSample, Instances key) throws Exception{
	Instances orthonormalInstances=applyGramShimidth(key);
	Attribute classe = bioSample.classAttribute();
	bioSample.deleteAttributeAt(bioSample.numAttributes() - 1);
	Instance userProtectedSample=dotProduct(bioSample, orthonormalInstances);
	//Normalize before dot product
	userProtectedSample=InstancesUtils.normalize(userProtectedSample);
	userProtectedSample=discretization(userProtectedSample,threshold);
	userProtectedSample.insertAttributeAt(userProtectedSample.numAttributes());
	userProtectedSample.setValue(userProtectedSample.numAttributes()-1, classe.value(0));	
	return userProtectedSample;

    }

    private Instance dotProduct(Instance bioSampleUser, Instances key){
	return Matriz.innerProduct(bioSampleUser,key);
    }

    private Instances dotProduct(Instances bioSamplesUserSet, Instances key){
	/* Produto interno entre o dataset biométrico e o vetor orthornormal */

	return Matriz.innerProduct(bioSamplesUserSet,key);

    }

    /* Generates the cancelable dataset and save the Instances before discretization with {@code fileName}
     *  if {@code saveBeforeDiscretization}==TRUE
     * @param userSamples User Biometric Sample
     * @param keyArray Random array used to produce orthornormal vectors
     * @param saveBeforeDiscretization flag used to save the instances before discretization step
     * @param fileName fileName of instances to be saved case {@code saveBeforeDiscretization}==TRUE
     * @return BioHashing dataset
     */
    public Instances generate(Instances userSamples,Instances keyArray, boolean saveBeforeDiscretization, String fileName) throws Exception{
	Instances orthonormalInstances=applyGramShimidth(keyArray);
	Attribute classe = originalDataset.classAttribute();	
	userSamples.setClassIndex(userSamples.numAttributes() - 2);
	userSamples.deleteAttributeAt(userSamples.numAttributes() - 1);
	Instances userProtectedSamples=dotProduct(userSamples, orthonormalInstances);
	if(saveBeforeDiscretization){
	    Utils.writeToFile(userProtectedSamples, "BioHashing-Before Discretization", fileName);
	}
	//Normalize before dotproduct
	userProtectedSamples=InstancesUtils.normalize(userProtectedSamples);
	userProtectedSamples = discretization(userProtectedSamples,threshold);
	userProtectedSamples.insertAttributeAt(classe, userProtectedSamples.numAttributes());
	InstancesUtils.copyAttributeValue(originalDataset, originalDataset.classAttribute()
		.index(), userProtectedSamples, userProtectedSamples.numAttributes() - 1);
	userProtectedSamples.setClassIndex(userProtectedSamples.numAttributes()-1);
	return userProtectedSamples;
    }


    /**
     * Generates the cancelable dataset and save the Instances before discretization with {@code fileName}
     *  if {@code saveBeforeDiscretization}==TRUE
     * @param keyArray Random array used to produce orthornormal vectors
     * @param saveBeforeDiscretization flag used to save the instances before discretization step
     * @param fileName fileName of instances to be saved case {@code saveBeforeDiscretization}==TRUE
     * @return cancelable BioHashing dataset
     * @throws Exception 
     */
    public Instances generate(Instances keyArray, boolean saveBeforeDiscretization,String fileName) throws Exception {
	Instances copyDataset = new Instances(originalDataset);
	return generate(copyDataset, keyArray,saveBeforeDiscretization,fileName);
    }

    /**
     * Generates the cancelable dataset
     * @param keyArray Random array used to produce orthornormal vectors
     * @return cancelable BioHashing dataset
     * @throws Exception 
     */
    public Instances generate(Instances keyArray) throws Exception {
	return generate(keyArray, false,"");
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
     * @throws Exception 
     */
    public Instances generate(int m) throws Exception {    
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
    protected Instance discretization(Instance data, double thereshold) {

	for (int j = 0; j < data.numAttributes(); j++) {
	    if (data.value(j) > thereshold) {
		data.setValue(j, 1.0);
	    } else {
		data.setValue(j, 0.0);
	    }
	}
	return data;
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
    private Instance discretization(Instance data) {
	for (int j = 0; j < data.numAttributes(); j++) {
	    double instanceValue = data.value(j);
	    if (instanceValue < 0.25) {
		data.setValue(j, 0);
	    } else {
		if (instanceValue >= 0.25 && instanceValue < 0.5) {
		    data.setValue(j, 0.33);
		} else {
		    if (instanceValue >= 0.5 && instanceValue < 0.75) {
			data.setValue(j, 0.66);
		    } else {
			data.setValue(j, 1);
		    }
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

}
