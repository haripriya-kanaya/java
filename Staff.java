package com.infinite.java;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.apache.catalina.User;

import org.apache.logging.log4j.LogManager;
@ManagedBean(name = "Staff")
@SessionScoped
@Entity




@Table(name="staff")
public class Staff implements Serializable {
	private static final org.apache.logging.log4j.Logger logger = LogManager.getLogger(Staff.class);		
	
    private static final long serialVersionUID = 1L; 
    
    public void setStaffid(String staffid) {
		this.staffid = staffid;
		logger.info("Setting ID to: " + staffid);
	
	}
	
@Id
	
	@Column(name="staffid")
	private String staffid;
    @Column(name="username")
	private String username;
    @Column(name="vechilenumber")
	private String vechilenumber;
    @Column(name="startdate")
	private Date startdate;
    @Column(name="enddate")
	private Date enddate;
    @Column(name="category")
	private String category;
    @Column(name="slotnumber")
	private String slotnumber;
    @Column(name="calculatedamount")
	private double calculatedamount;
    @Id
    @Column(name="bookid")
	private String bookid;

	
	
	public Staff(String staffid, String username, String vechilenumber, Date startdate, Date enddate, String category,
			String slotnumber, double calculatedamount) {
		super();
		this.staffid = staffid;
		this.username = username;
		this.vechilenumber = vechilenumber;
		this.startdate = startdate;
		this.enddate = enddate;
		this.category = category;
		this.slotnumber = slotnumber;
		this.calculatedamount = calculatedamount;
	}
	public Staff() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getStaffid() {
		return staffid;
	}
	
	
	public String getVechilenumber() {
		return vechilenumber;
	}
	public void setVechilenumber(String vechilenumber) {
		this.vechilenumber = vechilenumber;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSlotnumber() {
		return slotnumber;
	}
	public void setSlotnumber(String slotnumber) {
		this.slotnumber = slotnumber;
	}
	
	public double getcalculatedamount() {
		return calculatedamount;
	}
	public void setCalculateamount(double calculatedamount) {
		this.calculatedamount = calculatedamount;
	}
	public String getBookid() {
		return bookid;
	}
	public void setBookid(String bookid) {
		this.bookid = bookid;
	}
	public Staff(double chargesperday) {
		super();
		this.calculatedamount = chargesperday;
	}
	@Override
	public String toString() {
		return "Staff [username=" + username + "]";
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	
	
	
}
