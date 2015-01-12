package com.ensimag.pap.model;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author casablanca
 */
public class Objects implements Serializable {
    
    private int id;
    private String name;
    private String imageID;
    private String availability;
    private Date depDate;
    private int disp;
    private int numCasier;
    private String desc;
    private String dureemax;
    private int accepted;

    public Objects(int id, String name, String imageID, String availability, Date depDate, int disp, int numCasier, String desc, String dureemax, int accepted) {
        this.id = id;
        this.name = name;
        this.imageID = imageID;
        this.availability = availability;
        this.depDate = depDate;
        this.disp = disp;
        this.numCasier = numCasier;
        this.desc = desc;
        this.dureemax = dureemax;
        this.accepted = accepted;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getImageID() {
        return imageID;
    }

    public String getAvailability() {
        return availability;
    }

    public Date getDepDate() {
        return depDate;
    }

    public int isDisp() {
        return disp;
    }

    public int getNumCasier() {
        return numCasier;
    }

    public String getDesc() {
        return desc;
    }

    public String getDureemax() {
        return dureemax;
    }

    public int isAccepted() {
        return accepted;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setImageID(String imageID) {
        this.imageID = imageID;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }

    public void setDepDate(Date depDate) {
        this.depDate = depDate;
    }

    public void setDisp(int disp) {
        this.disp = disp;
    }

    public void setNumCasier(int numCasier) {
        this.numCasier = numCasier;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public void setDureemax(String dureemax) {
        this.dureemax = dureemax;
    }

    public void setAccepted(int accepted) {
        this.accepted = accepted;
    }   
    
}
