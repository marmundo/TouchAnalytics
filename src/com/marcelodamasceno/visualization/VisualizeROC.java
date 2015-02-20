package com.marcelodamasceno.visualization;

import java.awt.*;
import java.io.*;
import java.util.ArrayList;

import javax.swing.*;

import weka.classifiers.evaluation.Evaluation;
import weka.classifiers.evaluation.ThresholdCurve;
import weka.core.*;
import weka.gui.visualize.*;

/**
 * Visualizes previously saved ROC curves.
 *
 */
public class VisualizeROC {


    public void vizualizeMultipleROCs(Instances[] rocCurves) throws Exception{
	boolean first = true;
	ThresholdVisualizePanel vmc = new ThresholdVisualizePanel();
	for (int i = 0; i < rocCurves.length; i++) {
	    Instances result = rocCurves[i];
	    result.setClassIndex(result.numAttributes() - 1);
	    // method visualize
	    PlotData2D tempd = new PlotData2D(result);
	    tempd.setPlotName(result.relationName());
	    tempd.addInstanceNumberAttribute();
	    // specify which points are connected
	    boolean[] cp = new boolean[result.numInstances()];
	    for (int n = 1; n < cp.length; n++)
		cp[n] = true;
	    tempd.setConnectPoints(cp);
	    // add plot
	    if (first)
		vmc.setMasterPlot(tempd);
	    else
		vmc.addPlot(tempd);
	    first = false;
	}
	// method visualizeClassifierErrors
	final javax.swing.JFrame jf = 
		new javax.swing.JFrame("Weka Classifier ROC");
	jf.setSize(500,400);
	jf.getContentPane().setLayout(new BorderLayout());

	jf.getContentPane().add(vmc, BorderLayout.CENTER);
	jf.addWindowListener(new java.awt.event.WindowAdapter() {
	    public void windowClosing(java.awt.event.WindowEvent e) {
		jf.dispose();
	    }
	});

	jf.setVisible(true);
    }

    public void visualizeMultipleROCs(ArrayList<Evaluation> evalList, ArrayList<String> names, String plotName) throws Exception{
    ThresholdCurve tc=new ThresholdCurve();
	ArrayList<Instances> rocCurves=new ArrayList<Instances>();
	for (int i = 0; i < evalList.size(); i++) {	 
	    Instances curve=tc.getCurve(evalList.get(i).predictions());
	    curve.setRelationName(names.get(i));
	    rocCurves.add(curve);    
	}    	       	
	plotCurve(rocCurves,plotName);
    }
    
    public void visualizeMultipleROCs(ArrayList<Evaluation> evalList, ArrayList<String> names) throws Exception{
	visualizeMultipleROCs(evalList, names,"");
    }	

    public void vizualizeMultipleROCs(ArrayList<Evaluation> evalList) throws Exception{
	ThresholdCurve tc=new ThresholdCurve();
	ArrayList<Instances> rocCurves=new ArrayList<Instances>();
	for (Evaluation eval : evalList) {
	    rocCurves.add(tc.getCurve(eval.predictions()));
	}
	plotCurve(rocCurves,"");
    }

    public void vizualizeSingleROC(Evaluation eval){
	ThresholdCurve tc=new ThresholdCurve();
	Instances rocCurve=tc.getCurve(eval.predictions(),0);
	plotCurve(rocCurve);
    }

    private void plotCurve(ArrayList<Instances> rocCurves, String plotName) throws Exception{
	if(plotName==""){
	    plotName="Weka Classifier ROC";
	}
	boolean first = true;
	ThresholdVisualizePanel vmc = new ThresholdVisualizePanel();
	for (Instances result : rocCurves) {
	    result.setClassIndex(result.numAttributes() - 1);
	    // method visualize
	    PlotData2D tempd = new PlotData2D(result);
	    tempd.setPlotName(result.relationName());
	    tempd.addInstanceNumberAttribute();
	    // specify which points are connected
	    boolean[] cp = new boolean[result.numInstances()];
	    for (int n = 1; n < cp.length; n++)
		cp[n] = true;
	    tempd.setConnectPoints(cp);
	    // add plot
	    if (first)
		vmc.setMasterPlot(tempd);
	    else
		vmc.addPlot(tempd);
	    first = false;
	}
	// method visualizeClassifierErrors
	final javax.swing.JFrame jf = 
		new javax.swing.JFrame(plotName);
	jf.setSize(500,400);
	jf.getContentPane().setLayout(new BorderLayout());

	jf.getContentPane().add(vmc, BorderLayout.CENTER);
	jf.addWindowListener(new java.awt.event.WindowAdapter() {
	    public void windowClosing(java.awt.event.WindowEvent e) {
		jf.dispose();
	    }
	});

	jf.setVisible(true);

    }

    public void plotCurve(Instances rocCurve){
	ThresholdVisualizePanel vmc = new ThresholdVisualizePanel();
	vmc.setROCString("(Area under ROC = " + 
		Utils.doubleToString(ThresholdCurve.getROCArea(rocCurve), 4) + ")");
	vmc.setName(rocCurve.relationName());
	PlotData2D tempd = new PlotData2D(rocCurve);
	tempd.setPlotName(rocCurve.relationName());
	tempd.addInstanceNumberAttribute();
	// specify which points are connected
	boolean[] cp = new boolean[rocCurve.numInstances()];
	for (int n = 1; n < cp.length; n++)
	    cp[n] = true;
	try {
	    tempd.setConnectPoints(cp);
	    //add plot
	    vmc.addPlot(tempd);
	    displayCurve(vmc);
	} catch (Exception e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}
    }

    private void displayCurve(ThresholdVisualizePanel vmc){
	// display curve
	String plotName = vmc.getName(); 
	final javax.swing.JFrame jf = 
		new javax.swing.JFrame("Weka Classifier Visualize: "+plotName);
	jf.setSize(500,400);
	jf.getContentPane().setLayout(new BorderLayout());
	jf.getContentPane().add(vmc, BorderLayout.CENTER);
	jf.addWindowListener(new java.awt.event.WindowAdapter() {
	    public void windowClosing(java.awt.event.WindowEvent e) {
		jf.dispose();
	    }
	});
	jf.setVisible(true);
    }
}


