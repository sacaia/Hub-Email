import java.util.ArrayList;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class Email {
	protected static Store getStore(String host, String user, String password, String mode) throws Exception
	{
		if(host == null || host.equals("") || user == null || user.equals("") || password == null || password.equals(""))
			throw new Exception ("Algum dos parâmetros esta vazio");
		
		Properties props = System.getProperties();
		Session session = Session.getDefaultInstance(props);
		Store store = session.getStore(mode);
		
		store.connect(host, user, password);
		return store;
	}
	
	public static final ArrayList<Message> receive(Store minhaStore) throws Exception
	{		
		Folder[] f = minhaStore.getDefaultFolder().list();
		
		ArrayList<Message> ret = new ArrayList<>();
		
		for(Folder fd:f)
			for(Message msg:fd.getMessages())
				ret.add(msg);	
		
		return ret;
	}
	
	public static final ArrayList<Message> receive(Store minhaStore, String nomePasta) throws Exception
	{		
		Folder[] f = minhaStore.getDefaultFolder().list();
		
		ArrayList<Message> ret = new ArrayList<>();
		
		for(Folder fd:f)
			if(fd.getName().equals(nomePasta))
				for(Message msg:fd.getMessages())
					ret.add(msg);	
		
		return ret;
	}
	
	public static final void criarPasta(Store minhaStore, String nome) throws Exception {
		Folder minhaPasta = minhaStore.getFolder(nome);
		
		if (!minhaPasta.exists())
			if (minhaPasta.create(Folder.HOLDS_MESSAGES))
				minhaPasta.setSubscribed(true);
	}
	
	public static final void renomearPasta(Store minhaStore, String original, String nova) throws Exception
	{		
		Folder pasta = minhaStore.getFolder(original);
		
		if(!pasta.exists())
			throw new Exception ("Pasta não pode ser renomeada por não existir");
		
		if(pasta.isOpen())
			pasta.close();
		
		pasta.renameTo(minhaStore.getFolder(nova));
	}
	
	public static final void deletarPasta(Store minhaStore, String original, String nova) throws Exception
	{
		Folder pasta = minhaStore.getFolder(original);
		
		if(!pasta.exists())
			throw new Exception ("Pasta não pode ser renomeada por não existir");
		
		if(pasta.isOpen())
			pasta.close();
		
		pasta.delete(true);
	}
	
	public static final ArrayList<String> listarPastas(Store minhaStore, String mode) throws MessagingException
	{
		Folder[] f = minhaStore.getDefaultFolder().list();
		
		ArrayList<String> ret = new ArrayList<>();
		for(Folder fd:f)
			ret.add(fd.getName());
		
		return ret;
	}
}
