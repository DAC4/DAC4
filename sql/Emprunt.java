package com.ensimag.pap.model;

import java.io.Serializable;
import java.util.Date;


/**
 *
 * @author casablanca
 */
public class Emprunt implements Serializable {
    
    private int id;
    private Date date;
    private User util;
    private Object objet;
    private int returned;
    private int datedep;

    public Emprunt(int id, Date date, User util, Object objet, int returned, int datedep) {
        this.id = id;
        this.date = date;
        this.util = util;
        this.objet = objet;
        this.returned = returned;
        this.datedep = datedep;
    }

    public int getId() {
        return id;
    }

    public Date getDate() {
        return date;
    }

    public User getUtil() {
        return util;
    }

    public Object getObjet() {
        return objet;
    }

    public int getReturned() {
        return returned;
    }

    public int getDatedep() {
        return datedep;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setUtil(User util) {
        this.util = util;
    }

    public void setObjet(Object objet) {
        this.objet = objet;
    }

    public void setReturned(int returned) {
        this.returned = returned;
    }

    public void setDatedep(int datedep) {
        this.datedep = datedep;
    }

}
