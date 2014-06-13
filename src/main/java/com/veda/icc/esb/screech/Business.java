package com.veda.icc.esb.screech;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * 1       SQLCHAR             0       12      ","      1     UID                              ""
2       SQLCHAR             0       12      ","      2     BDDATASOURCEID                   ""
3       SQLCHAR             0       12      ","      3     Screech_ID                       ""
4       SQLCHAR             0       200     ","      4     ORGANISATION                     Latin1_General_CI_AS
5       SQLCHAR             0       200     ","      5     ADDRESS                          Latin1_General_CI_AS
6       SQLCHAR             0       140     ","      6     LOCATION                         Latin1_General_CI_AS
7       SQLCHAR             0       3       ","      7     STATE                            Latin1_General_CI_AS
8       SQLCHAR             0       4       ","      8     POSTCODE                         Latin1_General_CI_AS
9       SQLCHAR             0       40      ","      9     ST_NAME                          Latin1_General_CI_AS
10      SQLCHAR             0       12      ","      10    ST_NUMBER                        Latin1_General_CI_AS
11      SQLCHAR             0       40      ","      11    ST_EXTRA                         Latin1_General_CI_AS
12      SQLCHAR             0       1       ","      12    ODDEVEN                          Latin1_General_CI_AS
13      SQLCHAR             0       50      ","      13    EMAIL                            Latin1_General_CI_AS
14      SQLCHAR             0       100     ","      14    WEBSITE                          Latin1_General_CI_AS
15      SQLCHAR             0       10      ","      15    NOOFEMPLOYEES                    Latin1_General_CI_AS
16      SQLCHAR             0       20      ","      16    ACPHONE                          Latin1_General_CI_AS
17      SQLCHAR             0       20      ","      17    ACFAX                            Latin1_General_CI_AS
18      SQLCHAR             0       16      ","      18    ABN                              Latin1_General_CI_AS
19      SQLCHAR             0       1       ","      19    BUSINESS_TYPES                   Latin1_General_CI_AS
20      SQLCHAR             0       24      ","      20    Received_D                       ""
21      SQLCHAR             0       20      ","      21    REVENUE                          Latin1_General_CI_AS
22      SQLCHAR             0       20      ","      22    MOBILE                           Latin1_General_CI_AS
23      SQLCHAR             0       20      "\r\n"   23    FREECALL                         Latin1_General_CI_AS
 * @author katietoby
 *
 */

@XmlRootElement(name = "business"/*, namespace = "http://www.vedaxml.com/screech/v1"*/)
@XmlType(/*namespace="http://www.vedaxml.com/screech/v1"*/)
@XmlAccessorType(value = XmlAccessType.FIELD)
public class Business implements Serializable{

    private static final long serialVersionUID = 1L;

    @XmlElement(name="_id")
    private String uid;
    private String sourceId;
    private String screechId;
    private String organisation;
    private String address;
    private String location;
    private String state;
    private String postcode;
    private String stName;
    private String stNumber;
    private String stExtra;
    private String oddEven;
    private String email;
    private String website;
    private String noOfEmployees;
    private String phone;
    private String fax;
    private String abn;
    private String types;
    private String received;
    private String revenue;
    private String mobile;
    private String freecall;
    
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getSourceId() {
		return sourceId;
	}
	public void setSourceId(String sourceId) {
		this.sourceId = sourceId;
	}
	public String getScreechId() {
		return screechId;
	}
	public void setScreechId(String screechId) {
		this.screechId = screechId;
	}
	public String getOrganisation() {
		return organisation;
	}
	public void setOrganisation(String organisation) {
		this.organisation = organisation;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getStName() {
		return stName;
	}
	public void setStName(String stName) {
		this.stName = stName;
	}
	public String getStNumber() {
		return stNumber;
	}
	public void setStNumber(String stNumber) {
		this.stNumber = stNumber;
	}
	public String getStExtra() {
		return stExtra;
	}
	public void setStExtra(String stExtra) {
		this.stExtra = stExtra;
	}
	public String getOddEven() {
		return oddEven;
	}
	public void setOddEven(String oddEven) {
		this.oddEven = oddEven;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getNoOfEmployees() {
		return noOfEmployees;
	}
	public void setNoOfEmployees(String noOfEmployees) {
		this.noOfEmployees = noOfEmployees;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getAbn() {
		return abn;
	}
	public void setAbn(String abn) {
		this.abn = abn;
	}
	public String getTypes() {
		return types;
	}
	public void setTypes(String types) {
		this.types = types;
	}
	public String getReceived() {
		return received;
	}
	public void setReceived(String received) {
		this.received = received;
	}
	public String getRevenue() {
		return revenue;
	}
	public void setRevenue(String revenue) {
		this.revenue = revenue;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getFreecall() {
		return freecall;
	}
	public void setFreecall(String freecall) {
		this.freecall = freecall;
	}
	@Override
	public String toString() {
		return "Business [uid=" + uid + ", sourceId=" + sourceId
				+ ", screechId=" + screechId + ", organisation=" + organisation
				+ ", address=" + address + ", location=" + location
				+ ", state=" + state + ", postcode=" + postcode + ", stName="
				+ stName + ", stNumber=" + stNumber + ", stExtra=" + stExtra
				+ ", oddEven=" + oddEven + ", email=" + email + ", website="
				+ website + ", noOfEmployees=" + noOfEmployees + ", phone="
				+ phone + ", fax=" + fax + ", abn=" + abn + ", types=" + types
				+ ", received=" + received + ", revenue=" + revenue
				+ ", mobile=" + mobile + ", freecall=" + freecall + "]";
	}
}
