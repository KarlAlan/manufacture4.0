package com.rcstc.util;

import java.util.Random;

/**
 * Create: karl
 * Date: 14-12-20
 */
public class PasswordCreator {
    public static class GeneratedPassword {
        private String clearText;

        private GeneratedPassword(String clearText) {
            this.clearText = clearText;
        }

        public String getClearText() {
            return clearText;
        }

    }
    //the below number 13,58,74 you can change any number for you company.
    public static GeneratedPassword generate(int length) {
        Random rnd = new Random(System.currentTimeMillis());
        int letterLength = length - 1;
        byte[] buf = new byte[letterLength];
        for (int i = 0; i < letterLength; ++i) {
            int idx = Math.abs(rnd.nextInt()) % 13;
            int offset = idx % 2 == 1 ? 58 : 74;
            int ch = offset + idx;
            buf[i] = (byte) ch;
        }
        String clearText = insertRandomNumber(buf);

        return new GeneratedPassword(clearText);
    }
    //the below number 9, you can change any number for you company.
    private static String insertRandomNumber(byte[] buf) {
        StringBuffer sb = new StringBuffer(new String(buf));
        Random rnd = new Random(System.currentTimeMillis());
        int number = Math.abs(rnd.nextInt()) % 9;
        int offset = Math.abs(rnd.nextInt()) % (sb.length());
        sb.insert(offset, number);
        return sb.toString();
    }
}
