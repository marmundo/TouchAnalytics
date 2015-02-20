package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;

import weka.core.Instance;
import weka.core.Instances;

import com.marcelodamasceno.util.ArffConector;
import com.marcelodamasceno.util.Transformations;
import com.marcelodamasceno.util.Utils;

/**
 * O número de funções transformadas f(i)[n], i=1, ..., F (F é o número de
 * funções) definem o modelo transformado T. r(i)[n], i=1, ..., F é o número de
 * funções originais que é igual ao número de funções f(i)[n]. Cada f(i)[n] é
 * derivada de uma única função original r(i)[n].
 * 
 * O principal objetivo do BioConvolving é dividir cada sequência dos dados
 * biométricos originais em segmentos não sobrepostos W, que são ordenados por
 * uma chave d de transformação aleatória.
 * 
 * Modelo geral do algoritmo BioConvolving:
 * 
 * 1. Defina o números de segmentos(W) que dividirá os dados biométricos
 * originais;
 * 
 * 2. Selecione aleatoriamente (W-1) números inteiros aleatórios, denominados
 * d_j. Os números selecionados devem estar entre 1 e 99 e ordenados de forma
 * ascendente, d_j>d_j-1, j=1,...,W; Os valores selecionados são arranjados em
 * um vetor d=[d_0, ..., d_w], onde d_0=0 e d_w=100. O vetor d representa a
 * chave de transformação empregada e indica a porcentagem de atributos
 * originais que farão parte de cada uma das funções f(i)[n].
 * 
 * 3.Converta os valores d_j, de acordo com b_j=round((d_j/100)*N), j=0,...,W.
 * 
 * 4.Divida a sequência original r(i)[n] em W segmentos r(i)j, de comprimento
 * N_j=b_j-b_j-1, cada um definido como: r(i)j,N_j[n]=r(i)[n+b_j-1] para
 * n=1,...,N, onde N é o número de atributos e j=1,...,W.
 * 
 * 5. Aplique convoluções lineares as funções r(i)j,Nj[n]:
 * fi[n]=r(i)1,N_1[n]*...*r(i)W,N_W[n]
 * 
 * 
 * @author marcelo
 * 
 */
public class BioConvolving extends Cancelable {

    Instances dataset;

    public BioConvolving(Instances dataset) {
	this.dataset = dataset;
    }

    /**
     * Convolving all the dataset using the segments proportions b
     * 
     * @param r
     *            dataset
     * @param b
     *            proportions in segments
     * @return Transformed DataSet
     */
    private Instances convolvingDataSet(double[][] r, int[] b) {

	// N_j
	int[] N = new int[b.length - 1];
	// r(i)j
	ArrayList<Double> q = new ArrayList<Double>();
	// Convolution
	ArrayList<Double> convolution = new ArrayList<Double>();
	// Transformed dataset
	Instances transformedDataSet = new Instances(dataset);
	transformedDataSet.clear();

	for (int row = 0; row < r.length; row++) {
	    convolution.clear();
	    q.clear();
	    for (int j = 0; j < b.length - 1; j++) {
		N[j] = b[j + 1] - b[j];
		if (j == 0) {
		    for (int i = 0; i < N[j]; i++) {
			convolution.add(r[row][i]);
		    }
		} else {
		    for (int i = N[j - 1]; i < N[j - 1] + N[j]; i++) {
			q.add(r[row][i]);
		    }
		    convolution = convolving(convolution, q);
		}
	    }

	    Instance i = Transformations.doubleArrayToInstanceWithClass(
		    Transformations.doubleToDouble(convolution), dataset);
	    int classIndex = r[0].length - 1;
	    i.setValue(dataset.numAttributes() - 1, r[row][classIndex]);
	    transformedDataSet.add(i);
	}
	return transformedDataSet;

    }

