import java.util.ArrayList;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


public class GerenciadorEmail {
	
	private String user;
	private String senha;
	private Session senderSession;
	private Store emailStore;
	
	public GerenciadorEmail(String usuario, String senha) throws Exception
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
	
	public void setSenderSession(String porta, String host)
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
		
		this.senderSession = sessao;
	}
	
	protected void setStore(String host, String mode) throws Exception
	{
		if(host == null || host.equals("") || user == null || user.equals("") || senha == null || senha.equals(""))
			throw new Exception ("Algum dos parâmetros esta vazio");
		
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
			for(Message msg:fd.getMessages())
				ret.add(msg);	
		
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
			throw new Exception ("Pasta não pode ser renomeada por não existir");
		
		if(pasta.isOpen())
			pasta.close();
		
		pasta.renameTo(emailStore.getFolder(nova));
	}
	
	public void deletarPasta(String nomePasta) throws Exception
	{
		Folder pasta = emailStore.getFolder(nomePasta);
		
		if(!pasta.exists())
			throw new Exception ("Pasta não pode ser renomeada por não existir");
		
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
}
