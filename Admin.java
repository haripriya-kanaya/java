package com.infinite.java;

import java.util.Date;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
@ManagedBean(name = "Admin")
@SessionScoped
@Entity

@Table(name="admin")
public class Admin {
@Id
	
	@Column(name="adminid")
	private String adminid;
     @Column(name="vehiclenumber")
	private String vehiclenumber;
     @Column(name="intime")
     
     private Date intime;

     @Column(name = "outtime")
     @Temporal(TemporalType.TIMESTAMP)
     private Date outtime;
   
     @Column(name="category")
	private String category;
	public String getAdminid() {
		return adminid;
	}
	public void setAdminid(String adminid) {
		this.adminid = adminid;
	}
	
	public String getVehiclenumber() {
		return vehiclenumber;
	}
	  public void setVehicleNumber(String vehicleNumber) {
	        this.vehiclenumber = vehicleNumber;
	    }
	public Date getIntime() {
		return intime;
	}
	public void setIntime(Date intime) {
		this.intime = intime;
	}
	public Date getOuttime() {
		return outtime;
	}
	public void setOuttime(Date outtime) {
		this.outtime = outtime;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	@Override
	public String toString() {
		return "Admin [adminid=" + adminid + ", vehiclenumber=" + vehiclenumber + ", intime=" + intime + ", outtime="
				+ outtime + ", category=" + category + "]";
	}
	public Admin(String adminid, String vechilenumber, Date intime, String category) {
		super();
		this.adminid = adminid;
		this.vehiclenumber = vechilenumber;
		this.intime = intime;
		this.category = category;
	}
	public Admin() {
		
		// TODO Auto-generated constructor stub
	}

}
