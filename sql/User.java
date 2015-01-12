package com.ensimag.DAC4.model;

import java.io.Serializable;

/**
 *
 * @author casablanca
 */

public class User implements Serializable {

	private int id;
	private String name;
	private String fname;
	private String email;
	private String login;
	private String password;
	private int credits;
	private int inscrValidee;
	
	
	public User(int id, String name, String fname, String email, String login, String password, int credits, int inscrValidee){
	super();
	this.id=id;
	this.name=name;
	this.fname=fname;
	this.email=email;
	this.login=login;
	this.password=password;
	this.credits=credits;
	this.inscrValidee=inscrValidee;
	}
	
	    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setCredits(int credits) {
        this.credits = credits;
    }

    public void setInscrValidee(int inscrValidee) {
        this.inscrValidee = inscrValidee;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getFname() {
        return fname;
    }

    public String getEmail() {
        return email;
    }

    public String getLogin() {
        return login;
    }

    public String getPassword() {
        return password;
    }

    public int getCredits() {
        return credits;
    }

    public int isInscrValidee() {
        return inscrValidee;
    }
	


}