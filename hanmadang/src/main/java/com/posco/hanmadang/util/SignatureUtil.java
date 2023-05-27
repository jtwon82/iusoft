package com.posco.hanmadang.util;

import java.security.MessageDigest;

public class SignatureUtil {


	/**
	 * SHA-256 Hash 생성
	 * 
	 * @param data
	 * @param algorithm
	 * @return
	 * @throws Exception
	 */
	private static String hash(String data) throws Exception {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(data.getBytes("UTF-8"));
		byte[] hashbytes = md.digest();

		StringBuilder sbuilder = new StringBuilder();
		for(int i=0 ; i<hashbytes.length ; i++){

			// %02x 부분은 0 ~ f 값 까지는 한자리 수이므로 두자리 수로 보정하는 역할을 한다.
			sbuilder.append(String.format("%02x", hashbytes[i] & 0xff));
		}
		return sbuilder.toString();
	}
	
	/**
	 * 메세지 서명 생성 
	 * 
	 * timestamp+hash(message)
	 * 
	 * @param mbrId
	 * @param salesPrice
	 * @param oid
	 * @param timeStamp (YYYYMMDDHHMMSS)
	 * @return
	 * @throws Exception
	 */
	public static String hash(String mbrId, String salesPrice, String oid, String timestamp) throws Exception {

		return timestamp+SignatureUtil.hash(String.format("%s|%s|%s|%s", mbrId, salesPrice, oid, timestamp));

	}
}
