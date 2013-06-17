package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;
import java.util.ArrayList;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.GramSchmidt;
import com.marcelodamasceno.util.Matriz;


import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

public class BioHashing extends Cancelable{

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
		for(int row=0;row<m;row++){
			Instance inst=new DenseInstance(m);
			for(int a=0;a<m;a++){
				inst.setValue(attributeList.get(a), Math.random());
			}
			randowDataSet.add(inst);
		}
		/*Aplicando o processo de Gram-Schimdth*/
		GramSchmidt gram= new GramSchmidt(randowDataSet);
		Instances orthonormalInstances=gram.execute();
		//randowDataSet=null;
		
		
		
		
		/*Produto interno entre o dataset biométrico e o vetor orthornormal*/
		Instances product= Matriz.innerProduct(data, orthonormalInstances);
		product=discretization(product, 0.55);
		/*System.out.println("orto(m,n): ("+orthonormalInstances.numInstances()+" , "+orthonormalInstances.numAttributes()+")");
		System.out.println("data(m,n): ("+data.numInstances()+" , "+data.numAttributes()+")");
		System.out.println("product(m,n): ("+product.numInstances()+" , "+product.numAttributes()+")");
		System.out.println(product);*/
		return product;
	}
	
	/**
	 * Discretizes the dataset to 1 when the value is higher than thereshold, else ortherwise
	 * @param data Instances that will be discretized
	 * @param thereshold Thereshold
	 * @return
	 */
	private Instances discretization(Instances data,double thereshold){
		for(int i=0;i<data.numInstances();i++){
			for(int j=0;j<data.numAttributes();j++){
				if(data.get(i).value(j)>thereshold){
					data.get(i).setValue(j, 1.0);
				}else{
					data.get(i).setValue(j,0.0);
				}
			}
		}
		return data;
	}
	

	/**
	 * @param args
	 * @throws FileNotFoundException 
	 */
	public static void main(String[] args){
		
		ArffConector conector=new ArffConector();
		Instances dataset=null;
		String projectPath="/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";		
		String folderResults="IntraSession/";
		
		try {
		    dataset = conector.openDataSet(projectPath+folderResults+"IntraSession-User_41_Day_1_Scrolling.arff");
		} catch (FileNotFoundException e) {
		    // TODO Auto-generated catch block
		    e.printStackTrace();
		}
		BioHashing bio = new BioHashing(dataset);
		bio.execute(dataset.numAttributes());

	}

}
