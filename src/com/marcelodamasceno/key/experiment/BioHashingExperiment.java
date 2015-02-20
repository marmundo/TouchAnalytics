package com.marcelodamasceno.key.experiment;

import java.io.FileNotFoundException;
import java.util.ArrayList;

import weka.core.Instances;

import com.marcelodamasceno.cancelable.BioHashing;
import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Const;
import com.marcelodamasceno.util.InstancesUtils;
import com.marcelodamasceno.util.Utils;

public class BioHashingExperiment {

    ArffConector conector = null;
    Instances dataset = null;
    int numAttributes=0;
    Instances keyArray=null;
    Instances tempDataSet=null;
    BioHashing bio=null;
    String projectPath = Const.DATASETPATH;
    String folderResults = "IntraSession-SemNominal/";
    String tempResults="";
    String fileName="";
    Instances client=null;
    Instances impostor=null;    
    private Instances clientProtected;
    private Instances impostorProtected;
    private InstancesUtils instUtil;
    private double threshold=0;

    
    
    protected void executeFeatureSelectionExperiment(){
	/**List of attribute Index which belongs to key with small size=0.25*/
	ArrayList<Integer> small= new ArrayList<Integer>();
	small.add(25);
	small.add(24);
	small.add(21);
	small.add(12);
	small.add(4);
	small.add(13);

	/**List of attribute Index which belongs to key with medium size=0.5*/
	ArrayList<Integer> medium= new ArrayList<Integer>();
	medium.addAll(small);
	medium.add(11);
	medium.add(17);
	medium.add(15);
	medium.add(18);
	medium.add(19);
	medium.add(3);	

	/**List of attribute Index which belongs to key with big size = 0.75*/
	ArrayList<Integer> big= new ArrayList<Integer>();
	big.addAll(medium);
	big.add(14);
	big.add(2);
	big.add(5);
	big.add(20);
	big.add(6);
	big.add(10);

	
	executeFixedExperimentFS(small, medium, big);
	executeDifferentExperimentFS(small, medium, big);
	

    }


    private void executeFixedExperimentFS(ArrayList<Integer> small, ArrayList<Integer> medium, ArrayList<Integer> big){
	fixedKeyStandard();
	fixedKeySmallFS(small);
	fixedKeyMediumFS(medium);
	fixedKeyBigFS(big);
    }

    private void executeDifferentExperimentFS(ArrayList<Integer> small, ArrayList<Integer> medium, ArrayList<Integer> big){
	differentKeyStandard();
	differentKeySmallFS(small);
	differentKeyMediumFS(medium);
	differentKeyBigFS(big);
    }

    private void executeFixedExperiment(){
	fixedKeyStandard();
	fixedKeySmall();
	fixedKeyMedium();
	fixedKeyBig();
    }

    private void executeDifferentExperiment(){
	differentKeyStandard();
	differentKeySmall();
	differentKeyMedium();
	differentKeyBig();	
    }

    protected void executeExperiment(){
	executeFixedExperiment();
	executeDifferentExperiment();
    }
    
