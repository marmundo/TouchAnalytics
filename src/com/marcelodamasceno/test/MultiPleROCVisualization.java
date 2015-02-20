package com.marcelodamasceno.test;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Random;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Const;
import com.marcelodamasceno.visualization.VisualizeROC;

import weka.classifiers.Classifier;
import weka.classifiers.evaluation.Evaluation;
import weka.classifiers.evaluation.ThresholdCurve;
import weka.classifiers.lazy.IBk;
import weka.core.Instances;

public class MultiPleROCVisualization {

    private void FeatureSelectionFixedPlot(double threshold) throws Exception{
	Instances standardFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Fixed/Standard/BioHashing_Fixed_Std_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	standardFixedUser1.setClassIndex(standardFixedUser1.numAttributes() - 1);
	
	Instances smallFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/FeatureSelection/User_1/Fixed/Small/BioHashing_Fixed_Sml_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	smallFixedUser1.setClassIndex(smallFixedUser1.numAttributes() - 1);

	Instances mediumFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/FeatureSelection/User_1/Fixed/Medium/BioHashing_Fixed_Med_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	mediumFixedUser1 .setClassIndex(mediumFixedUser1 .numAttributes() - 1);

	Instances bigFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/FeatureSelection/User_1/Fixed/Big/BioHashing_Fixed_Big_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	bigFixedUser1.setClassIndex(bigFixedUser1.numAttributes() - 1);

	trainEvaluateVizualize(standardFixedUser1, smallFixedUser1, mediumFixedUser1, bigFixedUser1,"Fixed Feature Selection");


    }

    private void FeatureSelectionDifferentPlot(double threshold) throws Exception{
	Instances standardFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Different/Standard/BioHashing_Different_Std_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));
	standardFixedUser1.setClassIndex(standardFixedUser1.numAttributes() - 1);

	Instances smallFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/FeatureSelection/User_1/Different/Small/BioHashing_Different_Sml_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	smallFixedUser1.setClassIndex(smallFixedUser1.numAttributes() - 1);

	Instances mediumFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/FeatureSelection/User_1/Different/Medium/BioHashing_Different_Med_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	mediumFixedUser1 .setClassIndex(mediumFixedUser1 .numAttributes() - 1);

	Instances bigFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/FeatureSelection/User_1/Different/Big/BioHashing_Different_Big_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	bigFixedUser1.setClassIndex(bigFixedUser1.numAttributes() - 1);

	trainEvaluateVizualize(standardFixedUser1, smallFixedUser1, mediumFixedUser1, bigFixedUser1,"Different Feature Selection");
    }

    private void FixedPlot(double threshold) throws Exception{
	Instances standardFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Fixed/Standard/BioHashing_Fixed_Std_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));
	standardFixedUser1.setClassIndex(standardFixedUser1.numAttributes() - 1);

	Instances smallFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Fixed/Small/BioHashing_Fixed_Sml_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	smallFixedUser1.setClassIndex(smallFixedUser1.numAttributes() - 1);

	Instances mediumFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Fixed/Medium/BioHashing_Fixed_Med_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	mediumFixedUser1 .setClassIndex(mediumFixedUser1 .numAttributes() - 1);

	Instances bigFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Fixed/Big/BioHashing_Fixed_Big_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	bigFixedUser1.setClassIndex(bigFixedUser1.numAttributes() - 1);

	trainEvaluateVizualize(standardFixedUser1, smallFixedUser1, mediumFixedUser1, bigFixedUser1,"Fixed Keys");
    }

    private void DifferentPlot(double threshold) throws Exception{
	Instances standardFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Different/Standard/BioHashing_Different_Std_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));
	standardFixedUser1.setClassIndex(standardFixedUser1.numAttributes() - 1);

	Instances smallFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Different/Small/BioHashing_Different_Sml_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	smallFixedUser1.setClassIndex(smallFixedUser1.numAttributes() - 1);

	Instances mediumFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Different/Medium/BioHashing_Different_Med_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	mediumFixedUser1 .setClassIndex(mediumFixedUser1 .numAttributes() - 1);

	Instances bigFixedUser1 = new Instances(
		new BufferedReader(
			new FileReader(Const.PROJECTPATH+"BioHashing/User_1/Different/Big/BioHashing_Different_Big_Threshold_"+threshold+"_IntraSession-User_1_Day_1_Scrolling.arff")));

	bigFixedUser1.setClassIndex(bigFixedUser1.numAttributes() - 1);

	trainEvaluateVizualize(standardFixedUser1, smallFixedUser1, mediumFixedUser1, bigFixedUser1,"Different Keys");
    }

    private void trainEvaluateVizualize(Instances standardFixedUser1, Instances smallFixedUser1, Instances mediumFixedUser1, Instances bigFixedUser1, String plotName) throws Exception{
	// train classifier
	Classifier cl = new IBk(5);
	
	

	Evaluation evalStd=new Evaluation(standardFixedUser1);
	evalStd.crossValidateModel(cl, standardFixedUser1, 10, new Random(1));

	Evaluation evalSmall = new Evaluation(smallFixedUser1);
	evalSmall.crossValidateModel(cl, smallFixedUser1, 10, new Random(1));

	// train classifier

	Evaluation evalMedium = new Evaluation(mediumFixedUser1);
	evalMedium.crossValidateModel(cl, mediumFixedUser1, 10, new Random(1));

	// train classifier

	Evaluation evalBig = new Evaluation(bigFixedUser1);
	evalBig.crossValidateModel(cl, bigFixedUser1, 10, new Random(1));


	ArrayList<Evaluation> evalList=new ArrayList<Evaluation>();
	evalList.add(evalStd);
	evalList.add(evalSmall);
	evalList.add(evalMedium);
	evalList.add(evalBig);

	ArrayList<String> rocCurvesNames=new ArrayList<String>();
	rocCurvesNames.add("Standard");
	rocCurvesNames.add("Small");
	rocCurvesNames.add("Medium");
	rocCurvesNames.add("Big");

	ArffConector a =new ArffConector();
	ThresholdCurve t= new ThresholdCurve();
	Instances rocCurve=t.getCurve(evalSmall.predictions());
	rocCurve.setRelationName("small");
	Instances [] rocCurves= new Instances[3];
	rocCurves[0]=rocCurve;


	a.save(rocCurve, "small.arff");

	rocCurve=t.getCurve(evalMedium.predictions());
	rocCurve.setRelationName("medium");
	rocCurves[1]=rocCurve;
	a.save(rocCurve, "medium.arff");

	rocCurve=t.getCurve(evalBig.predictions());
	rocCurve.setRelationName("big");
	rocCurves[2]=rocCurve;
	a.save(rocCurve, "big.arff");
	vizualize(evalList, rocCurvesNames, plotName);

    }

    private void vizualize(ArrayList<Evaluation> evalList, ArrayList<String> rocCurvesNames, String plotName) throws Exception{
	/*args1[0]="small.arff";
	args1[1]="medium.arff";
	args1[2]="big.arff";*/
	//VisualizeMultipleROC.main(args1);

	VisualizeROC v= new VisualizeROC();
	//v.vizualizeMultipleROCs(rocCurves);
	v.visualizeMultipleROCs(evalList,rocCurvesNames,plotName);
    }

    public static void main(String[] args) throws Exception{

	MultiPleROCVisualization m=new MultiPleROCVisualization();
	double threshold=0.5;
	
	m.FeatureSelectionFixedPlot(threshold);
	m.FeatureSelectionDifferentPlot(threshold);
	
	m.FixedPlot(threshold);
	m.DifferentPlot(threshold);


    }
}
