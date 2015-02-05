package com.marcelodamasceno.fusion.score;

import java.util.ArrayList;

/**
 * Class to implement Matrix of Scores calculated by Classifiers
 * @author marcelo
 *
 */
public class ScoreMatrix implements Cloneable {
    
    ArrayList<ArrayList<Double>> scoreMatrix;
    
    public ArrayList<ArrayList<Double>> getScoreMatrix() {
        return scoreMatrix;
    }

    /**
     * Set a matrix of scores
     * @param scoreMatrix Matrix of scores
     */
    public void setScoreMatrix(ArrayList<ArrayList<Double>> scoreMatrix) {
        this.scoreMatrix = scoreMatrix;
    }

    /**
     * Constructor
     */
    public ScoreMatrix( ){
	scoreMatrix=new ArrayList<ArrayList<Double>>();
    }
    
    /**
     * Add a row of scores. First value of row is the user label
     * @param row Row of scores
     */
    
    public void add(ArrayList<Double> row){
	scoreMatrix.add(cloneRow(row));	
    }
    
    /**
     * Clones the ArrayList <code>row</code>
     * @param row
     * @return
     */
    private ArrayList<Double> cloneRow(ArrayList<Double> row){
	ArrayList<Double> newRow= new ArrayList<Double>();
	for (Double value : row) {
	    newRow.add(value);
	}
	return newRow;
    }
    
    /**
     * Print in console the matrix of scores
     */
    public void print(){
	System.out.println(scoreMatrix.toString());
    }
    
    /**
     * Return from the matrix of scores all the scores rows belonged to <code>user</code>
     * @param user
     * @return matrix of scores belonged to <code>user</code>
     */
    public ArrayList<ArrayList<Double>> getRows(int user){
	ArrayList<ArrayList<Double>> userScores=new ArrayList<ArrayList<Double>>();
	for(ArrayList<Double> row:scoreMatrix){
	    if(row.get(0)==user){
		userScores.add(row);
	    }
	}
	return userScores;
    }
    
    /**
     * Example of class use
     * @param args
     */
    public static void main(String[] args){
	//Creating Matrix of Scores
	ScoreMatrix scoreMatrix =new ScoreMatrix();
	
	//Creating the row of scores
	ArrayList<Double> scores=new ArrayList<Double>();	
	scores.add(1.0);
	scores.add(0.9);
	scores.add(0.1);
	scoreMatrix.add(scores);
	
	System.out.println("Printing the scores of user 1");
	System.out.println(scoreMatrix.getRows(1).toString());
	
	//Cleaning the score
	scores.clear();
	
	//Creating the row of scores
	scores.add(1.0);
	scores.add(0.8);
	scores.add(0.2);
	scoreMatrix.add(scores);
	
	System.out.println("Printing the scores of user 1");
	System.out.println(scoreMatrix.getRows(1).toString());
	
	System.out.println("Printing Matrix of scores");
	scoreMatrix.print();
    }

}
