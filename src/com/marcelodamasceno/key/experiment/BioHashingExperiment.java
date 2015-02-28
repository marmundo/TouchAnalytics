package com.marcelodamasceno.key.experiment;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collection;

import weka.core.Instances;

import com.marcelodamasceno.cancelable.BioHashing;
import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Const;
import com.marcelodamasceno.util.InstancesUtils;
import com.marcelodamasceno.util.Utils;

public class BioHashingExperiment {

    ArffConector conector = null;
    Instances dataset = null;
    public Instances getDataset() {
        return dataset;
    }


    public void setDataset(Instances dataset) {
        this.dataset = dataset;
    }

    int numAttributes=0;
    Instances keyArray=null;
    Instances tempDataSet=null;
    public Instances getTempDataSet() {
        return tempDataSet;
    }


    public void setTempDataSet(Instances tempDataSet) {
        this.tempDataSet = tempDataSet;
    }

    BioHashing bio=null;       
    String tempResults="";
    String fileName="";
    public String getTempResults() {
        return tempResults;
    }


    public void setTempResults(String tempResults) {
        this.tempResults = tempResults;
    }


    public String getFileName() {
        return fileName;
    }


    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    Instances client=null;
    Instances impostor=null;    
    private Instances clientProtected;
    private Instances impostorProtected;
    private InstancesUtils instUtil;
    private double threshold=0;


