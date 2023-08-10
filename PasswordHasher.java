package com.infinite.java;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordHasher {
    public static String hashPasswordWithMD5(String plainPassword) throws NoSuchAlgorithmException {
        MessageDigest messageDigest5 = MessageDigest.getInstance("MD5");
        messageDigest5.update(plainPassword.getBytes());
        byte[] hashBytes = messageDigest5.digest();
        StringBuilder hashString = new StringBuilder();
        for (int i = 0; i < hashBytes.length; i++) {
            hashString.append(Integer.toString((hashBytes[i] & 0xff) + 0x100, 16).substring(1));
        }
        return hashString.toString();
    }

    public static void main(String[] args) {
        String plaintextPassword = "hashedpassword";
        try {
            String hashedPassword = hashPasswordWithMD5(plaintextPassword);
            System.out.println(" password: " + hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Error hashing password: " + e.getMessage());
        }
    }
}
