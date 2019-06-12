import util.GerenciadorEmail;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
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
import java.util.Properties;

public class Testes {

	public static void main(String[] args) {
		
		GerenciadorEmail ge = new GerenciadorEmail("MedicosOnlinePR3@gmail.com", "PR317178");
		
		String[] dest = new String[10];
		dest[0] = "cc17189@g.unicamp.br";
		
		try {
			ge.setSenderSession("587", "smtp.gmail.com");
			
			ge.enviarEmail("assunto muito interesante", "um texto ai", null, dest, null, null);
			
			System.out.println("foi");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("n foi");
		}/*
		try {
			String remetente = "MedicosOnlinePR3@gmail.com";
			String password = "PR317178";
	
			String host = "smtp.gmail.com";
			Properties propri = new Properties();
			propri.put("mail.smtp.auth", "true");
			propri.put("mail.smtp.starttls.enable", "true");
			propri.put("mail.smtp.host", host);
			propri.put("mail.smtp.port", "587");
			Session sessao =
			Session.getInstance(propri, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication()
				{
					return new PasswordAuthentication(remetente, password);
				}
			});
			
			Message msg = new MimeMessage(sessao);
			msg.setFrom(new InternetAddress(remetente));
			
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse("cc17189@g.unicamp.br"));
			
			msg.setSubject("Título do email com o JavaMail");
			BodyPart msgBodyPart = new MimeBodyPart();
			msgBodyPart.setText("Coloque o texto do email aqui!");
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(msgBodyPart);
			msgBodyPart = new MimeBodyPart();
			String fileLocal = "C:/Temp/arq.txt";
			DataSource source = new FileDataSource(fileLocal);
			msgBodyPart.setDataHandler(new DataHandler(source));
			msgBodyPart.setFileName("arq.txt");
			multipart.addBodyPart(msgBodyPart);
			
			msg.setContent(multipart);
			Transport.send(msg);
			
		}catch (Exception e) {
			System.out.println("aaaa");
			e.printStackTrace();
			// TODO: handle exception
		}*/
		
	}
}
