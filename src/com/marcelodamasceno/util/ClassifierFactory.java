package com.marcelodamasceno.util;

import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.SMO;
import weka.classifiers.lazy.IBk;

/**
 * Factory of Classifiers
 * @author marcelo
 *
 */
public class ClassifierFactory {
    
      
    /**
     * Construct a SVM classifier
     * @param options Options of SVM classifier
     * @return
     */
    private Classifier SVM(String options){
	SMO svm=new SMO();	
	if(options.length()!=0){
	    try {		
		String[] opt=weka.core.Utils.splitOptions(options);
		svm.setOptions(opt);
	    } catch (Exception e) {
		e.printStackTrace();
	    }	
	}     
	return svm;
    }
    
    private Classifier KNN(int k){
	return new IBk(k);
    }
    
    
    
    /**
     * Get classifier with parameters
     * @param classifier Name of Classifier present in Const Class
     * @param param Parameters of classsifier
     * @return
     */
    public Classifier getClassifier(String classifier, int param){	
	if(classifier.equalsIgnoreCase(Const.KNN)){
	    return KNN(param);
	}	
	return null;
    }

    /**
     * Construct a classifier with diverse parameters
     * @param classifier Name of Classifier present in Const Class
     * @return Classifier
     */
    public Classifier getClassifier(String classifier){
	if(classifier.equalsIgnoreCase(Const.SVM_GAMMA_0_01)){
	    //String[] opt=weka.core.Utils.splitOptions("-C 1.0 -L 0.001 -P 1.0E-12 -N 0 -V -1 -W 1 -K \"weka.classifiers.functions.supportVector.RBFKernel -G 0.01 -C 250007\"");
	    String options="-C 1.0 -L 0.001 -P 1.0E-12 -N 0 -V -1 -W 1 -K \"weka.classifiers.functions.supportVector.RBFKernel -G 0.01 -C 250007\"";
	    return SVM(options);	    
	}
	if(classifier.equalsIgnoreCase(Const.SVM)){
	    return SVM("");
	}
	if(classifier.equalsIgnoreCase(Const.KNN)){
	    return new IBk();
	}
	if(classifier.equalsIgnoreCase(Const.NAIVE)){
	    return new NaiveBayes();
	}
	return null;
    }


}
