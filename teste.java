
import java.security.*;

import javax.xml.bind.DatatypeConverter;

public class teste {
	
	public static void main(String[] args)
	{
	 	MessageDigest md;
		try 
		{
			md = MessageDigest.getInstance("MD5");
			md.update("BATATA".getBytes());
	        byte[] digest = md.digest();
	        String str = DatatypeConverter.printHexBinary(digest).toLowerCase();
	        
	        System.out.println(str);
		} catch (NoSuchAlgorithmException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}
	
}
