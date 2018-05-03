package sms.controller;

import java.util.HashMap;

public interface SMSService {
	
	void insertCertificationKey(HashMap<Object, Object> param);
	
	String getTempKey(String tempKey);
	
	void deleteTempKey(String tempKey);
	
}
