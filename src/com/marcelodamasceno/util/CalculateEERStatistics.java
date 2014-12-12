package com.marcelodamasceno.util;

import java.awt.Container;
import java.io.BufferedReader;
import java.io.File;

import java.io.FileReader;
import java.io.IOException;

import java.util.ArrayList;




import org.apache.commons.math3.stat.descriptive.moment.Mean;
import org.apache.commons.math3.stat.descriptive.moment.StandardDeviation;

public class CalculateEERStatistics {

	private final String parentPath="Experimentos/";
	private String combinationArray[];
	private String experiments[][]=new String[3][6];
	private String path="";
	private String orientation="";
	private int combination=4;
	private int indexExperiment=0;
	
	public CalculateEERStatistics(String orientation, int combination){
		this.orientation=orientation;
		this.combination=combination;		
		fillCombinacao(combination);
		fillExperiments();
	}


	public CalculateEERStatistics(String orientation, int combination, int experiment){
		this.orientation=orientation;
		this.combination=combination;
		indexExperiment=experiment;
		fillCombinacao(combination);
		fillExperiments();
	}

	public CalculateEERStatistics(String orientation){
		fillCombinacao(combination);		
		fillExperiments();		
		this.orientation=orientation;
	}

	public CalculateEERStatistics(){
		fillCombinacao(combination);		
		fillExperiments();		
	}
	
	public CalculateEERStatistics(int combination){		
		fillCombinacao(combination);		
		fillExperiments();		
	}

	private void fillCombinacao(int combination){
		combinationArray=new String[combination-1];
		for(int comb=0;comb+2<=combination;comb++){
			int temp=comb+2;
			combinationArray[comb]="Combinacao"+temp+"x"+temp;
		}			
	}

	private void fillExperiments(){
		//row controls combination
		//column controls experiment		
		experiments[0][0]="BioCBioH";
		experiments[0][1]="DoubBioC";
		experiments[0][2]="DoubBioH";
		experiments[0][3]="InteBioC";
		experiments[0][4]="InteBioH";
		experiments[0][5]="InteDoub";


		experiments[1][0]="DoubBioCBioH";
		experiments[1][1]="InteBioCBioH";
		experiments[1][2]="InteDoubBioC";
		experiments[1][3]="InteDoubBioH";

		experiments[2][0]="InteDoubBioCBioH";		
	}


	public void createExperiments() throws IOException{
		ArrayList<File> eerFiles;
		if(orientation.equals("")){
			orientation=Const.HORIZONTAL;
			eerFiles=createPath(orientation);
			Utils.WriteToFile(execute(eerFiles));
			
			orientation=Const.SCROOLING;
			eerFiles=createPath(orientation);
			Utils.WriteToFile(execute(eerFiles));
		}else{
			if(orientation.equals(Const.HORIZONTAL)){
				eerFiles=createPath(orientation);
				Utils.WriteToFile(execute(eerFiles));

			}else{
				eerFiles=createPath(orientation);
				Utils.WriteToFile(execute(eerFiles));
			}
		}
	}

	private ArrayList<File> createPath(String orientation){
		ArrayList<File> eerFiles=new ArrayList<File>();
		for (int i = 0; i < combinationArray.length; i++) {
			String comb = combinationArray[i];
			for (int j = 0; j < experiments[i].length; j++) {
				if(experiments[i][j]==null)
					break;
				path=parentPath+comb+"/"+orientation+"/"+experiments[i][j]+"/";
				if(i==0){
					path+="EER|-|-|weka.classifiers.lazy.IBk |-|-|weka.classifiers.functions.SMO |-|-|"+experiments[i][j];
				}else{
					if(i==1){
						path+="EER|-|-|weka.classifiers.lazy.IBk |-|-|weka.classifiers.functions.SMO |-|-|weka.classifiers.trees.J48 |-|-|"+experiments[i][j];
					}else{
						path+="EER|-|-|weka.classifiers.lazy.IBk |-|-|weka.classifiers.functions.SMO |-|-|weka.classifiers.trees.J48 |-|-|weka.classifiers.functions.MultilayerPerceptron |-|-|"+experiments[i][j];
					}
				}
				File eerFile= new File(path);
				eerFiles.add(eerFile);
				path="";
			}
		}
		return eerFiles;
	}


	private ArrayList<EERStatistics> execute(ArrayList<File> eerFiles) throws IOException{		
		ArrayList<EERStatistics> eerStatistics=new ArrayList<EERStatistics>();		
		for (File eerFile : eerFiles) {
			eerStatistics.add(calculateStatistics(eerFile));			
		}	
		return eerStatistics;
	}



	private double[] readEERValues(File eerFile) throws IOException{
		BufferedReader br = new BufferedReader(new FileReader(eerFile));
		String line;		
		ArrayList<Double> eerValues=new ArrayList<Double>();

		int linha=1;
		while ((line = br.readLine()) != null) {
			if(linha%2==0){
				eerValues.add(Double.parseDouble(line));
			}
			linha++;
		}
		br.close();
		return Utils.transform(eerValues.toArray(new Double[eerValues.size()]));		
	}

	//average
	//standart deviation
	private EERStatistics calculateStatistics(File eerFile) throws IOException{
		double[] eerValues=readEERValues(eerFile);

		Mean mean=new Mean();
		double doubleMean=mean.evaluate(eerValues);

		StandardDeviation desviation=new StandardDeviation();
		double std=desviation.evaluate(eerValues);

	//	double[] statistics=new double[]{doubleMean,std};

		return new EERStatistics(orientation+" |-| "+eerFile.getName(),doubleMean, std);
	}

	public static void main(String args[]){
		CalculateEERStatistics s=new CalculateEERStatistics(4);
		try {
			s.createExperiments();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
