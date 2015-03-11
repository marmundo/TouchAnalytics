package com.marcelodamasceno.util;

import java.io.File;

/**
 * Class for Constants names
 * @author marcelo
 *
 */
public final class Const {
    
    public static final String INTERSESSION="intersession";
    public static final String INTERWEEK="interweek";
    public static final String INTRASESSION="intrasession";
    public static final String INCORRECT="incorrect";
    public static final String EER="eer";
    public static final String DATASETPATH="/home/marcelo/ÁreadeTrabalho/projeto/dataset/BasedeToque/";
    public static final String PROJECTPATH="/media/marcelo/Acer/Users/Marcelo/workspace/TouchAnalytics/";
    public static final String NORMANMETHOD="/media/marcelo/Acer/Users/Marcelo/workspace/TouchAnalytics/Norman Methodology";
    public static final String USERPATH = System.getProperty("user.home") + File.separator+"TouchAnalytics"+File.separator+"Results";
    
    public static final String INTERPOLATION="Interpolation";
    public static final String DOUBLESUM="DoubleSum";
    public static final String BIOCONVOLVING="BioConvolving";
    public static final String BIOHASHING="BioHashing";
    public static final String ORIGINAL="Original";
    
    public static final String DECISIONTREE="weka.classifiers.trees.J48";
    public static final String SVM="weka.classifiers.functions.SMO";
    public static final String SVM_GAMMA_0_01="weka.classifiers.functions.SMO -C 1.0 -L 0.001 -P 1.0E-12 -N 0 -V -1 -W 1 -K \"weka.classifiers.functions.supportVector.RBFKernel -G 0.01 -C 250007\"";
    public static final String MLP="weka.classifiers.functions.MultilayerPerceptron";
    public static final String KNN="weka.classifiers.lazy.IBk";    
    public static final String NAIVE="weka.classifiers.bayes.NaiveBayes";
    
    public static final String HORIZONTAL="Horizontal";
    public static final String SCROOLING="Scrolling";
    
    public static final String HOMOGENEOUS="Homogeneous";
    public static final String HETEROGENEOUS="Heterogeneous";
    
    public static final String POSITIVE="positive";
    public static final String NEGATIVE="negative";
    
    public static final String INTRASESSIONFOLDER="IntraSession-SemNominal/";
    
    public static final String ORIGINALSCROOLINGFILENAME="ScrollingInstances.arff";
    public static final String ORIGINAHORIZONTALFILENAME="HorizontalInstances.arff";
    
    
    

}
