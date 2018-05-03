package sms.controller;


import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import sms.dao.CertifiDAO;


/**
 * @author lejewk
 * sms인증시 전화번호에대한 키 제네레이터
 */
public class CertificationKeyGenerator {
	
	public static CertificationKeyGenerator newInstance(){
		return new CertificationKeyGenerator();
	}
	
	private CertificationKeyGenerator(){}

	public String tempKeyGenarator(String Number){
		String lastNumberString = null;
		String numberArray[] = Number.split("-");
		if(numberArray[2].charAt(0) == '0'){
			lastNumberString = "1"+numberArray[2].substring(1, numberArray[2].length());
		}else{
			lastNumberString = numberArray[2];
		}
		String last = Long.toString((Integer.parseInt(lastNumberString) * System.currentTimeMillis()));
		return last.substring(last.length()-6, last.length());
	}

}
