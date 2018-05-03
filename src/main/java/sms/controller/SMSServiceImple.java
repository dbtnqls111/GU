package sms.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sms.dao.CertifiDAO;

@Service
public class SMSServiceImple implements SMSService{
	
	@Autowired
	private CertifiDAO certifiDAO;

	@Override
	public void insertCertificationKey(HashMap<Object, Object> param) {
		certifiDAO.insertCertificationKey(param);
	}

	@Override
	public String getTempKey(String tempKey) {
		return certifiDAO.getTempKey(tempKey);
	}

	@Override
	public void deleteTempKey(String tempKey) {
		certifiDAO.deleteTempKey(tempKey);
	}

}
