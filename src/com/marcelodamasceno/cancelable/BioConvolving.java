package com.marcelodamasceno.cancelable;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;

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
public class BioConvolving {

    public BioConvolving() {
	super();
	// TODO Auto-generated constructor stub
    }

    /**
     * @param args
     * @throws FileNotFoundException
     */
    public static void main(String[] args) throws FileNotFoundException {

	ArffConector conector = new ArffConector();
	Instances dataset = null;
	String projectPath = "/home/marcelo/Área de Trabalho/Documentos-Windows/Google Drive/doutorado/projeto/dataset/Base de Toque/";
	String folderResults = "IntraSession/";

	dataset = conector.openDataSet(projectPath + folderResults
		+ "IntraSession-User_41_Day_1_Scrolling.arff");

	// Iniciando a matriz de arrays originais
	double[][] r = new double[dataset.numInstances()][dataset
		.numAttributes()];
	r = Transformations.instancestoArray(dataset);

	// Iniciando a matrix de arrays transformados
	double[][] f = new double[dataset.numInstances()][dataset
		.numAttributes()];

	// Passo 1: Defina o números de segmentos(W) que dividirá os dados
	// biométricos originais;

	int w = 2;

	// Passo 2: 2. Selecione aleatoriamente (W-1) números inteiros
	// aleatórios, denominados d_j
	int min = 1;
	int max = 99;
	int[] d = new int[w];
	d[0] = 0;
	d[w] = 100;
	for (int j = 1; j <= w - 1; j++) {
	    int random = Utils.getRandowNumber(min, max);
	    d[j] = random;
	}
	// Ordenando d
	Arrays.sort(d);

	// Passo 3:Converta os valores d_j, de acordo com b_j=round((d_j/100)*N)
	int n = dataset.numAttributes();
	int[] b = new int[w];
	for (int j = 0; j < d.length; j++) {
	    b[j] = Math.round((d[j] / 100) * n);
	}

	// Passo 4: Divida a sequência original r(i)[n] em W segmentos r(i)j, de
	// comprimento N_j=b_j-b_j-1, cada um definido como:
	// r(i)j,N_j[n]=r(i)[n+b_j-1]

	// N_j
	int[] N = new int[b.length - 1];
	// r(i)j
	ArrayList<Double> rij = new ArrayList<Double>();
	// Convolução
	ArrayList<Double> convolucao=new ArrayList<Double>();
	
	for (int row = 0; row < r.length; row++) {
	    for (int j = 0; j < b.length; j++) {
		N[j] = b[j + 1] - b[j];
		if (j == 0) {
		    for (int i = 0; i < N[j]; i++) {
			rij.add(r[row][i]);
		    }
		} else {
		    for (int i = N[j - 1]; i <= N[j]; i++) {
			rij.add(r[row][i]);
		    }
		    convolucao = convolucao(rij, N[j - 1], N[j]);
		}

	    }
	}

    }

    public static ArrayList<Double> convolucao(ArrayList<Double> rij, int numFirstArray,
	    int numSecondArray) {
	ArrayList<Double> f = new ArrayList<Double>();
	ArrayList<Double> g = new ArrayList<Double>();
	ArrayList<Double> h = new ArrayList<Double>();
	double temp = 0.0;
	int max;

	// copy rij to f
	for (int i = 0; i < numFirstArray; i++) {
	    f.add(rij.get(i));
	}
	// copy rij to g
	for (int i = numFirstArray; i < rij.size(); i++) {
	    g.add(rij.get(i));
	}

	/*
	 * if(numSecondArray>numFirstArray){ int
	 * diff=numSecondArray-numFirstArray; for(int i=0;i<diff;i++){
	 * f.add(0.0); } } else{ int diff=numFirstArray-numSecondArray; for(int
	 * i=0;i<diff;i++){ g.add(0.0); } }
	 */
	int kMax = 2 * f.size() - 1;
	for (int k = 0; k < kMax; k++) {
	    temp=0;
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
}
