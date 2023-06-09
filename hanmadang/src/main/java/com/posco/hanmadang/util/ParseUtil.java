package com.posco.hanmadang.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.TreeMap;

import org.apache.commons.lang.StringUtils;

public class ParseUtil {
	private static final String AND = "&";
	private static final String EQUALS = "=";
	static String _rest;

	public static String TrimLeft(String strSource, char cTrim) {
		String strRet = strSource;

		if (strSource.length() <= 1) {
			return null;
		}
		if (strSource.charAt(0) == cTrim) {
			strRet = strSource.substring(1);
		}
		return strRet;
	}

	public static String TrimRight(String strSource, char cTrim) {
		String strRet = strSource;
		if (strSource.length() <= 1)
			return null;
		int nSourceLength = strSource.length();

		if (strSource.charAt(nSourceLength - 1) == cTrim) {
			strRet = strSource.substring(0, nSourceLength - 1);
		}
		return strRet;
	}

	public static boolean CheckOption(String szSrc, String szOption, boolean bCompareNoCase) {
		boolean bRet = false;
		if (bCompareNoCase) {
			bRet = szSrc.toLowerCase().contains(szOption.toLowerCase());
		} else {
			bRet = szSrc.contains(szOption);
		}
		return bRet;
	}

	public static String m_lpFuncParser1(int start, String src, String key, String token1st, String token2nd) {
		String ret = src.substring(start, src.length());
		int temp = ret.indexOf(key + token1st);
		if (temp < 0)
			return "";
		ret = ret.substring(temp + (key + token1st).length(), ret.length());
		temp = ret.indexOf(token2nd);
		if (temp < 0) {
			return ret;
		}
		ret = ret.substring(0, temp);
		return ret;
	}

	public static String m_lpFuncParser2(int start, String src, String key, String token1st, String token2nd) {
		String ret = src.substring(start, src.length());
		System.out.println("처음값 : " + ret);
		int temp1 = ret.indexOf(key + token1st);
		System.out.println("처음 범위 : " + temp1);
		if (temp1 < 0)
			return "";
		if (temp1 != 0) {
			ret = ret.substring(start, ret.length());
		} else {
			ret = ret.substring(temp1, ret.length());
		}
		System.out.println("두번째 값 : " + ret);
		int temp2 = ret.indexOf(token2nd);
		System.out.println("두번째 범위 : " + temp2);
		if (temp2 < 0)
			return "";
		ret = ret.substring(temp1, temp2);
		System.out.println("마지막 리턴 값 : " + ret);
		return ret;
	}

	public static String m_lpFuncParser1(int start, String src, String token) {
		if (src == null)
			src = _rest;
		String ret = src.substring(start, src.length());
		int temp = ret.indexOf(token);
		if (temp < 0)
			return "";
		ret = ret.substring(temp, ret.length());
		return ret;
	}

	public static String m_lpFuncParser3(int start, String src, String token) {
		if (src == null)
			src = _rest;
		String ret = src.substring(start, src.length());
		int temp = ret.indexOf(token);
		if (temp < 0)
			return "";
		ret = ret.substring(start, temp);
		return ret;
	}

	public static String m_lpFuncParser2(int start, String src, String key, String token) {
		String ret = src.substring(start, src.length());
		System.out.println("처음값 : " + ret);

		int temp = ret.indexOf(key + token);
		if (temp < 0)
			return "";
		ret = ret.substring(temp, ret.length());
		return ret;
	}

	public static Map<String, String> parseStringToMap(String str) throws Exception {
		return parseStringToMap(str, "&", "=");
	}

	public static Map<String, String> parseStringToMap(String str, String and) throws Exception {
		return parseStringToMap(str, and, "=");
	}

	public static Map<String, String> parseStringToMap(String str, String and, String equals) throws Exception {
		Map hash = new Hashtable();
		StringTokenizer token = new StringTokenizer(str, and);
		String temp = "";

		while (token.hasMoreElements()) {
			try {
				temp = token.nextToken();
				hash.put(temp.substring(0, temp.indexOf(equals)), temp.substring(temp.indexOf(equals) + 1));
			} catch (IndexOutOfBoundsException localIndexOutOfBoundsException) {
			}
		}
		return hash;
	}

