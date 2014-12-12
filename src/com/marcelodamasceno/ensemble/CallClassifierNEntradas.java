package com.marcelodamasceno.ensemble;

import java.io.*;
import java.util.*;

import weka.core.*;
import weka.classifiers.AbstractClassifier;
import weka.classifiers.Classifier;

/*
Esse c�digo faz a combina��o dos arff e gera arff de treinamento e de teste que ser�o rodados com MLP e NB
Na sua sa�da tbm temos a m�dia e DP da soma, voto e peso, seus parametros s�o:

numero_de_folds, nome_arquivo_saida_teste.arff, nome_arquivo_saida_treinamento.arff, nome_arquivo_gravar_media_dp.txt,
qt_arquivos, algoritmo_AM_1 arquivo1.arff, algoritmo_AM_2 arquivo2.arff, algoritmo_AM_3 arquivo3.arff

na linha de comando digita-se:
java callClassifierNEntradas 10 saidaTeste.arff saidaTreinamento.arff media_dp.txt 3 weka.classifiers.trees.J48 -C 0.25 -M 2 -t ord1-base0-gau100s.arff weka.classifiers.trees.J48 -C 0.25 -M 2 -t ord1-base1-gau100s.arff weka.classifiers.trees.J48 -C 0.25 -M 2 -t ord1-base2-gau100s.arff

 */



public class CallClassifierNEntradas {

	/**
	 * Stores the accuracy of each classifier
	 */
	private static float medias[] = new float[12];

	/**
	 * Array of folds of datasets. nfold=10, 10 fold datasets are stored in this array
	 */
	private static Instances arffParaPesos [][];

	/**
	 * Number of classes
	 */
	private static int numClasses;

	static float dps[]={0,0,0,0,0,0,0,0,0,0,0,0};

