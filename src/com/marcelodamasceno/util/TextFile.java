package com.marcelodamasceno.util;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

/**
 * Text File Class
 * @author marcelo
 *
 */
public class TextFile {

    /**
     * Content of the file
     */
    private String content;
    /**
     * Name of the File
     */
    private String fileName;
    /**
     * File object
     */
    private File textFile;

    /**
     * Path of the file
     */
    private String path;

    /**
     * Constructor
     * @param fileName Name of the file
     * @param path Path of the file
     */
    public TextFile(String fileName, String path) {
	this.setFileName(fileName);
	this.setPath(path);
	textFile = new File(path, fileName);
	try {
	    if (!textFile.createNewFile()) {
		FileUtils.writeStringToFile(textFile, "");
	    }
	} catch (IOException e) {
	    e.printStackTrace();
	}
    }

    /**
     * Constructor
     * @param fileName Name of the file
     */
    public TextFile(String fileName) {
	this(fileName, "./Results/");
    }

    /**
     * Add content to the text file
     * @param text Content will be add
     */
    public void add(String text) {
	try {
	    content = FileUtils.readFileToString(textFile);
	    content = content + "\n" + text;
	    FileUtils.writeStringToFile(textFile, content);
	} catch (IOException e) {
	    e.printStackTrace();
	    System.err.println("File doenst exist!");
	}
    }

    /**
     * Writes the @text in the File
     * @param text Content will be written
     */
    public void write(String text) {
	try {
	    FileUtils.writeStringToFile(textFile, text);
	} catch (IOException e) {
	    e.printStackTrace();
	    System.err.println("File doenst exist!");
	}
    }

    /**
     * Read the text File
     * @return The content of the file
     */
    public String read() {
	try {
	    return FileUtils.readFileToString(textFile);
	} catch (IOException e) {
	    e.printStackTrace();
	    return null;
	}
    }

    public static void main(String[] args) {
	TextFile text = new TextFile("teste.txt");
	text.add("teste");
	text.add("teste2");
	System.out.println(text.read());
    }

    public String getFileName() {
	return fileName;
    }

    public void setFileName(String fileName) {
	this.fileName = fileName;
    }

    public String getPath() {
	return path;
    }

    public void setPath(String path) {
	this.path = path;
    }
}
