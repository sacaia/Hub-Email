package bd.daos;

import java.sql.*;
import java.util.ArrayList;

import bd.*;
import bd.core.*;
import bd.dbos.*;

public class Hubs
{

    public static boolean cadastrado (int idHub) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM Hub " +
                  "WHERE idHub = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt(1, idHub);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar hub");
        }

        return retorno;
    }
    
    public static boolean cadastrado (String username) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM Hub " +
                  "WHERE username = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, username);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first(); // pode-se usar resultado.last() ou resultado.next() ou resultado.previous() ou resultado.absotule(numeroDaLinha)

        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar hub");
        }

        return retorno;
    }

    public static void incluir (Hub hub) throws Exception
    {
    	if(cadastrado(hub.getUsername()))
    		throw new Exception("Username ja cadastrado");
    	
        if (hub==null)
            throw new Exception ("Hub nao fornecido");

        try
        {
            String sql;

            sql = "INSERT INTO Hub " +
                  "(username,senha) " +
                  "VALUES " +
                  "(?, ?)";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, hub.getUsername () );
            BDSQLServer.COMANDO.setString (2, hub.getSenha    () );

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir hub");
        }
    }

    public static void excluir (int idHub) throws Exception
    {
        if (!cadastrado (idHub))
            throw new Exception ("Hub não cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM Hub " +
                  "WHERE idHub = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, idHub);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir hub");
        }
    }

    public static void alterar (Hub hub) throws Exception
    {
        if (hub==null)
            throw new Exception ("Hub nao fornecido");

        if (!cadastrado (hub.getIdHub() ))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Hub " +
                  "SET username = ?" +
                  ", senha      = ?" +
                  "WHERE idHub  = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setString (1, hub.getUsername () );
            BDSQLServer.COMANDO.setString (2, hub.getSenha    () );

            BDSQLServer.COMANDO.setInt    (3, hub.getIdHub() );


            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar dados do hub");
        }
    }

    public static Hub getHub (int idHub) throws Exception
    {
        Hub hub = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM Hub " +
                  "WHERE idHub = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, idHub);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            hub = new Hub ( resultado.getInt("idHub"), 
            				resultado.getString("username"),
                            resultado.getString("senha"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar hub");
        }

        return hub;
    }
    
    public static Hub getHub(String usuario, String senha) throws Exception
    {
    	Hub hub = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM Hub " +
                  "WHERE username = ? AND senha = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);
            BDSQLServer.COMANDO.setString (2, senha);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            hub = new Hub ( resultado.getInt("idHub"), 
            				resultado.getString("username"),
                            resultado.getString("senha"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar hub");
        }

        return hub;
    }

    public static MeuResultSet getHubs () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM Hub";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar hubs");
        }

        return resultado;
    }
    
    public static Hub[] listar() throws Exception
    {
    	Hub[] hubs = null;
        try
        {
            /*
        	String sql;

            sql = "SELECT * " +
                  "FROM ALUNO ";

            BDSQLServer.COMANDO.prepareStatement (sql);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
			*/
        	MeuResultSet resultado = getHubs();
        	
            if (!resultado.first())
                throw new Exception ("Nao existem hubs cadastrados");
            
            ArrayList<Hub> lista = new ArrayList<Hub>();
            int i=0;
            
            do
            {
            	lista.add(new Hub(resultado.getInt("idHub"), resultado.getString("username"), resultado.getString("senha")));
            	i++;
            }while(resultado.next() == true);
            	
            hubs = new Hub[i];
            for(int j=0; j<i; j++)
            {
            	hubs[j] = lista.get(j);
            }
			
	    }
	    catch (SQLException erro)
	    {
	    	erro.printStackTrace();
	        throw new Exception ("Erro ao recuperar hubs");
	    }
        
        return hubs;
    }
    
    public static Email[] getEmails(Hub hub) throws Exception
    {
    	MeuResultSet resultado = null;
    	Email[] emails = null;
    	
        try
        {
            String sql;

            sql = "SELECT idEmail, endereco, senha, porta, protocolo " +
                  "FROM Email " +
                  "WHERE idHub = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setInt (1, hub.getIdHub() );

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
            
            if (!resultado.first())
                throw new Exception ("Nao cadastrado");
            
            ArrayList<Email> lista = new ArrayList<Email>();
            int i=0;
            
            do
            {
            	lista.add(new Email(resultado.getInt("idEmail"), hub.getIdHub(), resultado.getString("endereco"), resultado.getString("senha"), resultado.getString("porta"), resultado.getString("protocolo")));
            	i++;
            }while(resultado.next() == true);
            	
            emails = new Email[i];
            for(int j=0; j<i; j++)
            {
            	emails[j] = lista.get(j);
            }
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar emails do hub");
        }
    	
    	return emails;
    }
}