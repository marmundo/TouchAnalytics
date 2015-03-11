package com.marcelodamasceno.key.experiment;

import java.io.FileNotFoundException;
import java.util.ArrayList;

import weka.core.Instances;

import com.marcelodamasceno.cancelable.BioHashing;
import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Const;
import com.marcelodamasceno.util.InstancesUtils;
import com.marcelodamasceno.util.Utils;

public class BioHashingExperiment extends CancelableExperiment {

    public static void main(String[] args){	

	//Filling the orientation array
	String[] orientation=new String[2];
	orientation[0]=Const.SCROOLING;
	orientation[1]=Const.HORIZONTAL;
	
	//Executing the experiment to each orientation
	for (int i = 0; i < orientation.length; i++) {	
	    BioHashingExperiment bHExperiment=new BioHashingExperiment(orientation[i]);	
	    try {
		bHExperiment.executeExperiment(false);

		ArrayList<Integer> small=getSmall();
		ArrayList<Integer> medium=getMedium(small);
		bHExperiment.executeFeatureSelectionExperiment(false,small,medium,getBig(medium));
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
    }

    ArffConector conector = null;

    int numAttributes=0;

    Instances keyArray=null;  
    BioHashing bio=null;


    Instances client=null;       
    Instances impostor=null;
    private Instances clientProtected;
    private Instances impostorProtected;

    private double threshold=0;


    private Instances tempDataSet;


    public BioHashingExperiment(String orientation){
	super("BioHashing",orientation);
	conector=new ArffConector();
    }

    protected void differentKeyBig( ){
	int user=1;
	while(user<=41){
	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Different/Big/");
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, 0.75);


	    client= InstancesUtils.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= InstancesUtils.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    try {
		clientProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    try {
		impostorProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.writeToFile(protectedData,tempResults,"FS/BioHashing_Different_Big_Threshold_"+bio.getThreshold()+"_"+getFileName());
	    }
	    user++;
	}
    }
    protected void differentKeyBigFS(ArrayList<Integer> big){
	int user=1;
	while(user<=41){
	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Different/Big/");
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, big);

	    client= InstancesUtils.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= InstancesUtils.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    try {
		clientProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    try {
		impostorProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.writeToFile(protectedData,tempResults,"NoFS/BioHashing_Different_Big_Threshold_"+bio.getThreshold()+"_"+getFileName());
	    }
	    user++;
	}
    }    
    protected void differentKeyMedium(){
	int user=1;
	while(user<=41){
	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Different/Medium/");
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, 0.5);

	    client= InstancesUtils.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= InstancesUtils.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    try {
		clientProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    try {
		impostorProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.writeToFile(protectedData,tempResults,"FS/BioHashing_Different_Med_Threshold_"+bio.getThreshold()+"_"+getFileName());
	    }
	    user++;
	}
    }
    protected void differentKeyMediumFS(ArrayList<Integer> medium){
	int user=1;
	while(user<=41){	  
	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Different/Medium/");
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, medium);

	    client= InstancesUtils.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= InstancesUtils.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    try {
		clientProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    try {
		impostorProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.writeToFile(protectedData,tempResults,"NoFS/BioHashing_Different_Med_Threshold_"+bio.getThreshold()+"_"+getFileName());
	    }
	    user++;
	}
    }
    protected void differentKeySmall(){
	int user=1;
	while(user<=41){
	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Different/Small/");
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, 0.25);

	    client= InstancesUtils.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= InstancesUtils.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    try {
		clientProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    try {
		impostorProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.writeToFile(protectedData,tempResults,"FS/BioHashing_Different_Sml_Threshold_"+bio.getThreshold()+"_"+getFileName());
	    }
	    user++;
	}
    }
    protected void differentKeySmallFS(ArrayList<Integer> small){
	int user=1;
	while(user<=41){

	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Different/Small/");	 
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    tempDataSet=Utils.getAttributes(dataset, small);

	    client= InstancesUtils.getInstances(tempDataSet, Const.POSITIVE);
	    impostor= InstancesUtils.getInstances(tempDataSet, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    try {
		clientProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    try {
		impostorProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.writeToFile(protectedData,tempResults,"NoFS/BioHashing_Different_Sml_Threshold_"+bio.getThreshold()+"_"+getFileName());
	    }
	    user++;
	}
    }


    protected void differentKeyStandard(){
	int user=1;
	/**Standard key*/
	while(user<=41){
	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Different/Standard/");	
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	

	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    client= InstancesUtils.getInstances(dataset, Const.POSITIVE);
	    impostor= InstancesUtils.getInstances(dataset, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client,threshold);
	    try {
		clientProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }

	    //Generating protected impostor samples using a single key
	    bio=new BioHashing(impostor,threshold);
	    try {
		impostorProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    

	    if(clientProtected.addAll(impostorProtected)){
		Instances protectedData=clientProtected;
		Utils.writeToFile(protectedData,tempResults,"FS/BioHashing_Different_Std_Threshold_"+bio.getThreshold()+"_"+getFileName());
	    }
	    user++;
	}
    }

    protected void fixedKeyBig(boolean saveBeforeDiscretization){
	int user=1;
	while(user<=41){
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Big key

	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Big/");
	    tempDataSet=Utils.getAttributes(dataset, 0.75);	    
	    try {
		generate(user, saveBeforeDiscretization,"NoFS/BioHashing_Fixed_Big_Threshold_");
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    
	    user++;
	}
    }

    protected void generate(int user, boolean saveBeforeDiscretization, String prefixFileName) throws Exception{
	BioHashing bio=new BioHashing(tempDataSet,threshold);	
	if(user==1){
	    int numAttributes = tempDataSet.numAttributes()-1;
	    keyArray=bio.generateRandomVectors(numAttributes);
	}	
	if(saveBeforeDiscretization){
	    Instances bioHashing=bio.generate(keyArray,saveBeforeDiscretization,getFileName());
	    setFileName(prefixFileName+bio.getThreshold()+"_"+getFileName());
	    Utils.writeToFile(bioHashing,tempResults,getFileName());
	}else{	
	    setFileName(prefixFileName+bio.getThreshold()+"_"+getFileName());
	    Utils.writeToFile(bio.generate(keyArray),tempResults,getFileName());
	}
    }

    protected void fixedKeyBigFS(ArrayList<Integer> big, boolean saveBeforeDiscretization){
	int user=1;
	while(user<=41){
	    setFileName("IntraSession-User_"+user+"_Day_1_Scrolling.arff");	
	    try {
		setDataset(conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER+ getFileName()));
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Big key

	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Big/");
	    tempDataSet=Utils.getAttributes(dataset, big);    
	    try {
		generate(user,saveBeforeDiscretization,"FS/BioHashing_Fixed_Big_Threshold_");
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    
	    user++;
	}
    }

    protected void fixedKeyMedium(boolean saveBeforeDiscretization){
	int user=1;
	while(user<=41){
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Medium key

	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Medium/");	    
	    tempDataSet=Utils.getAttributes(dataset, 0.5);
	    try {
		generate(user, saveBeforeDiscretization,"NoFS/BioHashing_Fixed_Med_Threshold_");
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    
	    user++;
	}
    }

    protected void fixedKeyMediumFS(ArrayList<Integer> medium, boolean saveBeforeDiscretization){
	int user=1;
	while(user<=41){
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Medium key

	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Medium/");
	    tempDataSet=Utils.getAttributes(dataset, medium);
	    try {
		generate(user, saveBeforeDiscretization,"FS/BioHashing_Fixed_Med_Threshold_");
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	    user++;
	}
    }




    protected void fixedKeySmall(boolean saveBeforeDiscretization){
	int user=1;
	while(user<=41){
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    //Small key

	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Small/");	  
	    tempDataSet=Utils.getAttributes(dataset, 0.25);	    
	    try {
		generate(user, saveBeforeDiscretization,"NoFS/BioHashing_Fixed_Sml_Threshold_");
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    
	    user++;
	}
    }
    protected void fixedKeySmallFS(ArrayList<Integer> small, boolean saveBeforeDiscretization){
	int user=1;
	while(user<=41){
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName());
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Small key

	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Small/");	   
	    tempDataSet=Utils.getAttributes(dataset, small);
	    try {
		generate(user, saveBeforeDiscretization,"FS/BioHashing_Fixed_Sml_Threshold_");
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	    user++;
	}
    }

    protected void fixedKeyStandard(boolean saveBeforeDiscretization){
	int user=1;
	while(user<=41){
	    setFileName("IntraSession-User_"+user+"_Day_1_"+getOrientation()+".arff");	
	    try {
		setDataset(conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ getFileName()));
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Standard key
	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Standard/");
	    tempDataSet=getDataset();	    	    
	    try {
		generate(user, saveBeforeDiscretization,"BioHashing_Fixed_Std_Threshold_");
	    } catch (Exception e) {
		e.printStackTrace();
	    }	    
	    user++;
	}
    }



    public static ArrayList<Integer> getBig(ArrayList<Integer> medium){
	/**List of attribute Index which belongs to key with big size = 0.75*/
	ArrayList<Integer> big= new ArrayList<Integer>();
	big.addAll(medium);
	big.add(14);
	big.add(2);
	big.add(5);
	big.add(20);
	big.add(6);
	big.add(10);
	return big;
    }

   

    public static ArrayList<Integer> getMedium(ArrayList<Integer> small){
	/**List of attribute Index which belongs to key with medium size=0.5*/
	ArrayList<Integer> medium= new ArrayList<Integer>();
	medium.addAll(small);
	medium.add(11);
	medium.add(17);
	medium.add(15);
	medium.add(18);
	medium.add(19);
	medium.add(3);	
	return medium;
    }

    public static  ArrayList<Integer> getSmall(){
	/**List of attribute Index which belongs to key with small size=0.25*/
	ArrayList<Integer> small= new ArrayList<Integer>();
	small.add(25);
	small.add(24);
	small.add(21);
	small.add(12);
	small.add(4);
	small.add(13);
	return small;
    }
}
