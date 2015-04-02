package com.marcelodamasceno.key.experiment;

import java.io.FileNotFoundException;
import java.util.ArrayList;

import weka.core.Instances;

import com.marcelodamasceno.cancelable.BioHashing;
import com.marcelodamasceno.methodology.Main;
import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Const;
import com.marcelodamasceno.util.InstancesUtils;
import com.marcelodamasceno.util.Utils;

/**
 * Class wich generates BioHashing DataSets, with 21 users in training dataset and 
 * the remaining 20 users in test dataset 
 * 
 * @author marcelo
 *
 */
public class BioHashingExperimentNorman extends CancelableExperiment {

    private ArffConector conector;
    private Instances tempDataSet;
    //private double threshold=0;
    private Instances keyArray;
    String[] datasets=new String[2];
    private String[] trainingUsers;   
    
    ArrayList<String> trainingUsersList=new ArrayList<String>();


    public BioHashingExperimentNorman(String cancelableFunctionName, String orientation) {
	super(cancelableFunctionName,orientation);
	conector=new ArffConector();	

	datasets[0]="training.arff";
	datasets[1]="testing.arff";
    }

    public static void main(String[] args){

	//Filling the orientation array	
	String[] orientation=new String[2];
	orientation[0]=Const.SCROOLING;
	orientation[1]=Const.HORIZONTAL;

	//Executing the experiment to each orientation
	for (int i = 0; i < orientation.length; i++) {	
	    //Fixed key
	    BioHashingExperimentNorman bHExperiment=new BioHashingExperimentNorman("BioHashing_Norman",orientation[i]);

	    try {
		bHExperiment.executeExperiment(false);

		ArrayList<Integer> small=BioHashingExperiment.getSmall();
		ArrayList<Integer> medium=BioHashingExperiment.getMedium(small);
		bHExperiment.executeFeatureSelectionExperiment(false,small,BioHashingExperiment.getMedium(small),BioHashingExperiment.getBig(medium));
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
    }

    @Override
    protected void differentKeySmall() {
	// TODO Auto-generated method stub

    }

    @Override
    protected void differentKeyMedium() {
	// TODO Auto-generated method stub

    }

    @Override
    protected void differentKeyBig() {
	// TODO Auto-generated method stub

    }
    
    private Instances generateTrainingSet(Integer user,String orientation){
		    
	Main main=new Main();
	Instances dataset=main.getDataSet(orientation);
	
	String targetUser=String.valueOf(user);
	Instances temp=InstancesUtils.getInstances(dataset, targetUser);
	
	BioHashing bio=new BioHashing(temp);
	try {
	    temp=bio.generate();
	} catch (Exception e) {
	    e.printStackTrace();
	}
	   
   	Instances training=temp;
   	int targetUserInt=Integer.valueOf(user);
   	int quantityClassValues=dataset.classAttribute().numValues();
   	int count=1;
   	trainingUsersList.add(targetUser);
   	while(count!=(quantityClassValues-1)/2){
   	    if(count!=targetUserInt){
   		temp=InstancesUtils.getInstances(dataset, String.valueOf(count));
   		bio.setOriginalDataset(temp);
   		try {
		    temp=bio.generate();
		} catch (Exception e) {
		    e.printStackTrace();
		}
   		training.addAll(temp);
   	    }
   	    trainingUsersList.add(String.valueOf(count));
   	    count++;
   	}
   	setTrainingUsers(Utils.stringArrayListToStringArray(trainingUsersList));	
   	return training;
    }
    
    private Instances generateTestSet(Integer user,String orientation){
	ArrayList<String> usersInTraining=trainingUsersList;
	Instances testDataSet=new Instances(dataset);
	testDataSet.clear();
	
	BioHashing bio=new BioHashing(testDataSet);

	for (int testUser = 1; testUser <=41; testUser++) {
	    if(!usersInTraining.contains(String.valueOf(testUser))){
		try{
		    Instances temp=InstancesUtils.getInstances(dataset,String.valueOf(testUser));
		    bio.setOriginalDataset(temp);
		    temp=bio.generate();
		    testDataSet.addAll(temp);
		}catch(Exception e){
		    e.printStackTrace();
		}		
	    }
	}
	return testDataSet;
    }
    
    public void setTrainingUsers(String[] trainingUsers) {
        this.trainingUsers = trainingUsers;
    }

    @Override
    protected void differentKeyStandard() {
	for (int i = 0; i < datasets.length; i++) { 
	    setFileName(datasets[i]);
	    int user=1;
	    while(user<=41){	
	/**Standard key*/
	
	    setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Different/Standard/");	
	    setDataSetUser(user);

	    
	    Instances client= InstancesUtils.getInstances(dataset, Const.POSITIVE);
	    Instances impostor= InstancesUtils.getInstances(dataset, Const.NEGATIVE);

	    //Generating protected client samples using a single key
	    bio=new BioHashing(client);
	    try {
		clientProtected=bio.generate();
	    } catch (Exception e) {
		e.printStackTrace();
	    }

	    //Generating protected impostor samples using a single key
	    BioHashing bio=new BioHashing(impostor);
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

    @Override
    protected void differentKeySmallFS(ArrayList<Integer> small) {
	// TODO Auto-generated method stub

    }

    @Override
    protected void differentKeyMediumFS(ArrayList<Integer> medium) {
	// TODO Auto-generated method stub

    }

    @Override
    protected void differentKeyBigFS(ArrayList<Integer> big) {
	// TODO Auto-generated method stub

    }

    @Override
    protected void fixedKeyBig(boolean saveBeforeDiscretization) {
	for (int i = 0; i < datasets.length; i++) { 
	    setFileName(datasets[i]);
	    int user=1;
	    while(user<=41){	
		setDataSetUser(user);
		//Big key

		setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Big/");
		tempDataSet=Utils.getAttributes(dataset, 0.75);	    
		try {
		    generate(user, saveBeforeDiscretization,"NoFS/BioHashing_Fixed_Big_");
		} catch (Exception e) {
		    e.printStackTrace();
		}	    
		user++;
	    }
	}

    }

    @Override
    protected void fixedKeyMedium(boolean saveBeforeDiscretization) {
	for (int i = 0; i < datasets.length; i++) { 
	    setFileName(datasets[i]);
	    int user=1;
	    while(user<=41){	
		setDataSetUser(user);
		//Medium key

		setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Medium/");	    
		tempDataSet=Utils.getAttributes(dataset, 0.5);
		try {
		    generate(user, saveBeforeDiscretization,"NoFS/BioHashing_Fixed_Med_");
		} catch (Exception e) {
		    e.printStackTrace();
		}	    
		user++;
	    }
	}

    }

    @Override
    protected void fixedKeySmall(boolean saveBeforeDiscretization) {
	for (int i = 0; i < datasets.length; i++) { 
	    setFileName(datasets[i]);
	    int user=1;
	    while(user<=41){	
		setDataSetUser(user);
		//Small key

		setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Small/");	  
		tempDataSet=Utils.getAttributes(dataset, 0.25);	    
		try {
		    generate(user, saveBeforeDiscretization,"NoFS/BioHashing_Fixed_Sml_");
		} catch (Exception e) {
		    e.printStackTrace();
		}	    
		user++;
	    }
	}
    }

    @Override
    protected void fixedKeyMediumFS(ArrayList<Integer> medium,
	    boolean saveBeforeDiscretization) {
	// TODO Auto-generated method stub

    }

    @Override
    protected void fixedKeyBigFS(ArrayList<Integer> big,
	    boolean saveBeforeDiscretization) {
	// TODO Auto-generated method stub

    }

    @Override
    protected void fixedKeySmallFS(ArrayList<Integer> small,
	    boolean saveBeforeDiscretization) {
	// TODO Auto-generated method stub

    }

    private void setDataSetUser(Integer user){
	try {
	    Instances dataUser=conector.openDataSet(Const.NORMANMETHOD +"/"+getOrientation()+"/Original/User_"+ 
		    user+"/"+ getFileName());
	    setDataset(dataUser);
	} catch (FileNotFoundException e) {
	    e.printStackTrace();
	}
    }

    @Override
    protected void fixedKeyStandard(boolean saveBeforeDiscretization){
	for (int i = 0; i < datasets.length; i++) {
	    setFileName(datasets[i]);
	    int user=1;
	    while(user<=41){			
		setDataSetUser(user);

		//Standard key
		setTempResults(Const.PROJECTPATH+"/"+getCancelableFunctionName()+"/"+getOrientation()+"/User_"+user+"/Fixed/Standard/");
		tempDataSet=getDataset();	    	    
		try {
		    generate(user, saveBeforeDiscretization,"BioHashing_Fixed_Std_");
		} catch (Exception e) {
		    e.printStackTrace();
		}	    
		user++;
	    }
	}
    }

    protected void generate(int user, boolean saveBeforeDiscretization, String prefixFileName) throws Exception{
	BioHashing bio=new BioHashing(tempDataSet);	
	//if here because to generate the keyArray just once
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
}
