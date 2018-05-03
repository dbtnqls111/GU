package sms.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sms.dao.CertifiDAO;

@Controller
public class SMSController {

	@Autowired
	private SMSService smsService;
	
	/*인증키 생성 / db 삽입 / 문자전송*/
	@RequestMapping(value = "/member/certifi_request.do")
	public @ResponseBody String certificationKeyGeneration(HttpServletRequest request) throws Exception {
		
		String str = "";
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String phone = phone1 + "-" + phone2 + "-" + phone3;
		System.out.println(phone1);
		
		//인증키 생성
		String tempKey = CertificationKeyGenerator.newInstance().tempKeyGenarator(phone);
		System.out.println("암호화된 키 : " + tempKey);

		//인증키및 전화번호 파라미터화
		HashMap<Object, Object> param = new HashMap<Object, Object> ();
		param.put("tempKey", tempKey);
		param.put("phone", phone);
		
		//SMS를 보내기위해 작업
		SMSFactory smsFactory = new SMSFactory(tempKey, phone);
		if(smsFactory.Send()){
			//sms로 발송한 인증키를 db에 삽입
			smsService.insertCertificationKey(param);
			System.out.println("sms 전송 완료");
			str="{\"result\":\"success\"}";
		}

		return str;
	}

	
	/*db에 저장된 인증번호와 입력한 인증번호 비교*/
	@RequestMapping(value = "/member/certifi_confirm.do")
	public @ResponseBody String certification(HttpServletRequest request) throws Exception {
		String str = "";
		String inputKey = request.getParameter("inputKey");

		//db에서 dbKey를 가져와 저장할 임시변수
		String dbKey = "";
		//암호화된 전화번호로 임시키 가져옴
		dbKey = smsService.getTempKey(inputKey);
		//인풋키와 임시키 비교
		if(inputKey.equals(dbKey)){
			//디비에 누적된 임시키 삭제
			smsService.deleteTempKey(inputKey);
			str="{\"result\":\"success\"}";
		}else{
			str="{\"result\":\"fail\"}";
		}
		return str;

	}

}
