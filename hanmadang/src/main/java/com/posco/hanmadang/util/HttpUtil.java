package com.posco.hanmadang.util;

import java.util.Iterator;
import java.util.Map;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HostConfiguration;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

public class HttpUtil {
	private HttpClient client;
	private PostMethod postMethod;
	private HostConfiguration hostConf;
	private static int CONNECTION_TIMEOUT = 5000;

	private static int RECEIVE_TIMEOUT = 25000;

	public String processHTTP(Map request, String actionURL) throws Exception {
		int statusCode = 0;
		String result = null;
		try {
			this.hostConf = new HostConfiguration();
			this.client = new HttpClient();
			this.client.getHttpConnectionManager().getParams().setConnectionTimeout(CONNECTION_TIMEOUT);
			this.client.getHttpConnectionManager().getParams().setSoTimeout(RECEIVE_TIMEOUT);

			this.postMethod = new PostMethod(actionURL);
			this.postMethod.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded; text/html; charset=euc-kr");
			this.postMethod.setRequestHeader("Cache-Control", "no-cache");

			this.hostConf.setHost(this.postMethod.getURI().getHost(), this.postMethod.getURI().getPort());

			NameValuePair[] params = makeParam(request);

			this.postMethod.setRequestBody(params);
			try {
				statusCode = this.client.executeMethod(this.postMethod);
			} catch (Exception ex) {
				System.out.println("서버응답 에러 / " + statusCode);
				ex.printStackTrace();
				throw ex;
			}

			for (Header header : this.postMethod.getResponseHeaders()) {
			}

			if (statusCode == 200) {
				result = this.postMethod.getResponseBodyAsString();

				return result.trim();
			}

			System.out.println("서버응답 에러 / " + statusCode);
			throw new HttpException("서버응답 에러 / " + statusCode);
		} catch (Exception ex) {
			ex.printStackTrace();

			throw ex;
		} finally {
			try {
				if (this.postMethod != null) {
					this.postMethod.releaseConnection();
				}

			} catch (Exception ex) {
				this.postMethod = null;
			}

			try {
				if (this.client != null) {
					this.client.getHttpConnectionManager().getConnection(this.hostConf).close();
				}
			} catch (Exception localException2) {
			}
		}
//		throw localObject;
	}

	public NameValuePair[] makeParam(Map request) throws Exception {
		int hashSize = request.size();

		Iterator keyset = request.keySet().iterator();
		NameValuePair[] params = new NameValuePair[hashSize];

		String key = "";

		for (int i = 0; i < hashSize; i++) {
			key = (String) keyset.next();

			params[i] = new NameValuePair(key, new String(((String) request.get(key)).getBytes(), "KSC5601"));
		}

		return params;
	}
}