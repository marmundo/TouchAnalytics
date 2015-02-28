package com.marcelodamasceno.cancelable;

import weka.core.Instances;

public abstract class Cancelable {

    /**
     * Method to generate the cancelable data
     * @return cancelable dataset
     * @throws Exception 
     */
    public abstract Instances generate() throws Exception;

}
