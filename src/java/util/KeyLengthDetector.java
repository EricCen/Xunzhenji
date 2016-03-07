/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package util;

import javax.crypto.Cipher;
import java.security.NoSuchAlgorithmException;

/**
 * Created by Irene on 2015/8/6.
 */
public class KeyLengthDetector {
    public static void main(String[] args) {
        int allowedKeyLength = 0;

        try {
            allowedKeyLength = Cipher.getMaxAllowedKeyLength("AES");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        System.out.println("The allowed key length for AES is: " + allowedKeyLength);
    }
}
