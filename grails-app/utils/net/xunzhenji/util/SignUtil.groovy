package net.xunzhenji.util

import org.apache.commons.codec.digest.DigestUtils

import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

/**
 *
 * Created by: Kevin
 * Created time : 15-4-29 ����10:20
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */

public class SignUtil {

    private static String token = "weixintest";

    /**
     * ��֤ǩ��
     * @param signature
     * @param timestamp
     * @param nonce
     * @return
     */
    public static boolean checkSignature(String signature, String timestamp, String nonce){
        String[] arr = [token, timestamp, nonce];
        // �� token, timestamp, nonce �������������ֵ�����
        Arrays.sort(arr);
        StringBuilder content = new StringBuilder();
        for(int i = 0; i < arr.length; i++){
            content.append(arr[i]);
        }
        MessageDigest md = null;
        String tmpStr = null;

        try {
            md = MessageDigest.getInstance("SHA-1");
            byte[] digest = md.digest(content.toString().getBytes());
            tmpStr = byteToStr(digest);
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        content = null;
        return tmpStr != null ? tmpStr.equals(signature.toUpperCase()): false;
    }

    /**
     * ���ֽ�����ת��Ϊʮ�������ַ���
     * @param digest
     * @return
     */
    private static String byteToStr(byte[] digest) {
        // TODO Auto-generated method stub
        String strDigest = "";
        for(int i = 0; i < digest.length; i++){
            strDigest += byteToHexStr(digest[i]);
        }
        return strDigest;
    }

    /**
     * ���ֽ�ת��Ϊʮ�������ַ���
     * @param b
     * @return
     */
    private static String byteToHexStr(byte b) {
        // TODO Auto-generated method stub
        char[] Digit = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'];
        char[] tempArr = new char[2];
        tempArr[0] = Digit[(b >>> 4) & 0X0F];
        tempArr[1] = Digit[b & 0X0F];

        String s = new String(tempArr);
        return s;
    }

    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }

    public static String signWechatPayInfo(Map params, mchKey) {
        def keys = new TreeSet(params.keySet())
        StringBuilder sb = new StringBuilder()
        String signature = "";
        keys.each{ k->
            sb.append("${k}=${params[k]}&")
        }
        String str = sb.toString()+"key=${mchKey}"
        try
        {
            MessageDigest crypt = MessageDigest.getInstance("MD5");
            crypt.reset();
            crypt.update(str.getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }
        return signature.toUpperCase()
    }

    public static Map signAlipayPayInfo(Map params, key, signType) {
        def keys = new TreeSet(params.keySet())
        def keyArray = new ArrayList<String>()
        keys.each{ k->
            keyArray <<"${k}=${params[k]}"
        }
        String str = keyArray.join("&")+"${key}"
        println str
        String sign = DigestUtils.md5Hex(getContentBytes(str, "utf-8"));

        params.put("sign", sign);
        params.put("sign_type", signType);

        return params
    }

    /**
     * @param content
     * @param charset
     * @return
     * @throws java.security.SignatureException
     * @throws UnsupportedEncodingException
     */
    private static byte[] getContentBytes(String content, String charset) {
        if (charset == null || "".equals(charset)) {
            return content.getBytes();
        }
        try {
            return content.getBytes(charset);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("MD5签名过程中出现错误,指定的编码集不对,您目前指定的编码集是:" + charset);
        }
    }

    public static String signWechatPayInfo(Map params) {
        def keys = new TreeSet(params.keySet())
        StringBuilder sb = new StringBuilder()
        String signature = "";
        keys.each{ k->
            sb.append("${k}=${params[k]}&")
        }
        try
        {
            MessageDigest crypt = MessageDigest.getInstance("MD5");
            crypt.reset();
            crypt.update(sb.toString().getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }
        return signature.toUpperCase()
    }

    public static Map<String, String> sign(String jsapi_ticket, String url) {
        Map<String, String> ret = new HashMap<String, String>();
        def nonce_str = create_nonce_str();
        def timestamp = create_timestamp();

        String string1;
        String signature = "";
        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + jsapi_ticket +
                "&noncestr=" + nonce_str +
                "&timestamp=" + timestamp +
                "&url=" + url;
//        System.out.println(string1);
        try
        {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }
        ret.put("url", url);
        ret.put("jsapi_ticket", jsapi_ticket);
        ret.put("nonceStr", nonce_str);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);

        return ret;
    }

    public static String create_nonce_str() {
        return UUID.randomUUID().toString().replace('-','').substring(0,16);
    }

    public static String create_timestamp() {
        return Long.toString((System.currentTimeMillis() / 1000) as long);
    }

}