    private void fixedKeyBigFS(ArrayList<Integer> big){
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Big key

	    tempResults=Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Fixed/Big/";
	    tempDataSet=Utils.getAttributes(dataset, big);

	    bio=new BioHashing(tempDataSet,threshold);
	    if(user==1){
		numAttributes=tempDataSet.numAttributes()-1;
		keyArray=bio.generateRandomVectors(numAttributes);
	    }
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Big_Threshold_"+threshold+"_"+fileName);
	    user++;
	}
    }
    private void fixedKeyBig(){
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Big key

	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Big/";
	    tempDataSet=Utils.getAttributes(dataset, 0.75);

	    bio=new BioHashing(tempDataSet,threshold);
	    if(user==1){
		numAttributes=tempDataSet.numAttributes()-1;
		keyArray=bio.generateRandomVectors(numAttributes);
	    }
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Big_Threshold_"+threshold+"_"+fileName);
	    user++;
	}
    }
    private void fixedKeyMedium(){
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Medium key

	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Medium/";	    
	    tempDataSet=Utils.getAttributes(dataset, 0.5);

	    bio=new BioHashing(tempDataSet,threshold);
	    if(user==1){
		numAttributes=tempDataSet.numAttributes()-1;
		keyArray=bio.generateRandomVectors(numAttributes);
	    }
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Med_Threshold_"+threshold+"_"+fileName);
	    user++;
	}
    }

    private void fixedKeyMediumFS(ArrayList<Integer> medium){
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Medium key
	    
	    tempResults=Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Fixed/Medium/";
	    tempDataSet=Utils.getAttributes(dataset, medium);
	    bio=new BioHashing(tempDataSet,threshold);
	    if(user==1){
		numAttributes=tempDataSet.numAttributes()-1;
		keyArray=bio.generateRandomVectors(numAttributes);
	    }
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Med_Threshold_"+threshold+"_"+fileName);
	    user++;
	}
    }
    private void fixedKeySmallFS(ArrayList<Integer> small){
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }


	    //Small key

	    tempResults=Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Fixed/Small/";	   
	    tempDataSet=Utils.getAttributes(dataset, small);
	    bio=new BioHashing(tempDataSet,threshold);
	    if(user==1){
		numAttributes=tempDataSet.numAttributes()-1;
		keyArray=bio.generateRandomVectors(numAttributes);
	    }
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Sml_Threshold_"+threshold+"_"+fileName);
	    user++;
	}
    }

    private void fixedKeySmall(){
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }


	    //Small key

	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Small/";	  
	    tempDataSet=Utils.getAttributes(dataset, 0.25);

	    bio=new BioHashing(tempDataSet,threshold);
	    if(user==1){
		numAttributes=tempDataSet.numAttributes()-1;
		keyArray=bio.generateRandomVectors(numAttributes);
	    }
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Sml_Threshold_"+threshold+"_"+fileName);
	    user++;
	}
    }

    private void fixedKeyStandard(){
	int user=1;
	while(user<=41){
	    String fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset=conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Standard key
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Standard/";
	    numAttributes=dataset.numAttributes()-1; 
	    bio = new BioHashing(dataset,threshold);
	    if(user==1)
		keyArray=bio.generateRandomVectors(numAttributes);
	    Utils.WriteToFile(bio.generate(keyArray),tempResults,"BioHashing_Fixed_Std_Threshold_"+threshold+"_"+fileName);
	    user++;
	}
    }
    private void differentKeyBigFS(ArrayList<Integer> big){
	int user=1;
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Different/Big/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, big);

	    client= instUtil.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= instUtil.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    clientProtected=bio.generate();

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    impostorProtected=bio.generate();	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.WriteToFile(protectedData,tempResults,"BioHashing_Different_Big_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }

    private void differentKeyBig(){
	int user=1;
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Big/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, 0.75);


	    client= instUtil.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= instUtil.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    clientProtected=bio.generate();

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    impostorProtected=bio.generate();	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.WriteToFile(protectedData,tempResults,"BioHashing_Different_Big_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }
    
    private void differentKeyMediumFS(ArrayList<Integer> medium){
	int user=1;
	while(user<=41){	  
	    tempResults=Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Different/Medium/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, medium);

	    client= instUtil.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= instUtil.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    clientProtected=bio.generate();

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    impostorProtected=bio.generate();	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.WriteToFile(protectedData,tempResults,"BioHashing_Different_Med_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }
    private void differentKeyMedium(){
	int user=1;
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Medium/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, 0.5);

	    client= instUtil.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= instUtil.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    clientProtected=bio.generate();

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    impostorProtected=bio.generate();	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.WriteToFile(protectedData,tempResults,"BioHashing_Different_Med_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }
    private void differentKeySmallFS(ArrayList<Integer> small){
	int user=1;
	while(user<=41){

	    tempResults=Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Different/Small/";	 
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, small);

	    client= instUtil.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= instUtil.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    clientProtected=bio.generate();

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    impostorProtected=bio.generate();	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.WriteToFile(protectedData,tempResults,"BioHashing_Different_Sml_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }

    private void differentKeySmall(){
	int user=1;
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Small/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, 0.25);

	    client= instUtil.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= instUtil.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    clientProtected=bio.generate();

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    impostorProtected=bio.generate();	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.WriteToFile(protectedData,tempResults,"BioHashing_Different_Sml_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }

    private void differentKeyStandard(){
	int user=1;
	/**Standard key*/
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Standard/";
	    instUtil=new InstancesUtils();
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(projectPath + folderResults
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    
	    client= instUtil.getInstances(dataset, Const.POSITIVE);
	    impostor= instUtil.getInstances(dataset, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    clientProtected=bio.generate();

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    impostorProtected=bio.generate();	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.WriteToFile(protectedData,tempResults,"BioHashing_Different_Std_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }

    public BioHashingExperiment(){
	conector=new ArffConector();
    }

    public static void main(String[] args){	

	//Fixed key
	BioHashingExperiment bHExperiment=new BioHashingExperiment();
	
	bHExperiment.threshold=0.5;
	
	bHExperiment.executeExperiment();
	bHExperiment.executeFeatureSelectionExperiment();

    }

}
