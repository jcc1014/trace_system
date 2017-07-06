package com.utils;

import java.security.SecureRandom;
import java.util.UUID;

/**
 *  A <code>UUIDFactory</code> generates a UUID
 * @Description
 * @ClassName UUIDFactory
 * @author 王莹
 * @Created 2013 2013-10-25 上午11:05:18
 */
public class UUIDFactory {
    /**
     * random number generator for UUID generation
     */
    private final SecureRandom secRand = new SecureRandom();

    /**
     * 	128-bit buffer for use with secRand
     */
    private final byte[] secRandBuf16 = new byte[16];

    /**
     * 64-bit buffer for use with secRand
     */
    private final byte[] secRandBuf8 = new byte[8];

    /**
     * @link
     * @shapeType PatternLink
     * @pattern Singleton
     * @supplierRole Singleton factory 
     */
    /*# private UUIDFactory _uuidFactory; */
    private static UUIDFactory instance = null;

    protected UUIDFactory() {
    }

    public String newUUID() {
        secRand.nextBytes(secRandBuf16);
        secRandBuf16[6] &= 0x0f;
        secRandBuf16[6] |= 0x40; /* version 4 */
        secRandBuf16[8] &= 0x3f;
        secRandBuf16[8] |= 0x80; /* IETF variant */
        secRandBuf16[10] |= 0x80; /* multicast bit */
        long mostSig = 0;
        for (int i = 0; i < 8; i++) {
            mostSig = (mostSig << 8) | (secRandBuf16[i] & 0xff);
        }
        long leastSig = 0;
        for (int i = 8; i < 16; i++) {
            leastSig = (leastSig << 8) | (secRandBuf16[i] & 0xff);
        }
        UUID uuid = new UUID(mostSig, leastSig);
        return uuid.toString().replace("-", "");
    }
	
	public boolean isValidUUID(String uuid) {
		boolean isValid = true;

		//57d925e0-7ad2-4dc3-ace1-b8a4064abcc7
		//012345678901234567890123456789012345
		int len = uuid.length();
		String hexDigits = "0123456789abcdef";
		
		for (int i=0; i<len; i++) {
			char c = uuid.charAt(i);
			if ((i==8) || (i==13) || (i==18) || (i==23)) {
				if (c != '-') {
					isValid = false;
					break;
				}
			}
			else {
				if (hexDigits.indexOf(c) == -1) {
					isValid = false;
					break;
				}									
			}
		}

		return isValid;
	}
	
	public static void main(String[] args) {
		UUIDFactory uf = UUIDFactory.getInstance();

		String id = uf.newUUID();
		System.out.println( "new UUID : " + id.toString() );
	}

    public static UUIDFactory getInstance(){
            if (instance == null) {
                synchronized(UUIDFactory.class) {
                    if (instance == null) {
                        instance = new UUIDFactory();
                    }
                }
            }
            return instance;
        }

	public byte[] getSecRandBuf8() {
		return secRandBuf8;
	}
}
