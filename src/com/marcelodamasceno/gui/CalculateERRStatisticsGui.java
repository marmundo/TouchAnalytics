package com.marcelodamasceno.gui;

import java.io.File;

import com.marcelodamasceno.util.CalculateEERStatistics;
import com.marcelodamasceno.util.Const;

public class CalculateERRStatisticsGui {

    public void calculateERRbyGUI(String path){
	File file=FileGui.chooseFile(path);
	CalculateEERStatistics eerStatistics=new CalculateEERStatistics(file);	
    }
    
        
    public static void main(String args[]){
	CalculateERRStatisticsGui eerGuiChooser=new CalculateERRStatisticsGui();	
	eerGuiChooser.calculateERRbyGUI(Const.PROJECTPATH);
    }
}
