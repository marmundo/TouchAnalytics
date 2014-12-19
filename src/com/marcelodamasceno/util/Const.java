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
    public static final String PROJECTPATH="/home/marcelo/Área de Trabalho/projeto/dataset/Base de Toque/";
    public static final String USERPATH = System.getProperty("user.home") + File.separator+"TouchAnalytics"+File.separator+"Results";
    
    public static final String INTERPOLATION="Interpolation";
    public static final String DOUBLESUM="DoubleSum";
    public static final String BIOCONVOLVING="BioConvolving";
    public static final String BIOHASHING="BioHashing";
    public static final String ORIGINAL="Original";
    
    public static final String DECISIONTREE="weka.classifiers.trees.J48";
    public static final String SVM="weka.classifiers.functions.SMO";
    public static final String MLP="weka.classifiers.functions.MultilayerPerceptron";
    public static final String KNN="weka.classifiers.lazy.IBk";
    public static final String NAIVE="weka.classifiers.bayes.NaiveBayes";
    
    public static final String HORIZONTAL="Horizontal";
    public static final String SCROOLING="Scrolling";
    

}
