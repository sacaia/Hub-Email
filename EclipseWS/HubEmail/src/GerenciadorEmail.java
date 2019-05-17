import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


public class GerenciadorEmail {
	private String porta;
	private String host;
	
	private String user;
	private String senha;
	
	public GerenciadorEmail(String porta, String host, String usuario, String senha) throws Exception
	{
		this.porta = porta;
		this.host = host;
		user = usuario;
		this.senha = senha;
		
		Properties propri = new Properties();
		propri.put("mail.smtp.auth", "true");
		propri.put("mail.smtp.starttls.enable", "true");
		propri.put("mail.smtp.host", host);
		propri.put("mail.smtp.port", porta);
		
		Session sessao = 
			Session.getInstance(propri, new javax.mail.Authenticator() {
			protected PasswordAuthentication 
			getPasswordAuthentication() 
			{
				return new PasswordAuthentication
				(user, senha);
			}
		});


	}
	
	
}
