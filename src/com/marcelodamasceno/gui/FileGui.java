package com.marcelodamasceno.gui;

import java.io.File;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

public class FileGui {

    public static File chooseFile(String path){
	JFileChooser fileChooser=new JFileChooser(path);
	try {
	    int nState=fileChooser.showOpenDialog(null);
	    if(nState==JFileChooser.APPROVE_OPTION){
		return fileChooser.getSelectedFile();		
	    }
	} catch (Exception e) {
	    JOptionPane.showMessageDialog(null, e.getMessage(),"Error", JOptionPane.ERROR_MESSAGE);
	}
	return null;
    }
    
}