	//metodo que faz o mesmo que o callClassifier...
	/**
	 * Method evaluates the classifier into dataset
	 * @param argv classifier and its arguments Ex:weka.classifiers.trees.J48, -C, 0.25, , -t, Interpolation_IntraSession-User_1_Day_1_Horizontal.arff, -x, 10
	 * @param nClassifier index of classifier
	 * @return matrix with decision of each instance. [,n] distibution of classe n. [,n+1] indice of test instance. [,n+2] true value of class. [n+3] 1, case classifier correct, 0, otherwise
	 * <p> 
	 * [1,0,1,0,0,1] means dist of classifier 1 to class 1 and 2 is 1 and 0. same thing for classifier 2.
	 * 0 is the index of test instance, 0 is the class index and 1 means that the ensemble got the right answer.
	 * 
	 */
	public static double [][] avaliar(String [] argv, int nClassifier) {
		//Store the decision of each instance
		double [][] saidas = null;
		int cont = 0;

		try {
			//Number of folds
			int numFolds=0;
			//Class Attribute index
			int cIdx=-1;
			//Seed option
			int seed=1;
			//stores how many time a classifier classified right per fold. Each index means a folder.
			float acertoporfold[]={0,0,0,0,0,0,0,0,0,0};
			float somaAcertos = 0;
			//stores the accuracy per fold in that classifier
			float mediaporfold[]={0,0,0,0,0,0,0,0,0,0};


			if (argv.length==0||Utils.getFlag('h',argv)) {
				throw new Exception("Usage: callClassifier [ClassifierName] -t [TrainFile] [-T [TestFile]] [-e delim] [-x numFolds] [-s randomSeed] [-c classIndex] ...\n       outputs probability distributions for test instances\n       If no test file is given, does a cross-validation on training data.\n       Format: InstanceID PredClass Confidence TrueClass [class probabilities]\n       (first four fields are similar to those in WEKA 3-3-5)\n       Field delimiter can be changed via -e (default: space)\n");
			}

			//Name of classifier
			String classifierName=argv[0];
			argv[0]="";

			String delim = Utils.getOption('e',argv);
			if (delim.length()==0) {
				delim=" ";
			}

			String trainFile = Utils.getOption('t',argv);
			if (trainFile.length()==0) throw new Exception("No train file given!");
			String testFile  = Utils.getOption('T',argv);

			String cv = Utils.getOption('x',argv);
			if (cv.length()!=0) {
				numFolds=Integer.parseInt(cv);
			} else {
				numFolds=10; // default
			}
			// stores in each line a array of datasets with nFolds components
			arffParaPesos[nClassifier] = new Instances [ numFolds ];

			String classIdx = Utils.getOption('c',argv);
			String seedS = Utils.getOption('s',argv);
			if (seedS.length()!=0) {
				seed=Integer.parseInt(seedS);
			}

			Classifier classifier = AbstractClassifier.forName(classifierName,argv);

			Instances trainData = new Instances(new FileReader(trainFile));
			Instances testData = null;

			if (classIdx.length()!=0) {
				cIdx=Integer.parseInt(classIdx)-1;
				if ((cIdx<0)||(cIdx>=trainData.numAttributes())) throw new Exception("Invalid value for class index!");
			} else {
				cIdx=trainData.numAttributes()-1;
			}

			if (testFile.length()!=0)
				testData  = new Instances(new FileReader(testFile));

			trainData.setClassIndex(cIdx);
			//Store the decision of each instance.			
			saidas = new double [ trainData.numInstances() ][ trainData.numClasses() + 3 ];
			numClasses = trainData.numClasses();

			if (testData==null) {
				if (numFolds<2||numFolds>trainData.numInstances()) {
					throw new Exception("Invalid number of cross-validation folds!");
				}

				// generate pseudo-dataset with instance ids, to get the same reordering..		
				ArrayList<Attribute> attInfo=new ArrayList<Attribute>();

				attInfo.add(new Attribute("Idx_20011004"));
				attInfo.add(trainData.classAttribute());

				//Indices dataset will store instance index and its respective class value
				Instances indices = new Instances("Indices",attInfo,trainData.numInstances());
				indices.setClass(attInfo.get(1));

				for (int k = 0; k < trainData.numInstances(); k++) {
					Instance inst = new DenseInstance(2);
					inst.setDataset(indices);
					inst.setClassValue(trainData.instance(k).classValue());
					inst.setValue(0,k);
					indices.add(inst);
				}

				//Random random = new Random(seed);
				//random.setSeed(seed);
				//   indices.randomize(random);

				//random = new Random(seed);
				//random.setSeed(seed);
				//    trainData.randomize(random);

				//stratify the training dataset in numFolds
				if (trainData.classAttribute().isNominal()) {
					trainData.stratify(numFolds);
					indices.stratify(numFolds);
				}

				for (int i=0; i<numFolds; i++) {
					//imprime o n�mero do fold
					//System.out.print("\n Fold " + i + "\n\n");
					acertoporfold[i]=0;
					mediaporfold[i]=0;
					Instances train = trainData.trainCV(numFolds,i);

					arffParaPesos[nClassifier][i] = new Instances( train );

					classifier.buildClassifier(train);

					//TestData for this i fold
					testData = trainData.testCV(numFolds,i);
					Instances testIndices = indices.testCV(numFolds,i);
					for (int j=0; j<testData.numInstances(); j++) {
						Instance testInstance = testData.instance(j);
						//Instance withMissing = (Instance)instance.copy();
						//withMissing.setDataset(testData);
						double predValue=((Classifier)classifier).classifyInstance(testInstance);
						//index of testInstance
						int idx=(int)testIndices.instance(j).value(0);
						double trueValue=testIndices.instance(j).value(1);

						if (testData.classAttribute().isNumeric()) {
							if (Utils.isMissingValue(predValue)) {
								System.out.print(idx + delim + "missing" + delim);
							} else {
								System.out.print(idx + delim + predValue + delim);
							}						
							if (testInstance.classIsMissing()) {
								System.out.print("missing");
							} else {
								System.out.print(testInstance.classValue());								
								if (testInstance.classValue()== predValue)
									System.out.print(delim + " 1 " + delim);
								else
									System.out.print(delim + " 0 " + delim);
							}
							System.out.print("\n");
						} else {
							double[] dist=classifier.distributionForInstance(testInstance);
							int k;
							for (k=0; k<dist.length; k++){
								//trunca o valor e divide por 100 para ficar com apenas 2 casas decimais
								Double distTruncado = Math.round(dist[k]*1000)/1000d;
								System.out.print( distTruncado + delim);
								//saidas[,k]=distribution class k
								saidas[ cont ][ k ] = dist[k];
								//System.out.print(dist[k] + delim);
							}
							System.out.print( idx + delim );
							//saidas[,nClasses+1]=indice of test instance in test dataset
							saidas[ cont ][ k++ ] = idx;

							//This try is required because testDataValue can be a nominal value different of a number. Ex: positive,negative
							try{
								//saidas[,nClases+2]= true value of class
								saidas[ cont ][ k+1 ] = Double.parseDouble( testData.classAttribute().value((int)trueValue) );
								k++;
							}catch (Exception e) {
								saidas[ cont ][ k++ ] =trueValue;
							}
							if( testData.classAttribute().value((int)trueValue) == testData.classAttribute().value((int)predValue) )
								//saidas[,nClasses+3]=this position receives 1 case classifier answers right, 0, otherwise
								saidas[ cont ][ k++ ] = 1;
							else
								saidas[ cont ][ k++ ] = 0;
							cont++;

							/* Note: the order of class probabilities corresponds
               to the order of class values in the training file */


							//imprime o numero da classe correta
							System.out.print(testData.classAttribute().value((int)trueValue) + delim);

							//imprime 0 para erros e 1 para acertos
							if (testData.classAttribute().value((int)trueValue)== testData.classAttribute().value((int)predValue))
							{	
								System.out.print("1");
								acertoporfold[i]++;
							}
							else
								System.out.print("0");
							System.out.print("\n");
						}
					}
					float acertos =  ((acertoporfold[i]/testData.numInstances())); 
					mediaporfold[i] = acertos;
					somaAcertos = somaAcertos + acertos;

					//imprime a madia de acertos em cada fold
					//System.out.print("\n Neste fold, o acerto foi de: " + acertoporfold[i] + " totalizando " + acertos + delim); 
				}

				//stores the accuracy of classifier in all folds
				float media_individual = somaAcertos/numFolds;

				//Calculates the variance of the classifier in nFold cross validation
				float soma_variancia = 0;

				for (int j=0; j<mediaporfold.length; j++){
					float variancia = (float)((double) (mediaporfold[j]-media_individual)*(double)(mediaporfold[j]-media_individual)); 
					//	System.out.println("variancia por fold, fold " + j + ": "  + variancia);
					soma_variancia = soma_variancia + variancia;	
				}	 
				float x = 1;
				//System.out.println("soma_variancia: " + soma_variancia);
				soma_variancia = (soma_variancia*(x/(numFolds-1)));

				//Standard desviation
				double desvio_padrao = Math.sqrt((double) soma_variancia);

				setmedias(media_individual, nClassifier);
				setdps((float)desvio_padrao,nClassifier);

				System.out.print("\n media individual: " + (media_individual*100) + " desvio padrao: " + (float)(desvio_padrao*100) + delim + "\n");

			} else {
				testData.setClassIndex(cIdx);
				classifier.buildClassifier(trainData);

				for (int i=0; i<testData.numInstances(); i++) {
					Instance instance = testData.instance(i);
					Instance withMissing = (Instance)instance.copy();
					withMissing.setDataset(testData);
					double predValue=((Classifier)classifier).classifyInstance(instance);
					int idx=i;
					double trueValue=instance.classValue();

					if (testData.classAttribute().isNumeric()) {
						if (Utils.isMissingValue(predValue)) {
							System.out.print(idx + delim + "missing" + delim);
						} else {
							System.out.print(idx + delim + predValue + delim);
						}
						if (instance.classIsMissing()) {
							System.out.print("missing");
						} else {
							System.out.print(instance.classValue());
						}
						System.out.print("\n");
					} else {
						if (Utils.isMissingValue(predValue)) {
							System.out.print(idx + delim + "missing" + delim);
						} else {
							System.out.print(idx + delim
									+ testData.classAttribute().value((int)predValue) + delim);
						}
						if (Utils.isMissingValue(predValue)) {
							System.out.print("missing" + delim);
						} else {
							System.out.print(classifier.
									distributionForInstance(withMissing)[(int)predValue]+delim);
						}
						System.out.print(testData.classAttribute().value((int)trueValue));
						double[] dist=(classifier.distributionForInstance(instance));
						for (int k=0; k<dist.length; k++)
							System.out.print(delim+dist[k]);
						/* Note: the order of class probabilities corresponds
               to the order of class values in the training file */
						System.out.print("\n");
					}
				}
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return saidas;
	}

	public static double [][] avaliarPeso(String [] argv, Instances baseInstancias ) {
		double [][] saidas = null;
		int cont = 0;

		try {
			int numFolds=0;
			int cIdx=-1;
			int seed=1;
			float acertoporfold[]={0,0,0,0,0,0,0,0,0,0};
			//	float somaAcertos = 0;
			float mediaporfold[]={0,0,0,0,0,0,0,0,0,0};


			if (argv.length==0||Utils.getFlag('h',argv)) {
				throw new Exception("Usage: callClassifier [ClassifierName] -t [TrainFile] [-T [TestFile]] [-e delim] [-x numFolds] [-s randomSeed] [-c classIndex] ...\n       outputs probability distributions for test instances\n       If no test file is given, does a cross-validation on training data.\n       Format: InstanceID PredClass Confidence TrueClass [class probabilities]\n       (first four fields are similar to those in WEKA 3-3-5)\n       Field delimiter can be changed via -e (default: space)\n");
			}
			String classifierName=argv[0];
			argv[0]="";

			String delim = Utils.getOption('e',argv);
			if (delim.length()==0) {
				delim=" ";
			}

			String testFile  = Utils.getOption('T',argv);

			String cv = Utils.getOption('x',argv);
			if (cv.length()!=0) {
				numFolds=Integer.parseInt(cv);
			} else {
				numFolds=10; // default
			}

			String classIdx = Utils.getOption('c',argv);
			String seedS = Utils.getOption('s',argv);
			if (seedS.length()!=0) {
				seed=Integer.parseInt(seedS);
			}

			Classifier c = AbstractClassifier.forName(classifierName,argv);

			Instances trainData = baseInstancias;
			Instances testData = null;

			if (classIdx.length()!=0) {
				cIdx=Integer.parseInt(classIdx)-1;
				if ((cIdx<0)||(cIdx>=trainData.numAttributes())) throw new Exception("Invalid value for class index!");
			} else {
				cIdx=trainData.numAttributes()-1;
			}

			if (testFile.length()!=0)
				testData  = new Instances(new FileReader(testFile));

			trainData.setClassIndex(cIdx);

			saidas = new double [ trainData.numInstances() ][ trainData.numClasses() + 3 ];

			if (testData==null) {
				if (numFolds<2||numFolds>trainData.numInstances()) {
					throw new Exception("Invalid number of cross-validation folds!");
				}

				// generate pseudo-dataset with instance ids, to get the same reordering..
				//FastVector attInfo = new FastVector(2);

				ArrayList<Attribute> attInfo=new ArrayList<Attribute>();

				//attInfo.addElement(new Attribute("Idx_20011004"));
				attInfo.add(new Attribute("Idx_20011004"));

				//attInfo.addElement(trainData.classAttribute());
				attInfo.add(trainData.classAttribute());

				Instances indices = new Instances("Indices",attInfo,trainData.numInstances());
				//indices.setClass((Attribute)attInfo.elementAt(1));
				indices.setClass((Attribute)attInfo.get(1));

				for (int k = 0; k < trainData.numInstances(); k++) {
					Instance inst = new DenseInstance(2);
					inst.setDataset(indices);
					inst.setClassValue(trainData.instance(k).classValue());
					inst.setValue(0,k);
					indices.add(inst);
				}

				Random random = new Random(seed);
				random.setSeed(seed);
				//   indices.randomize(random);

				random = new Random(seed);
				random.setSeed(seed);
				//    trainData.randomize(random);

				if (trainData.classAttribute().isNominal()) {
					trainData.stratify(numFolds);
					indices.stratify(numFolds);
				}

				for (int i=0; i<numFolds; i++) {
					//imprime o n�mero do fold
					//System.out.print("\n Fold " + i + "\n\n");
					acertoporfold[i]=0;
					mediaporfold[i]=0;
					Instances train = trainData.trainCV(numFolds,i);
					c.buildClassifier(train);
					testData = trainData.testCV(numFolds,i);
					Instances indicesTest = indices.testCV(numFolds,i);
					for (int j=0; j<testData.numInstances(); j++) {
						Instance instance = testData.instance(j);
						Instance withMissing = (Instance)instance.copy();
						withMissing.setDataset(testData);
						double predValue=((Classifier)c).classifyInstance(instance);
						int idx=(int)indicesTest.instance(j).value(0);
						double trueValue=indicesTest.instance(j).value(1);

						double[] dist=c.distributionForInstance(instance);
						int k;
						for (k=0; k<dist.length; k++){
							//Double distTruncado = Math.round(dist[k]*1000)/1000d;
							saidas[ cont ][ k ] = dist[k];
						}
						saidas[ cont ][ k++ ] = idx;						
						try{
							saidas[ cont ][ k+1 ]=Double.parseDouble( testData.classAttribute().value((int)trueValue) );
							k++;
						}catch (Exception e) {
							saidas[ cont ][ k++ ] = trueValue;							
						}						 
						if( testData.classAttribute().value((int)trueValue) == testData.classAttribute().value((int)predValue) )
							saidas[ cont ][ k++ ] = 1;
						else
							saidas[ cont ][ k++ ] = 0;
						cont++;
					}

				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return saidas;
	}

	/**
	 * Calculates the standard deviation of ensemble score
	 * @param mediaEnsemble average of the ensemble in all folds
	 * @param mediasEnsemble average of the ensemble in each fold
	 * @param folds number of folds
	 * @return
	 */
	private static double calcularDpEnsemble ( double mediaEnsemble, double [] mediasEnsemble, int folds ){
		float soma_variancia = 0;

		for (int j=0; j<mediasEnsemble.length; j++){
			float variancia = (float)((double) (mediasEnsemble[j]-mediaEnsemble)*(double)(mediasEnsemble[j]-mediaEnsemble)); 
			soma_variancia = soma_variancia + variancia;	
		}	 
		float x = 1;
		soma_variancia = (soma_variancia*(x/(folds-1)));
		double desvio_padrao = Math.sqrt((double) soma_variancia);
		return desvio_padrao;
	}

	/**
	 * Calculates the average of decision for each data fold
	 * @param soma values from sum rule
	 * @param folds number of folds
	 * @return a array with the average decision score of each fold
	 */
	private static double [] calcularMediasEnsemble ( double [][] soma, int folds ){
		double mediaPorFoldEnsemble [] = new double [ folds ];
		int k;
		int instanceIndex = 0;
		int elementosPorFold;
		for(int i=0;i<folds;i++){
			elementosPorFold = obterElementosPorFold ( i, soma.length, folds );
			mediaPorFoldEnsemble[i] = 0;

			for(k=0;k<elementosPorFold;k++){
				//add to mediaPorFoldEnsemble the result of decision of ensemble. 1=Right; 0=Wrong
				mediaPorFoldEnsemble[i] += soma[instanceIndex][ soma[0].length -1 ];
				instanceIndex++;
			}
			mediaPorFoldEnsemble[i] /= elementosPorFold;
		}
		return mediaPorFoldEnsemble;
	}

	//retorna apenas um vetor com o valor do peso
	private static double [] calcularPesos ( Instances base, int folds, String saida, String argumento ){
		double acertosClasse [] = new double [ base.numClasses() ];
		int quantidadePorClasse [] = new int [ base.numClasses() ];
		int i;
		for(i=0;i<acertosClasse.length;i++){
			acertosClasse[i] = 0;
			quantidadePorClasse[i] = 0;
		}
		double [][] resultado = avaliarPeso( (argumento + " -x " + folds).split(" "), base );

		//int j;
		for(i=0;i<resultado.length;i++){
			if( resultado[i][ resultado[i].length -1 ] == 1 )
				acertosClasse[ (int)resultado[i][ resultado[i].length -2 ] ] += 1;
			quantidadePorClasse[ (int)resultado[i][ resultado[i].length -2 ] ]++;
		}

		for(i=0;i<acertosClasse.length;i++)
			acertosClasse[i] /= quantidadePorClasse[i];
		return acertosClasse; // retorna o valor do peso
	}

	public static void gerarMLP_NB( int foldCorrente, Instances fold [], int folds, String saida, String classificador [] ){
		String nomeSaida = "";
		/*for(int i=0;i<saida.length;i++){
			nomeSaida += saida[i].substring(0,saida[i].indexOf('.')) + "_";
		}
		nomeSaida += foldCorrente + ".arff";
		 */
		nomeSaida = saida.substring(0,saida.indexOf('.')) + "_" + foldCorrente + ".arff";
		double [][][] resultado = new double [ fold.length ][][];
		for(int i=0;i<resultado.length;i++){
			resultado[i] = avaliarPeso( (classificador[i] + " -x " + folds).split(" "), fold[i] );
		}

		String folder=saida.substring(0,saida.indexOf('.'));
		nomeSaida = folder+"/"+nomeSaida;
		imprimirArquivoSaida( nomeSaida, resultado, fold.length );

	}

	public static float getdps(int pos){
		return dps[pos];
	}

	public static float getmedias(int pos){
		return medias[pos];
	}

	public static int getNumClasses (){
		return numClasses;
	}

	private static void writeFile(String fileName,String header,Object content) throws IOException{		
		PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(fileName, true)));
		out.print(header+"\n");
		out.print(content+"\n");
		out.flush();
		out.close();
	}
	/**
	 * Method to crete a arff file which contains the result of the cross validation test
	 * @param fileName File Name
	 * @param results Results of the classification (Distribution of each class given by each classifier)
	 * @param numberOfClassifiers Number of classifiers used
	 */
	private static void imprimirArquivoSaida ( String fileName, double [][][] results, int numberOfClassifiers ){
		try {
			int i;
			Formatter forma = null;
			String folder=fileName.substring(0,fileName.indexOf('/'));
			File f = new File(folder);
			PrintWriter out;
			if(f.exists())
				 out = new PrintWriter( fileName );
			else{				
				f.mkdir();
				out = new PrintWriter( fileName );
			}		

			int k = 0;
			out.print( "@relation " + fileName + "\n" );
			for(i=0;i<numberOfClassifiers;i++)
				for(k=0;k<results[0][0].length-3;k++)
					out.print( "@attribute att_" + i + "_" + k + " real\n" );

			// substitui essa linha pelo c�digo abaixo.
			//out.print( "@attribute class { 0, 1, 2}\n" );

			out.print( "@attribute class { ");
			for (int x = 0; x <= numClasses-1; x++){
				if (x == 0)
					out.print(x);
				else
					out.print( "," + x);
			}
			out.print(" }\n" );
			//at� aqui

			out.print( "@data\n" );

			for(i=0;i<results[0].length;i++){//linha
				forma = new Formatter();
				for(int j=0;j<numberOfClassifiers;j++){ //indice 
					for(k=0;k<results[0][0].length -3;k++) //coluna da matriz
						forma.format( "%4.3f ", results[j][i][k] );
				}
				forma.format( "%d", (int) results[0][i][k+1] );
				out.print( forma.toString().replaceAll( ",", "." ).replaceAll( " ", "," ) + "\n" );

			}
			out.close();
		} catch ( IOException e ){
			e.printStackTrace();
		}
	}

	private static String imprimirMediaEDp( int quantidade, double mediaEnsemble, double dpEnsemble, double mediaEnsembleVoto, double dpEnsembleVoto ){
		float somaMedia =0;
		float somaDp=0;
		for(int pos=0;pos<quantidade;pos++){
			somaMedia += getmedias(pos);
			somaDp += getdps(pos);
		}
		//System.out.println("media: "+(somaMedia/quantidade) + " desvio padrao " + (somaDp/quantidade));
		return "media_individual: " + ((somaMedia/quantidade)*100) + " desvio_padr�o_individual: " + ((somaDp/quantidade)*100)
				+ " media_ensemble_soma: " + (mediaEnsemble*100) + " dp_ensemble_soma: " + (dpEnsemble*100)
				+ " media_ensemble_voto: " + (mediaEnsembleVoto*100) + " dp_ensemble_voto: " + (dpEnsembleVoto*100);

	}

	/**
	 * Method calculates False Aceptance Rate (FAR)
	 * @param resultado array with the decision of ensemble [c0,...,cn,true class,ensemble decision]
	 * @return False Aceptance Rate (FAR)
	 * @throws Exception
	 */
	private static double calculateFAR(double[][]resultado) throws Exception{
		double far=-1;
		double numberImpostors=0;
		double numberofFalseAceptance=0;
		int pos=resultado[0].length-2;
		for(int instance=0;instance<resultado.length-1;instance++){			
			if(resultado[instance][pos]==0){
				numberImpostors++;
				if(resultado[instance][pos+1]==0)
					numberofFalseAceptance++;
			}
		}
		if(numberImpostors>0)
			far=numberofFalseAceptance/numberImpostors;
		else
			throw new Exception("Doesn't exist Impostors");
		return far;
	}

	/**
	 * Method calculates False Rejection Rate (FRR)
	 * @param resultado array with the decision of ensemble [c0,...,cn,true class,ensemble decision]
	 * @return False Rejection Rate (FRR)
	 * @throws Exception
	 */
	private static double calculateFRR(double[][]resultado) throws Exception{
		double frr=-1;
		double numberClients=0;
		double numberofFalseRejection=0;
		int pos=resultado[0].length-2;
		for(int instance=0;instance<resultado.length-1;instance++){			
			if(resultado[instance][pos]==1){
				numberClients++;
				if(resultado[instance][pos+1]==0)
					numberofFalseRejection++;
			}
		}
		if(numberClients>0)
			frr=numberofFalseRejection/numberClients;
		else
			throw new Exception("Doesn't exist clients");
		return frr;		
	}

	/**
	 * Method calculates Equal Error Rate (EER)
	 * @param resultado array with the decision of ensemble [c0,...,cn,true class,ensemble decision]
	 * @return Equal Error Rate (EER)
	 * @throws Exception
	 */
	private static double calculateEER(double[][] resultado) throws Exception{
		double far;
		double frr;

		far = calculateFAR(resultado);
		frr= calculateFRR(resultado);		
		return (far+frr)/2;
	}

	public static void main (String[] args) {
		// -c <int> class arq 
		// -o output

		//Examle: "10 3ADtest.arff 3ADvali.arff 3ADmedia.txt 2 weka.classifiers.trees.J48 -C 0.25  
		//-t Interpolation_IntraSession-User_1_Day_1_Horizontal.arff weka.classifiers.trees.J48 -U -M 5 -t 
		//DoubleSum_IntraSession-User_1_Day_1_Horizontal.arff"

		int folds;
		//Number of classifiers passed in args
		int nClassifiers;

		String classificadores [];
		String entradas [];
		String saida;
		String saidaTreinamento;
		String mediaDp;



		int i = 0;
		//folds=10
		folds = Integer.parseInt( args[i++] );
		//saida=3ADtest.arff
		saida = args[i++];
		//saidaTreinamento=3ADvali.arff
		saidaTreinamento = args[i++];
		//mediaDp=3ADmedia.txt
		mediaDp = args[i++];
		//quantidade=2
		nClassifiers = Integer.parseInt( args[i++] );

		int classificadorAtual = 0;
		classificadores = new String[ nClassifiers ];
		entradas = new String[ nClassifiers ];
		classificadores[0] = "";

		//fill the classificadores e entradas arrays with classifiers and input dataset
		for(;i<args.length;i++){
			if( args[i].equals( "-t" ) ){
				i++;
				entradas[ classificadorAtual ] = args[i];
				classificadorAtual++;
				if( classificadorAtual < classificadores.length )
					classificadores[ classificadorAtual ] = "";
			} else
				classificadores[ classificadorAtual ] += args[i] + " ";
		}
		//resultado receives for each classifier, the results of distribution, instanceIndex, classIndex and if the classifier predicted right the instance
		double resultado [][][] = new double [nClassifiers][][];

		//Array where each line stores the 10 fold datasets for each classifier
		arffParaPesos = new Instances[ nClassifiers ][];

		//Stores in each row of resultado the evaluation of each classifier in its dataset using x folds
		for(i=0;i<nClassifiers;i++)
			resultado[i] = avaliar( (classificadores[i] + " -t " + entradas[i] + " -x " + folds).split(" "), i );

		//separa os resultados em diversos arquivos q serao usados como teste para MLP E NB
		//int foldCorrente = 0;
		int linhaCorrente = 0;
		int ultimaLinha = 0;
		for (int qtFolds=0;qtFolds<folds;qtFolds++){
			int elementosFold = obterElementosPorFold(qtFolds, resultado[0].length, folds);
			//arffTeste receives the same information of resultado object. The results of each instance in each classifier.
			double arffTeste [][][] = new double [nClassifiers][elementosFold][resultado[0][0].length];		
			for (int indice=0;indice<nClassifiers;indice++){
				for (int linha=0;linha<elementosFold;linha++){
					for (int coluna=0;coluna<resultado[0][0].length;coluna++){
						double t =resultado[indice][linhaCorrente][coluna];
						arffTeste[indice][linha][coluna]=t;
					}
					linhaCorrente++;
				}
				linhaCorrente = ultimaLinha;
			}
			ultimaLinha += elementosFold;
			
			String folder=saida.substring(0,saida.indexOf('.'));
			String nomeArquivo = folder+"/"+saida.substring(0,saida.indexOf('.')) + "_" + qtFolds + ".arff";
			imprimirArquivoSaida(nomeArquivo, arffTeste, nClassifiers);
			linhaCorrente = ultimaLinha;
			//Cleaning arffTeste. Seting all the values of this object to 0;
			for(int ind=0;ind<nClassifiers;ind++){
				for (int lin=0;lin<=arffTeste[0].length-1;lin++){
					for (int col=0;col<=arffTeste[0][0].length-1;col++){
						arffTeste[ind][lin][col] = 0;
					}
				}

			}

		}
		//imprime um arquivo com todas as instancias de teste juntas 
		//imprimirArquivoSaida ( saida, resultado, quantidade );


		// aplicacao da soma
		//soma[,cn]=sum of decisoon distribution of classifier cn
		//soma[,n-1]=class value
		//soma[,n]=1, if classifier is right; 0, otherwise.
		double soma [][] = somar( resultado, nClassifiers );

		//apenas imprime na tela a soma
		System.out.print("SOMA: ");
		System.out.println();
		for (i=0;i<soma.length;i++){
			for (int j=0;j<soma[0].length;j++){
				System.out.print(soma[i][j] + " ");
			}
			System.out.println();
		}


		double mediasEnsemble [] = calcularMediasEnsemble( soma, folds );
		double mediaEnsemble = 0;
		for(i=0;i<folds;i++){
			mediaEnsemble += mediasEnsemble[ i ];
		}
		mediaEnsemble /= folds;
		double dpEnsemble = calcularDpEnsemble( mediaEnsemble, mediasEnsemble, folds );


		// aplicacao do voto
		double voto [][] = somar( obterResultadoVoto( resultado ), nClassifiers );
		double mediasEnsembleVoto [] = calcularMediasEnsemble( voto, folds );
		double mediaEnsembleVoto = 0;
		for(i=0;i<folds;i++){
			mediaEnsembleVoto += mediasEnsembleVoto[ i ];
		}
		mediaEnsembleVoto /= folds;
		double dpEnsembleVoto = calcularDpEnsemble( mediaEnsembleVoto, mediasEnsembleVoto, folds );

		try {
			double eer=calculateEER(voto);			
			System.out.println("EER: "+eer);
			String header="";
			String fileName="";
			for (String classifierName : classificadores) {
				fileName+=classifierName+"|-|-|";
			}
			fileName+=saida.subSequence(0, nClassifiers*4);
			header+=saida.subSequence(0, saida.length()-9);
			writeFile("EER|-|-|"+fileName, header, eer);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		//apenas imprime na tela a soma do voto
		System.out.print("VOTO: ");
		System.out.println();
		for (i=0;i<voto.length;i++){
			for (int j=0;j<voto[0].length;j++){
				System.out.print(voto[i][j] + " ");
			}
			System.out.println();
		}
		System.out.println("m�dia ensemble voto: " + mediaEnsembleVoto + " dp ensemble voto: " + dpEnsembleVoto);

		String resultadoSomaEVoto = imprimirMediaEDp( nClassifiers, mediaEnsemble, dpEnsemble, mediaEnsembleVoto, dpEnsembleVoto );

		double [][][] pesos = new double[ nClassifiers ][ folds ][ getNumClasses() ];
		int j;//, k;
		for(i=0;i<nClassifiers;i++)
			for(j=0;j<folds;j++)
				pesos[i][j] = calcularPesos ( arffParaPesos[i][j], 4, "teste.txt" ,classificadores[i] );

		//double resultadoPeso [][][] = obterResultadoPeso( pesos, resultado, folds );
		//double peso [][] = somar( resultadoPeso, quantidade );

		//apenas imprime na tela os pesos e o vetor resultado
		System.out.print("PESOS: ");
		System.out.println();
		for (i=0;i<pesos.length;i++){
			for (int x=0;x<pesos[0].length;x++){
				for (int h=0;h<pesos[0][0].length;h++)
					System.out.print(pesos[i][x][h] + " ");
				System.out.println();
			}
		}

		System.out.print("RESULTADO: ");
		System.out.println();
		for (i=0;i<resultado.length;i++){
			for (int x=0;x<resultado[0].length;x++){
				for (int h=0;h<resultado[0][0].length;h++)
					System.out.print(resultado[i][x][h] + " ");
				System.out.println();
			}
		}


		double peso [][] = somar( obterResultadoPeso( resultado, pesos, folds ), nClassifiers );
		double mediasEnsemblePeso [] = calcularMediasEnsemble( peso, folds );
		double mediaEnsemblePeso = 0;
		for(i=0;i<folds;i++){
			mediaEnsemblePeso += mediasEnsemblePeso[ i ];
		}
		mediaEnsemblePeso /= folds;
		double dpEnsemblePeso = calcularDpEnsemble( mediaEnsemblePeso, mediasEnsemblePeso, folds );

		//apenas imprime na tela a soma do peso
		System.out.print("PESO: ");
		System.out.println();
		for (i=0;i<peso.length;i++){
			for (int x=0;x<peso[0].length;x++){
				System.out.print(peso[i][x] + " ");
			}
			System.out.println();
		}
		System.out.println("m�dia ensemble peso: " + mediaEnsemblePeso + " dp ensemble peso: " + dpEnsemblePeso);


		resultadoSomaEVoto += " media_ensemble_peso: " + (mediaEnsemblePeso*100) + " dp_ensemble_peso: " + (dpEnsemblePeso*100);

		try {
			PrintStream out = new PrintStream( mediaDp );
			out.print( resultadoSomaEVoto );
			out.close();
		}catch( IOException e ){
			e.printStackTrace();
		}

		Instances foldArquivo [] = new Instances[ nClassifiers ];
		for(i=0;i<arffParaPesos[0].length;i++){
			for(j=0;j<nClassifiers;j++)
				foldArquivo[j] = arffParaPesos[j][i];
			//gerarMLP_NB( i, foldArquivo, folds, entradas, classificadores );
			gerarMLP_NB( i, foldArquivo, folds, saidaTreinamento, classificadores );
		}
	}

	/**
	 * Calculates the quantity of instances in a fold
	 * @param fold index of fold
	 * @param quantidadeElementos number of instances present in the dataset
	 * @param quantidadeFolds number of folds
	 * @return the number of instances in a fold
	 */
	public static int obterElementosPorFold ( int fold, int quantidadeElementos, int quantidadeFolds ){
		int instanciaPorFold = quantidadeElementos / quantidadeFolds;
		int foldInteiro = (int) Math.floor(instanciaPorFold);
		int acrescentar = quantidadeElementos % quantidadeFolds;

		int elementosPorFold = foldInteiro + 1;
		if( fold >= acrescentar ){
			elementosPorFold = foldInteiro--;
		}
		return elementosPorFold;
	}

	//retorna a multiplicacao das sa�das pelo peso
	public static double [][][] obterResultadoPeso( double [][][] resultado, double [][][] pesos, int folds ){

		int coluna, cont, elementosPorFold, foldCorrente;
		double resultadoPeso [][][] = new double [ resultado.length ][ resultado[0].length ][ resultado[0][0].length ];
		for (int indice=0;indice<resultado.length;indice++){
			foldCorrente =0;
			cont = 0;
			elementosPorFold = obterElementosPorFold ( foldCorrente, resultado[0].length, folds );
			for (int linha=0;linha<resultado[0].length;linha++){
				for (coluna=0;coluna<resultado[0][0].length-3;coluna++){
					resultadoPeso[indice][linha][coluna] = resultado[indice][linha][coluna] * pesos[indice][foldCorrente][coluna];
				}
				for(coluna=resultado[0][0].length -3;coluna<resultado[0][0].length;coluna++){
					resultadoPeso[indice][linha][coluna] = resultado[indice][linha][coluna];
				}				
				cont++;
				if (cont >= elementosPorFold){
					cont = 0;
					foldCorrente++;
					elementosPorFold = obterElementosPorFold(foldCorrente, resultado[0].length, folds);
				}
			}
		}
		/*		for(i=0;i<resultado.length;i++){//indice
			cont = 0;
			foldCorrente = 0;
			elementosPorFold = obterElementosPorFold ( foldCorrente, resultado[0].length, folds );
			for(j=0;j<resultado[0].length;j++){//linha
				for(k=0;k<resultado[0][0].length -3;k++){//coluna
					resultadoPeso[i][j][k] = resultado[i][j][k] * pesos[i][j][ cont ];
				}
				for(k=resultado[0][0].length -3;k<resultado[0][0].length;k++){
					resultadoPeso[i][j][k] = resultado[i][j][k];
				}
				cont++;
				if( cont >= elementosPorFold ){
					cont = 0;
					foldCorrente++;
					elementosPorFold = obterElementosPorFold ( foldCorrente, resultado[0].length, folds );
				}
			}
		}
		 */	return resultadoPeso;
	}

	//apenas transforma os aquivos em 0 e 1
	/**
	 * Method returns a array with 1 in na class index which ensemble decided that is the class using majority vote
	 * @param resultados Array index with distribuiton value for each class + test index+true class+ predicted class
	 * @return a array with 1 in na class index which ensemble decided that is the class using majority vote
	 */
	private static double [][][] obterResultadoVoto ( double [][][] resultados ){
		int classi, instance, stat, maior;
		//votos array receives 1 in the class which the ensemble decided by majority vote
		double votos [][][] = new double [ resultados.length ][ resultados[0].length ][ resultados[0][0].length ]; 
		for(classi=0;classi<resultados.length;classi++){
			for(instance=0;instance<resultados[classi].length;instance++){
				maior = 0;
				for(stat=1;stat<resultados[classi][instance].length -3;stat++){
					if( resultados[classi][instance][maior] < resultados[classi][instance][stat] ) // valor mais a esquerda em caso empate
						maior = stat;
					votos[classi][instance][stat] = 0;
				}
				votos[classi][instance][maior] = 1;
				//Copying the remaining part (n-3,n-2,n-1) of resultados array
				for(stat=resultados[classi][instance].length -3;stat<resultados[classi][instance].length;stat++)
					votos[classi][instance][stat] = resultados[classi][instance][stat];
			}
		}
		return votos;
	}

	public static void setdps(float dp, int pos){
		dps[pos] = dp;
	}
	public static void setmedias(float media, int pos){
		medias[pos] = media;
	}

	/**
	 * Use the sum rule
	 * @param resultado distribution values resultado[0].length=quantity of instances
	 * resultado[0][0].length -1=number of statistics
	 * @param numberOfClassifiers Number of classifiers
	 * @return sum of distribution class for each class 
	 * 
	 * soma[n]=sum of score of classifier in class n
	 * soma[n-2]=class index
	 * soma[n]=1, if the ensemble made the right decision,0, otherwise
	 */	
	private static double [][] somar( double resultado[][][], int numberOfClassifiers ){		

		double [][] soma = new double [resultado[0].length][resultado[0][0].length -1];
		float max = -1;
		float empate = -1;
		int posMax = -1;
		int valorClasse = -1;
		//Column of classe
		int colClasse = -1;
		double result = 0;
		float somaLinha = 0;
		int k = 0;
		int i;

		for(i=0;i<resultado[0].length;i++){//linha
			colClasse = resultado[0][0].length -2;
			valorClasse = (int) resultado[0][i][colClasse];
			for(k=0;k<resultado[0][0].length -3;k++){ //coluna da matriz
				for(int j=0;j<numberOfClassifiers;j++){ //indice 
					result = resultado[j][i][k];
					somaLinha += result;
				}
				if (somaLinha > max){
					max = somaLinha;
					posMax = k; 
				}else if (somaLinha == max){
					empate = max;
				}


				soma[i][k] = somaLinha;
				somaLinha = 0;

			}
			soma[i][k++] = valorClasse;

			if (empate == max){
				posMax = 0;
			}
			if (posMax == valorClasse){
				soma[i][k++] = 1;
			}else{
				soma[i][k++] = 0;
			}
			max = -1;
		}
		return soma;
	}
}