    private ArrayList<Integer> getSmall(){
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
    
    private ArrayList<Integer> getMedium(ArrayList<Integer> small){
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
    
    private ArrayList<Integer> getBig(ArrayList<Integer> medium){
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
    

    protected void executeFeatureSelectionExperiment(boolean saveBeforeDiscretization) throws Exception{
	
	ArrayList<Integer> small = getSmall();
	
	ArrayList<Integer> medium=getMedium(small);

	ArrayList<Integer> big=getBig(medium);

	executeFixedExperimentFS(small, medium, big,saveBeforeDiscretization);
	//executeDifferentExperimentFS(small, medium, big);
    }


    protected void executeFixedExperimentFS(ArrayList<Integer> small, ArrayList<Integer> medium, ArrayList<Integer> big,boolean saveBeforeDiscretization) throws Exception{
	fixedKeyStandard(saveBeforeDiscretization);
	fixedKeySmallFS(small,saveBeforeDiscretization);
	fixedKeyMediumFS(medium,saveBeforeDiscretization);
	fixedKeyBigFS(big,saveBeforeDiscretization);
    }
    

    private void executeDifferentExperimentFS(ArrayList<Integer> small, ArrayList<Integer> medium, ArrayList<Integer> big) throws Exception{
	differentKeyStandard();
	differentKeySmallFS(small);
	differentKeyMediumFS(medium);
	differentKeyBigFS(big);
    }

    protected void executeFixedExperiment(boolean saveBeforeDiscretization) throws Exception{
	fixedKeyStandard(saveBeforeDiscretization);
	fixedKeySmall(saveBeforeDiscretization);
	fixedKeyMedium(saveBeforeDiscretization);
	fixedKeyBig(saveBeforeDiscretization);
    }

   


    private void executeDifferentExperiment() throws Exception{
	differentKeyStandard();
	differentKeySmall();
	differentKeyMedium();
	differentKeyBig();	
    }

    protected void executeExperiment(boolean saveBeforeDiscretization) throws Exception{
	executeFixedExperiment(saveBeforeDiscretization);
	executeDifferentExperiment();
    }



    private void generate(int user, boolean saveBeforeDiscretization) throws Exception{
	bio=new BioHashing(tempDataSet,threshold);
	if(user==1){
	    numAttributes=tempDataSet.numAttributes()-1;
	    keyArray=bio.generateRandomVectors(numAttributes);
	}
	if(saveBeforeDiscretization){
	    Utils.writeToFile(bio.generate(keyArray,saveBeforeDiscretization,fileName),tempResults,fileName);
	}else{
	    Utils.writeToFile(bio.generate(keyArray),tempResults,fileName);
	}
    }

   private void fixedKeyBigFS(ArrayList<Integer> big, boolean saveBeforeDiscretization) throws Exception{
	int user=1;
	while(user<=41){
	    setFileName("IntraSession-User_"+user+"_Day_1_Scrolling.arff");	
	    try {
		setDataset(conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER+ fileName));
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Big key

	    setTempResults(Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Fixed/Big/");
	    tempDataSet=Utils.getAttributes(dataset, big);
	    setFileName("/Fixed/Big/FS/BioHashing_Fixed_Big_Threshold_"+threshold+"_"+fileName);
	    generate(user,saveBeforeDiscretization);	    
	    user++;
	}
    }
    
    
    

    private void fixedKeyBig(boolean saveBeforeDiscretization) throws Exception{
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Big key

	    setTempResults(Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Big/");
	    tempDataSet=Utils.getAttributes(dataset, 0.75);
	    setFileName("/Fixed/Big/NoFS/BioHashing_Fixed_Big_Threshold_"+threshold+"_"+fileName);
	    generate(user, saveBeforeDiscretization);	    
	    user++;
	}
    }
    private void fixedKeyMedium(boolean saveBeforeDiscretization) throws Exception{
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Medium key

	    setTempResults(Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Medium/");	    
	    tempDataSet=Utils.getAttributes(dataset, 0.5);
	    setFileName("/Fixed/Med/NoFS/BioHashing_Fixed_Med_Threshold_"+threshold+"_"+fileName);
	    generate(user, saveBeforeDiscretization);	    
	    user++;
	}
    }

    private void fixedKeyMediumFS(ArrayList<Integer> medium, boolean saveBeforeDiscretization) throws Exception{
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Medium key

	    setTempResults(Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Fixed/Medium/");
	    tempDataSet=Utils.getAttributes(dataset, medium);
	    setFileName("/Fixed/Med/FS/BioHashing_Fixed_Med_Threshold_"+threshold+"_"+fileName);
	    generate(user, saveBeforeDiscretization);
	    user++;
	}
    }
    
    private void fixedKeySmallFS(ArrayList<Integer> small, boolean saveBeforeDiscretization) throws Exception{
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Small key

	    setTempResults(Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Fixed/Small/");	   
	    tempDataSet=Utils.getAttributes(dataset, small);
	    setFileName("/Fixed/Sml/FS/BioHashing_Fixed_Sml_Threshold_"+threshold+"_"+fileName);
	    bio=new BioHashing(tempDataSet,threshold);
	    generate(user, saveBeforeDiscretization);
	    user++;
	}
    }

    private void fixedKeySmall(boolean saveBeforeDiscretization) throws Exception{
	int user=1;
	while(user<=41){
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }
	    //Small key

	    setTempResults(Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Small/");	  
	    tempDataSet=Utils.getAttributes(dataset, 0.25);
	    setFileName("/Fixed/Sml/NoFS/BioHashing_Fixed_Sml_Threshold_"+threshold+"_"+fileName);
	    generate(user, saveBeforeDiscretization);	    
	    user++;
	}
    }

    private void fixedKeyStandard(boolean saveBeforeDiscretization) throws Exception{
	int user=1;
	while(user<=41){
	    String fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset=conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
			+ fileName);
	    } catch (FileNotFoundException e) {
		e.printStackTrace();
	    }

	    //Standard key
	    setTempResults(Const.PROJECTPATH+"BioHashing/User_"+user+"/Fixed/Standard/");
	    tempDataSet=dataset;
	    setFileName("/Fixed/Std/BioHashing_Fixed_Std_Threshold_"+threshold+"_"+fileName);
	    generate(user, saveBeforeDiscretization);	    
	    user++;
	}
    }
    
    private void differentKeyBigFS(ArrayList<Integer> big) throws Exception{
	int user=1;
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Different/Big/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
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
		Utils.writeToFile(protectedData,tempResults,"BioHashing_Different_Big_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }

    private void differentKeyBig() throws Exception{
	int user=1;
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Big/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
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
		Utils.writeToFile(protectedData,tempResults,"BioHashing_Different_Big_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }

    private void differentKeyMediumFS(ArrayList<Integer> medium) throws Exception{
	int user=1;
	while(user<=41){	  
	    tempResults=Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Different/Medium/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
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
		Utils.writeToFile(protectedData,tempResults,"BioHashing_Different_Med_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }
    private void differentKeyMedium() throws Exception{
	int user=1;
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Medium/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
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
		Utils.writeToFile(protectedData,tempResults,"BioHashing_Different_Med_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }
    private void differentKeySmallFS(ArrayList<Integer> small) throws Exception{
	int user=1;
	while(user<=41){

	    tempResults=Const.PROJECTPATH+"BioHashing/FeatureSelection/User_"+user+"/Different/Small/";	 
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
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
		Utils.writeToFile(protectedData,tempResults,"BioHashing_Different_Sml_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }

    private void differentKeySmall() throws Exception{
	int user=1;
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Small/";
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
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
		Utils.writeToFile(protectedData,tempResults,"BioHashing_Different_Sml_Threshold_"+threshold+"_"+fileName);
	    }
	    user++;
	}
    }

    private void differentKeyStandard() throws Exception{
	int user=1;
	/**Standard key*/
	while(user<=41){
	    tempResults=Const.PROJECTPATH+"BioHashing/User_"+user+"/Different/Standard/";
	    instUtil=new InstancesUtils();
	    fileName="IntraSession-User_"+user+"_Day_1_Scrolling.arff";	
	    try {
		dataset = conector.openDataSet(Const.DATASETPATH + Const.INTRASESSIONFOLDER
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
		Utils.writeToFile(protectedData,tempResults,"BioHashing_Different_Std_Threshold_"+threshold+"_"+fileName);
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

	try {
	    bHExperiment.fixedKeyStandard(true);
	} catch (Exception e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}
	try {
	    bHExperiment.executeFixedExperiment(true);
	} catch (Exception e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}	
	
	//bHExperiment.executeExperiment(true);
	//bHExperiment.executeFeatureSelectionExperiment(true);

    }

}
