package com.veda.icc.esb.screech;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlRootElement(name = "CommercialPlusConsumerCreditEnquiryByFileNumberRequest", namespace = "http://www.vedaxml.com/bureau/internal/individual/v1")
@XmlType(namespace="http://www.vedaxml.com/bureau/internal/individual/v1")
@XmlAccessorType(value = XmlAccessType.FIELD)
public class Business implements Serializable{

    private static final long serialVersionUID = 1L;

    @XmlElement
    private String id;
}
