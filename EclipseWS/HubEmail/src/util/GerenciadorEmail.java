package util;

import java.util.ArrayList;
import java.util.Properties;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.io.File;

import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;


public class GerenciadorEmail {
	
	private String user;
	private String senha;
	private Session senderSession;
	private Store emailStore;
	
	public GerenciadorEmail(String usuario, String senha)
	{
		this.user = usuario;
		this.senha = senha;
		this.senderSession = null;
		this.emailStore = null;
	}
	
	public GerenciadorEmail()
	{
		this.user = null;
		this.senha = null;
		this.senderSession = null;
		this.emailStore = null;
	}
	

	public boolean senderNull()
	{
		if(senderSession == null)
			return true;
					
		return false;
	}
	

	public void setSenderSession(String porta, String host) throws Exception
	{
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
		
		if (!ehValido(sessao))
			throw new Exception("Sessao invalida");
		
		
		this.senderSession = sessao;
	}
	
	private boolean ehValido (Session sessao)
	{
		try {
			Transport transport = sessao.getTransport();
		    transport.connect();
		    transport.close();
		}
		catch (Exception erro)
		{
			return false;
		}
		
		return true;
	}
	
	public void setStore(String host, String mode) throws Exception
	{
		if(host == null || host.equals("") || user == null || user.equals("") || senha == null || senha.equals(""))
			throw new Exception ("Algum dos par�metros esta vazio");
		
		Properties props = System.getProperties();
		Session session = Session.getDefaultInstance(props);
		Store store = session.getStore(mode);
		
		store.connect(host, user, senha);
		this.emailStore = store;
	}
	
	public ArrayList<Message> receive() throws Exception
	{		
		Folder[] f = emailStore.getDefaultFolder().list();
		
		ArrayList<Message> ret = new ArrayList<>();
		
		for(Folder fd:f)
		{
			try {
			fd.open(Folder.READ_ONLY);
			for(Message msg:fd.getMessages())
				ret.add(msg);
			}
			catch (Exception erro)
			{
				
			}
		}
		
		return ret;
	}
	
	public ArrayList<Message> receive(String nomePasta) throws Exception
	{		
		Folder[] f = emailStore.getDefaultFolder().list();
		
		ArrayList<Message> ret = new ArrayList<>();
		
		for(Folder fd:f)
			if(fd.getName().equals(nomePasta))
				for(Message msg:fd.getMessages())
					ret.add(msg);	
		
		return ret;
	}
	
	public void criarPasta(String nome) throws Exception {
		Folder minhaPasta = emailStore.getFolder(nome);
		
		if (!minhaPasta.exists())
			if (minhaPasta.create(Folder.HOLDS_MESSAGES))
				minhaPasta.setSubscribed(true);
	}
	
	public void renomearPasta(String original, String nova) throws Exception
	{		
		Folder pasta = emailStore.getFolder(original);
		
		if(!pasta.exists())
			throw new Exception ("Pasta n�o pode ser renomeada por n�o existir");
		
		if(pasta.isOpen())
			pasta.close();
		
		pasta.renameTo(emailStore.getFolder(nova));
	}
	
	public void deletarPasta(String nomePasta) throws Exception
	{
		Folder pasta = emailStore.getFolder(nomePasta);
		
		if(!pasta.exists())
			throw new Exception ("Pasta n�o pode ser renomeada por n�o existir");
		
		if(pasta.isOpen())
			pasta.close();
		
		pasta.delete(true);
	}
	
	public ArrayList<String> listarPastas(String mode) throws MessagingException
	{
		Folder[] f = emailStore.getDefaultFolder().list();
		
		ArrayList<String> ret = new ArrayList<>();
		for(Folder fd:f)
			ret.add(fd.getName());
		
		return ret;
	}
	
	public Folder[] getFolders()
	{
		
		Folder[] f = null;
		try {
			f = emailStore.getDefaultFolder().list();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return f;
	}
	
	public void enviarEmailHTML(String assunto, String textoMensagem, String[] anexos, String[] destinatarios, String[] CCs, String[] CCOs) throws MessagingException, UnsupportedEncodingException
	{
		MimeMessage msg = new MimeMessage(senderSession);
		
		msg.addHeader("Content-type", "text/HTML;charset=UTF-8");
		msg.addHeader("format", "flowed");
		msg.addHeader("Content-Transfer-Encoding", "8bit");
		
		msg.setFrom(new InternetAddress (this.user));
		msg.setSubject(assunto, "UTF-8");
		msg.setSentDate(new Date());
		
		for(int i = 0; i < destinatarios.length; i++)
		{
			msg.addRecipient(Message.RecipientType.TO,
			InternetAddress.parse(destinatarios[i])[0]);
		}
		
		if(CCs != null)
			for(int i = 0; i < CCs.length; i++)
			{
				msg.addRecipient(
				Message.RecipientType.CC, InternetAddress.parse(CCs[i])[0]);
			}

		if(CCOs != null)
			for(int i = 0; i < CCOs.length; i++)
			{
				msg.addRecipient(
				Message.RecipientType.BCC, InternetAddress.parse(CCOs[i])[0]);
			}
		
		Multipart multipart = new MimeMultipart();
		
		MimeBodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setText(textoMensagem, "UTF-8", "html");
		
		multipart.addBodyPart(messageBodyPart);
		
		if(anexos != null)
			for(int i = 0; i < anexos.length; i++)
			{
				MimeBodyPart attachmentBodyPart = new MimeBodyPart();
				DataSource source = new FileDataSource(anexos[i]);
				attachmentBodyPart.setDataHandler(new DataHandler(source));
				attachmentBodyPart.setFileName(new File(anexos[i]).getName());
				multipart.addBodyPart(attachmentBodyPart);
			}	
		
		msg.setContent(multipart);
		
		Transport.send(msg);
	}
	
	public void enviarEmail(String assunto, String textoMensagem, String[] anexos, String[] destinatarios, String[] CCs, String[] CCOs) throws MessagingException, UnsupportedEncodingException
	{
		Message msg = new MimeMessage(this.senderSession);
		msg.setFrom(new InternetAddress(this.user));
		
		for(int i = 0; i < destinatarios.length; i++)
		{
			msg.addRecipient(Message.RecipientType.TO,
			InternetAddress.parse(destinatarios[i])[0]);
		}
		
		if(CCs != null)
			for(int i = 0; i < CCs.length; i++)
			{
				msg.addRecipient(
				Message.RecipientType.CC, InternetAddress.parse(CCs[i])[0]);
			}

		if(CCOs != null)
			for(int i = 0; i < CCOs.length; i++)
			{
				msg.addRecipient(
				Message.RecipientType.BCC, InternetAddress.parse(CCOs[i])[0]);
			}
		
		msg.setSubject(assunto);
		BodyPart msgBodyPart = new MimeBodyPart();
		msgBodyPart.setText(textoMensagem);
		
		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(msgBodyPart);
		
		if(anexos != null)
			for(int i = 0; i < anexos.length; i++)
			{
				MimeBodyPart attachmentBodyPart = new MimeBodyPart();
				DataSource source = new FileDataSource(anexos[i]);
				attachmentBodyPart.setDataHandler(new DataHandler(source));
				attachmentBodyPart.setFileName(new File(anexos[i]).getName());
				multipart.addBodyPart(attachmentBodyPart);
			}	
		
		msg.setContent(multipart);
		
		Transport.send(msg);
	}
	
	public void closeStore()
	{
		try {
			this.emailStore.close();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