    /**
     * Converto d to Bj Format: round((d[j] / 100) * n)
     * 
     * @param d
     *            array with the segments proportions
     * @return
     */
    private int[] converttoBj(double[] d) {
	int n = dataset.numAttributes();
	int[] b = new int[d.length];
	for (int j = 0; j < d.length; j++) {
	    b[j] = (int) Math.round((d[j] / 100) * n);
	}
	return b;
    }

    /**
     * Generates de key to the w segments
     * 
     * @param w
     *            number of array segments
     * @return
     */
    private double[] generateKey(int w) {
	int min = 1;
	int max = 99;
	double[] d = new double[w + 1];
	d[0] = 0;
	d[w] = 100;
	for (int j = 1; j <= w - 1; j++) {
	    int random = Utils.getRandomNumber(min, max);
	    d[j] = random;
	}
	// Sorting d
	Arrays.sort(d);
	return d;
    }

    /**
     * Linear convolving
     * 
     * @param f
     *            First data points
     * @param g
     *            Second data points
     * @return convolved data points
     */
    public ArrayList<Double> convolving(ArrayList<Double> f, ArrayList<Double> g) {
	ArrayList<Double> h = new ArrayList<Double>();
	double temp = 0.0;
	int kMax = f.size() + g.size() - 1;
	for (int k = 0; k < kMax; k++) {
	    temp = 0;
	    for (int j = 0; j <= k; j++) {
		// This was done because f e g may have different size. If one
		// of statements are true, f.get(j)*g.get(k-j) is 0
		if (j >= f.size() || k - j >= g.size()) {
		    temp = temp + 0;
		} else
		    temp = temp + f.get(j) * g.get(k - j);
	    }
	    h.add(temp);
	}

	return h;
    }

    /**
     * Linear convolving
     * 
     * @param rij
     *            ArrayList with the two data points
     * @param numFirstArray
     *            Lenght of the first data points (f)
     * @param numSecondArray
     *            Lenght of the second data points (f)
     * @return the convolved data points
     */
    public ArrayList<Double> convolving(ArrayList<Double> rij,
	    int numFirstArray, int numSecondArray) {
	ArrayList<Double> f = new ArrayList<Double>();
	ArrayList<Double> g = new ArrayList<Double>();

	// copy rij to f
	for (int i = 0; i < numFirstArray; i++) {
	    f.add(rij.get(i));
	}
	// copy rij to g
	for (int i = numFirstArray; i < rij.size(); i++) {
	    g.add(rij.get(i));
	}

	return convolving(f, g);
    }

    /**
     * @param args
     * @throws FileNotFoundException
     */
    public static void main(String[] args) {

	ArffConector conector = new ArffConector();
	Instances dataset = null;
	String projectPath = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";
	String folderResults = "IntraSession/";

	try {
	    dataset = conector.openDataSet(projectPath + folderResults
		    + "IntraSession-User_41_Day_1_Scrolling.arff");
	} catch (FileNotFoundException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}

	BioConvolving bioconv = new BioConvolving(dataset);
	bioconv.generate();

    }

    @Override
    public Instances generate() {
	// Iniciando a matriz de arrays originais
	double[][] r = new double[dataset.numInstances()][dataset
		.numAttributes()];
	r = Transformations.instancestoArray(dataset);

	// Passo 1: Defina o números de segmentos(W) que dividirá os dados
	// biométricos originais;

	int w = 2;

	// Passo 2: 2. Selecione aleatoriamente (W-1) números inteiros
	// aleatórios, denominados d_j
	double[] d = generateKey(w);

	// Passo 3:Converta os valores d_j, de acordo com b_j=round((d_j/100)*N)
	int[] b = converttoBj(d);

	// Passo 4: Divida a sequência original r(i)[n] em W segmentos r(i)j, de
	// comprimento N_j=b_j-b_j-1, cada um definido como:
	// r(i)j,N_j[n]=r(i)[n+b_j-1]

	Instances transformedDataSet = convolvingDataSet(r, b);
	transformedDataSet
		.setClassIndex(transformedDataSet.numAttributes() - 1);

	return transformedDataSet;

    }
}
