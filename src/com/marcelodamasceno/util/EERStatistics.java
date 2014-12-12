package com.marcelodamasceno.util;

public class EERStatistics {
	
	private double mean=0;
	private double std=0;
	private String name="";
	
	public EERStatistics(String name,double mean,double std){
		this.setName(name);
		this.mean=mean;
		this.std=std;
	}

	
	
	public double getMean() {
		return mean;
	}
	public void setMean(double mean) {
		this.mean = mean;
	}
	public double getStd() {
		return std;
	}
	public void setStd(double std) {
		this.std = std;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}
}
