package net.xunzhenji.util

import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

/**
 * �����Ǽ����㷨
 * @blog www.yl-blog.com
 * @weibo http://t.qq.com/wuweiit
 * */
public class MySecurity {

	
	public static final String SHA_1 = "SHA-1";
	
	public static final String MD5 = "MD5";

	public static String encode(String strSrc, String encodeType) {
		MessageDigest md = null;
		String strDes = null;
		byte[] bt = strSrc.getBytes();
		try {
			if (encodeType == null || "".equals(encodeType))
				encodeType = MD5;//Ĭ��ʹ��MD5
			md = MessageDigest.getInstance(encodeType);
			md.update(bt);
			strDes = bytes2Hex(md.digest());
		} catch (NoSuchAlgorithmException e) {
			return strSrc;
		}
		return strDes;
	}

	public static String bytes2Hex(byte[] bts) {
		String des = "";
		String tmp = null;
		for (int i = 0; i < bts.length; i++) {
			tmp = (Integer.toHexString(bts[i] & 0xFF));
			if (tmp.length() == 1) {
				des += "0";
			}
			des += tmp;
		}
		return des;
	}

	public static void main(String[] args) {
		MySecurity te = new MySecurity();
		String strSrc = "���Լ��ܺ���";
		System.out.println("Source String:" + strSrc);
		System.out.println("Encrypted String:");
		System.out.println("Use MD5:" + te.encode(strSrc, null));
		System.out.println("Use MD5:" + te.encode(strSrc, "MD5"));
		System.out.println("Use SHA:" + te.encode(strSrc, "SHA-1"));
		System.out.println("Use SHA-256:" + te.encode(strSrc, "SHA-256"));
	}
}