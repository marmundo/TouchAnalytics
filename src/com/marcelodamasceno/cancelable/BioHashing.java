package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;
import java.util.ArrayList;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.utils.Transformations;

import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

public class BioHashing {

	private Instances data;
	public BioHashing(Instances data){
		this.data=data;
	}
	
	/**
	 * Creates the cancelable biometric dataset using bioHashing
	 * @param m number of attributes of the cancelable biometric
	 * @return
	 */
	public Instances execute(int m){
		/*Creating the m attributes*/
		ArrayList<Attribute> attributeList=new ArrayList<Attribute>(m);
		for(int i=0;i<m;i++){
			Attribute attr = new Attribute("m"+String.valueOf(i));
			attributeList.add(attr);
		}		 
		Instances randowDataSet=new Instances("randow", attributeList, data.numInstances());
		/*Gerando n vetores randomicos*/
		for(int row=0;row<data.numInstances();row++){
			Instance inst=new DenseInstance(m);
			for(int a=0;a<m;a++){
				inst.setValue(attributeList.get(a), Math.random());
			}
			randowDataSet.add(inst);
		}
		Transformations t=new Transformations();
		System.out.println(randowDataSet.get(0).value(0));
		System.out.println(t.instancestoArray(randowDataSet)[0][0]);
		return randowDataSet;
	}
	/**
	 * @param args
	 * @throws FileNotFoundException 
	 */
	public static void main(String[] args) throws FileNotFoundException {
		
		ArffConector conector=new ArffConector();
		Instances dataset=null;
		String projectPath="/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";		
		String folderResults="IntraSession/";
		
		dataset = conector.openDataSet(projectPath+folderResults+"IntraSession-User_41_Day_1_Scrolling.arff");
		BioHashing bio = new BioHashing(dataset);
		bio.execute(dataset.numInstances());

	}

}
