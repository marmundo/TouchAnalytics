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

	//m�todo que faz o mesmo que o callClassifier...
	public static double [][] avaliar(String [] argv, int base) {
		double [][] saidas = null;
		int cont = 0;

		try {
			int numFolds=0;
			int cIdx=-1;
			int seed=1;
			float acertoporfold[]={0,0,0,0,0,0,0,0,0,0};
			float somaAcertos = 0;
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

			String trainFile = Utils.getOption('t',argv);
			if (trainFile.length()==0) throw new Exception("No train file given!");
			String testFile  = Utils.getOption('T',argv);

			String cv = Utils.getOption('x',argv);
			if (cv.length()!=0) {
				numFolds=Integer.parseInt(cv);
			} else {
				numFolds=10; // default
			}
			// cria bases de cada fold
			arffParaPesos[base] = new Instances [ numFolds ];

			String classIdx = Utils.getOption('c',argv);
			String seedS = Utils.getOption('s',argv);
			if (seedS.length()!=0) {
				seed=Integer.parseInt(seedS);
			}

			Classifier c = AbstractClassifier.forName(classifierName,argv);

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

			saidas = new double [ trainData.numInstances() ][ trainData.numClasses() + 3 ];
			numClasses = trainData.numClasses();

			if (testData==null) {
				if (numFolds<2||numFolds>trainData.numInstances()) {
					throw new Exception("Invalid number of cross-validation folds!");
				}

				// generate pseudo-dataset with instance ids, to get the same reordering..
				//FastVector attInfo = new FastVector(2);
				ArrayList<Attribute> attInfo=new ArrayList<Attribute>();
				
				//attInfo.addElement(new Attribute("Idx_20011004"));
				attInfo.add(new Attribute("Idx_20011004"));
				
//				attInfo.addElement(trainData.classAttribute());
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

					arffParaPesos[base][i] = new Instances( train );

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

						if (testData.classAttribute().isNumeric()) {
							if (Utils.isMissingValue(predValue)) {
								System.out.print(idx + delim + "missing" + delim);
							} else {
								System.out.print(idx + delim + predValue + delim);
							}
							//System.out.print(" AQUI 1!!!!");
							if (instance.classIsMissing()) {
								System.out.print("missing");
							} else {
								System.out.print(instance.classValue());
								//System.out.print(" AQUI 2!!!!");
								if (instance.classValue()== predValue)
									System.out.print(delim + " 1 " + delim);
								else
									System.out.print(delim + " 0 " + delim);
							}
							System.out.print("\n");
						} else {
							//	System.out.print(" AQUI 1.1!!!!");

							//imprime o n�mero da instancia e o n�mero da classe predita	
							/*if (Utils.isMissingValue(predValue)) {
                System.out.print(idx + delim + "missing" + delim);
              } else {
                System.out.print(idx + delim
	      	  + testData.classAttribute().value((int)predValue) + delim);
              }*/

							//imprime o valor da classe predita pelo algoritmo 
							/*if (Utils.isMissingValue(predValue)) {
                System.out.print("missing" + delim);
              } else {
                System.out.print(c.distributionForInstance(withMissing)[(int)predValue]+delim);
              }*/


							double[] dist=c.distributionForInstance(instance);
							int k;
							for (k=0; k<dist.length; k++){
								/*if (dist[k]<0.0009)
            	  System.out.print("0.0" + delim);
                else*/
								//trunca o valor e divide por 100 para ficar com apenas 2 casas decimais
								Double distTruncado = Math.round(dist[k]*1000)/1000d;
								System.out.print( distTruncado + delim);
								saidas[ cont ][ k ] = dist[k];
								//System.out.print(dist[k] + delim);
							}
							System.out.print( idx + delim );
							saidas[ cont ][ k++ ] = idx;
							try{
							saidas[ cont ][ k+1 ] = Double.parseDouble( testData.classAttribute().value((int)trueValue) );
							k++;
							}catch (Exception e) {
								saidas[ cont ][ k++ ] =trueValue;
							}
							if( testData.classAttribute().value((int)trueValue) == testData.classAttribute().value((int)predValue) )
								saidas[ cont ][ k++ ] = 1;
							else
								saidas[ cont ][ k++ ] = 0;
							cont++;

							/* Note: the order of class probabilities corresponds
               to the order of class values in the training file */
							//System.out.print(" AQUI 2.2!!!!");

							//imprime o n�mero da classe correta
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

					//imprime a m�dia de acertos em cada fold
					//System.out.print("\n Neste fold, o acerto foi de: " + acertoporfold[i] + " totalizando " + acertos + delim); 
				}
				float media_individual = somaAcertos/numFolds;
				float soma_variancia = 0;

				for (int j=0; j<mediaporfold.length; j++){
					float variancia = (float)((double) (mediaporfold[j]-media_individual)*(double)(mediaporfold[j]-media_individual)); 
					//	System.out.println("variancia por fold, fold " + j + ": "  + variancia);
					soma_variancia = soma_variancia + variancia;	
				}	 
				float x = 1;
				//System.out.println("soma_variancia: " + soma_variancia);
				soma_variancia = (soma_variancia*(x/(numFolds-1)));
				//System.out.println("soma_variancia*(x/(numFolds-1): " + soma_variancia);
				double desvio_padrao = Math.sqrt((double) soma_variancia);
				/*for (int i = 0; i <= mediaporfold.length; i++){
        	System.out.print("\n m�dia no fold " + i + " : " + mediaporfold[i]);
        }*/
				setmedias(media_individual, base);
				setdps((float)desvio_padrao,base);

				System.out.print("\n media individual: " + (media_individual*100) + " desvio padrao: " + (float)(desvio_padrao*100) + delim + "\n");

			} else {
				testData.setClassIndex(cIdx);
				c.buildClassifier(trainData);

				for (int i=0; i<testData.numInstances(); i++) {
					Instance instance = testData.instance(i);
					Instance withMissing = (Instance)instance.copy();
					withMissing.setDataset(testData);
					double predValue=((Classifier)c).classifyInstance(instance);
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
							System.out.print(c.
									distributionForInstance(withMissing)[(int)predValue]+delim);
						}
						System.out.print(testData.classAttribute().value((int)trueValue));
						double[] dist=(c.distributionForInstance(instance));
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

	private static double [] calcularMediasEnsemble ( double [][] soma, int folds ){
		double mediaPorFoldEnsemble [] = new double [ folds ];
		int k;
		int instanciaAtual = 0;
		int elementosPorFold;
		for(int i=0;i<folds;i++){
			elementosPorFold = obterElementosPorFold ( i, soma.length, folds );
			mediaPorFoldEnsemble[i] = 0;
			for(k=0;k<elementosPorFold;k++){
				mediaPorFoldEnsemble[i] += soma[instanciaAtual][ soma[0].length -1 ];
				instanciaAtual++;
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

	private static void imprimirArquivoSaida ( String arquivo, double [][][] resultados, int quantidadeArquivos ){
		try {
			int i;
			Formatter forma = null;
			PrintWriter out = new PrintWriter( arquivo );

			int k = 0;
			out.print( "@relation " + arquivo + "\n" );
			for(i=0;i<quantidadeArquivos;i++)
				for(k=0;k<resultados[0][0].length-3;k++)
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

			for(i=0;i<resultados[0].length;i++){//linha
				forma = new Formatter();
				for(int j=0;j<quantidadeArquivos;j++){ //indice 
					for(k=0;k<resultados[0][0].length -3;k++) //coluna da matriz
						forma.format( "%4.3f ", resultados[j][i][k] );
				}
				forma.format( "%d", (int) resultados[0][i][k+1] );
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

	public static void main (String[] args){
		// -c <int> class arq 
		// -o output

		
		int folds;
		int quantidade;

		String classificadores [];
		String entradas [];
		String saida;
		String saidaTreinamento;
		String mediaDp;



		int i = 0;
		folds = Integer.parseInt( args[i++] );
		saida = args[i++];
		saidaTreinamento = args[i++];
		mediaDp = args[i++];
		quantidade = Integer.parseInt( args[i++] );
		int classificadorAtual = 0;
		classificadores = new String[ quantidade ];
		entradas = new String[ quantidade ];
		classificadores[0] = "";
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

		double resultado [][][] = new double [quantidade][][];


		arffParaPesos = new Instances[ quantidade ][];

		for(i=0;i<quantidade;i++)
			resultado[i] = avaliar( (classificadores[i] + " -t " + entradas[i] + " -x " + folds).split(" "), i );

		//separa os resultados em diversos arquivos q ser�o usados como teste para MLP E NB
		//int foldCorrente = 0;
		int linhaCorrente = 0;
		int ultimaLinha = 0;
		for (int qtFolds=0;qtFolds<folds;qtFolds++){
			int elementosFold = obterElementosPorFold(qtFolds, resultado[0].length, folds);
			double arffTeste [][][] = new double [quantidade][elementosFold][resultado[0][0].length];		
			for (int indice=0;indice<quantidade;indice++){
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
			String nomeArquivo = saida.substring(0,saida.indexOf('.')) + "_" + qtFolds + ".arff";
			imprimirArquivoSaida(nomeArquivo, arffTeste, quantidade);
			linhaCorrente = ultimaLinha;
			for(int ind=0;ind<quantidade;ind++){
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
		double soma [][] = somar( resultado, quantidade );

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
		double voto [][] = somar( obterResultadoVoto( resultado ), quantidade );
		double mediasEnsembleVoto [] = calcularMediasEnsemble( voto, folds );
		double mediaEnsembleVoto = 0;
		for(i=0;i<folds;i++){
			mediaEnsembleVoto += mediasEnsembleVoto[ i ];
		}
		mediaEnsembleVoto /= folds;
		double dpEnsembleVoto = calcularDpEnsemble( mediaEnsembleVoto, mediasEnsembleVoto, folds );

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

		String resultadoSomaEVoto = imprimirMediaEDp( quantidade, mediaEnsemble, dpEnsemble, mediaEnsembleVoto, dpEnsembleVoto );

		double [][][] pesos = new double[ quantidade ][ folds ][ getNumClasses() ];
		int j;//, k;
		for(i=0;i<quantidade;i++)
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


		double peso [][] = somar( obterResultadoPeso( resultado, pesos, folds ), quantidade );
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

		Instances foldArquivo [] = new Instances[ quantidade ];
		for(i=0;i<arffParaPesos[0].length;i++){
			for(j=0;j<quantidade;j++)
				foldArquivo[j] = arffParaPesos[j][i];
			//gerarMLP_NB( i, foldArquivo, folds, entradas, classificadores );
			gerarMLP_NB( i, foldArquivo, folds, saidaTreinamento, classificadores );
		}
	}

	public static int obterElementosPorFold ( int fold, int quantidadeElementos, int quantidadeFolds ){
		int instanciaPorFold = quantidadeElementos / quantidadeFolds;
		int acrescentar = quantidadeElementos % quantidadeFolds;
		int foldInteiro = (int) Math.floor(instanciaPorFold);
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
	private static double [][][] obterResultadoVoto ( double [][][] resultados ){
		int i, j, k, maior;
		double votos [][][] = new double [ resultados.length ][ resultados[0].length ][ resultados[0][0].length ]; 
		for(i=0;i<resultados.length;i++){
			for(j=0;j<resultados[i].length;j++){
				maior = 0;
				for(k=1;k<resultados[i][j].length -3;k++){
					if( resultados[i][j][maior] < resultados[i][j][k] ) // valor mais a esquerda em caso empate
						maior = k;
					votos[i][j][k] = 0;
				}
				votos[i][j][maior] = 1;
				for(k=resultados[i][j].length -3;k<resultados[i][j].length;k++)
					votos[i][j][k] = resultados[i][j][k];
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

	private static double [][] somar( double resultado[][][], int quantidade ){
		double [][] soma = new double [resultado[0].length][resultado[0][0].length -1];
		float max = -1;
		float empate = -1;
		int posMax = -1;
		int valorClasse = -1;
		int colClasse = -1;
		double result = 0;
		float somaLinha = 0;
		int k = 0;
		int i;

		for(i=0;i<resultado[0].length;i++){//linha
			colClasse = resultado[0][0].length -2;
			valorClasse = (int) resultado[0][i][colClasse];
			for(k=0;k<resultado[0][0].length -3;k++){ //coluna da matriz
				for(int j=0;j<quantidade;j++){ //indice 
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

	private static float medias[] = new float[12];

	private static Instances arffParaPesos [][];
	private static int numClasses;

	static float dps[]={0,0,0,0,0,0,0,0,0,0,0,0};
}
