package com.marcelodamasceno.experiments;

import com.marcelodamasceno.ensemble.VotingDifferentDataSets;
import com.marcelodamasceno.util.Const;

public class VotingClassAntonino {
	
	private void executeInterpolation(String[]classifiers) throws Exception{
		String[]datasets = new String[6];
		datasets[0]=Const.INTERPOLATION;
		datasets[1]=Const.INTERPOLATION;
		datasets[2]=Const.INTERPOLATION;
		datasets[3]=Const.INTERPOLATION;
		datasets[4]=Const.INTERPOLATION;
		datasets[5]=Const.INTERPOLATION;
		
		executeExperiment(classifiers, datasets);
	}
	
	private void executeOriginal(String[]classifiers) throws Exception{
		String[]datasets = new String[6];
		datasets[0]=Const.ORIGINAL;
		datasets[1]=Const.ORIGINAL;
		datasets[2]=Const.ORIGINAL;
		datasets[3]=Const.ORIGINAL;
		datasets[4]=Const.ORIGINAL;
		datasets[5]=Const.ORIGINAL;
		
		executeExperiment(classifiers, datasets);
	}
	
	private void executeBioHashing(String[]classifiers) throws Exception{
		String[]datasets = new String[6];
		datasets[0]=Const.BIOHASHING;
		datasets[1]=Const.BIOHASHING;
		datasets[2]=Const.BIOHASHING;
		datasets[3]=Const.BIOHASHING;
		datasets[4]=Const.BIOHASHING;
		datasets[5]=Const.BIOHASHING;
		
		executeExperiment(classifiers, datasets);
	}

	private void executeBioConvolving(String[]classifiers) throws Exception{
		String[]datasets = new String[6];
		datasets[0]=Const.BIOCONVOLVING;
		datasets[1]=Const.BIOCONVOLVING;
		datasets[2]=Const.BIOCONVOLVING;
		datasets[3]=Const.BIOCONVOLVING;
		datasets[4]=Const.BIOCONVOLVING;
		datasets[5]=Const.BIOCONVOLVING;
		
		executeExperiment(classifiers, datasets);
	}
	
	private void executeDoubleSum(String[]classifiers) throws Exception{
		String[]datasets = new String[6];
		datasets[0]=Const.DOUBLESUM;
		datasets[1]=Const.DOUBLESUM;
		datasets[2]=Const.DOUBLESUM;
		datasets[3]=Const.DOUBLESUM;
		datasets[4]=Const.DOUBLESUM;
		datasets[5]=Const.DOUBLESUM;
		
		executeExperiment(classifiers, datasets);
	}
	
	private void executeExperiment(String[]classifiers,String[]datasets) throws Exception{
		VotingDifferentDataSets teste=new VotingDifferentDataSets(10);
		
		String orientation=Const.HORIZONTAL;
		
		teste.combination(classifiers, datasets, orientation);
		
		orientation=Const.SCROOLING;
		
		teste.combination(classifiers, datasets, orientation);
	}
	
	public static void main(String args[]) throws Exception{
		String[]classifiers = new String[6];
		classifiers[0]=Const.KNN;
		classifiers[1]=Const.KNN;
		classifiers[2]=Const.SVM;
		classifiers[3]=Const.SVM;
		classifiers[4]=Const.NAIVE;
		classifiers[5]=Const.NAIVE;
		
		VotingClassAntonino teste=new VotingClassAntonino();
		teste.executeOriginal(classifiers);
		
		teste.executeInterpolation(classifiers);
		
		teste.executeBioHashing(classifiers);
		
		teste.executeBioConvolving(classifiers);
		
		teste.executeDoubleSum(classifiers);
	}
}