	public static Map<String, String> parseStringToMapUrlDecode(String str) throws Exception {
		return parseStringToMapUrlDecode(str, "&", "=");
	}

	public static Map<String, String> parseStringToMapUrlDecode(String str, String and) throws Exception {
		return parseStringToMapUrlDecode(str, and, "=");
	}

	public static Map<String, String> parseStringToMapUrlDecode(String str, String and, String equals)
			throws Exception {
		Map hash = new Hashtable();
		StringTokenizer token = new StringTokenizer(str, and);
		String temp = "";

		while (token.hasMoreElements()) {
			try {
				temp = token.nextToken();
				hash.put(temp.substring(0, temp.indexOf(equals)),
						URLDecoder.decode(temp.substring(temp.indexOf(equals) + 1), "UTF-8"));
			} catch (IndexOutOfBoundsException localIndexOutOfBoundsException) {
			}
		}
		return hash;
	}

	public static String parseMapToString(Map<String, String> parameters) throws Exception {
		return parseMapToString(parameters, "&", "=");
	}

	public static String parseMapToString(Map<String, String> parameters, String and) throws Exception {
		return parseMapToString(parameters, and, "&");
	}

	public static String parseMapToString(Map<String, String> parameters, String and, String equals) throws Exception {
		StringBuffer serializeString = new StringBuffer("");

		Map sortedParamMap = new TreeMap();
		sortedParamMap.putAll(parameters);
		Iterator pairs = sortedParamMap.entrySet().iterator();
		while (pairs.hasNext()) {
			Map.Entry pair = (Map.Entry) pairs.next();

			if ("class".equals(pair.getKey())) {
				continue;
			}

			serializeString.append((String) pair.getKey());
			serializeString.append(equals);

			serializeString.append(StringUtils.defaultString((String) pair.getValue()));

			if (pairs.hasNext()) {
				serializeString.append(and);
			}
		}
		return serializeString.toString();
	}

	public static String parseMapToStringByUrlEncode(Map<String, String> parameters) throws Exception {
		return parseMapToStringByUrlEncode(parameters, "&", "=");
	}

	public static String parseMapToStringByUrlEncode(Map<String, String> parameters, String and) throws Exception {
		return parseMapToStringByUrlEncode(parameters, and, "=");
	}

	public static String parseMapToStringByUrlEncode(Map<String, String> parameters, String and, String equals)
			throws Exception {
		StringBuffer serializeString = new StringBuffer("");

		Map sortedParamMap = new TreeMap();
		sortedParamMap.putAll(parameters);
		Iterator pairs = sortedParamMap.entrySet().iterator();
		while (pairs.hasNext()) {
			Map.Entry pair = (Map.Entry) pairs.next();

			if ("class".equals(pair.getKey())) {
				continue;
			}

			serializeString.append((String) pair.getKey());
			serializeString.append(equals);
			try {
				serializeString.append(URLEncoder.encode((String) pair.getValue(), "UTF-8"));
			} catch (Exception localException) {
			}

			if (pairs.hasNext()) {
				serializeString.append(and);
			}
		}
		return serializeString.toString();
	}

	public static String removeEmpty(String parameters) throws Exception {
		return removeEmpty(parameters, "&", "=");
	}

	public static String removeEmpty(String parameters, String and) throws Exception {
		return removeEmpty(parameters, and, "=");
	}

	public static String removeEmpty(String parameters, String and, String equals) throws Exception {
		Map hash = new Hashtable();
		StringTokenizer token = new StringTokenizer(parameters, and);
		String temp = "";

		while (token.hasMoreElements()) {
			try {
				temp = token.nextToken();

				if (!"".equals(StringUtils.defaultString(temp.substring(temp.indexOf(equals) + 1)))) {
					hash.put(temp.substring(0, temp.indexOf(equals)), temp.substring(temp.indexOf(equals) + 1));
				}
			} catch (IndexOutOfBoundsException localIndexOutOfBoundsException) {
			}
		}
		parameters = parseMapToString(hash, and, equals);

		return parameters;
	}

	public static Map<String, String> removeEmpty(Map<String, String> parameters) {
		Set<String> set = parameters.keySet();

		for (String key : set) {
			if ("".equals(StringUtils.defaultString((String) parameters.get(key)))) {
				parameters.remove(key);
			}
		}

		return parameters;
	}
}