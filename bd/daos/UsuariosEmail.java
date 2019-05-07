package bd.daos;

import java.sql.*;
import java.util.ArrayList;

import bd.*;
import bd.core.*;
import bd.dbos.*;

public class UsuariosEmail
{
    public static boolean cadastrado (String userName) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM usuarioEmail " +
                  "WHERE userName = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, userName);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first(); // pode-se usar resultado.last() ou resultado.next() ou resultado.previous() ou resultado.absotule(numeroDaLinha)

            /* // ou, se preferirmos,

            String sql;

            sql = "SELECT COUNT(*) AS QUANTOS " +
                  "FROM usuarioEmailS " +
                  "WHERE userName = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, userName);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            resultado.first();

            retorno = resultado.getString("QUANTOS") != 0;

            */
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar usuarioEmail");
        }

        return retorno;
    }

    public static void incluir (UsuarioEmail usuarioEmail) throws Exception
    {
        if (usuarioEmail==null)
            throw new Exception ("usuarioEmail nao fornecido");

        try
        {
            String sql;

            sql = "INSERT StringO usuarioEmailS " +
                  "(userName,senha) " +
                  "VALUES " +
                  "(?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString    (1, usuarioEmail.getUserName ());
            BDSQLServer.COMANDO.setString (2, usuarioEmail.getSenha ());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir usuarioEmail");
        }
    }

    public static void excluir (String userName) throws Exception
    {
        if (!cadastrado (userName))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM usuarioEmailS " +
                  "WHERE userName=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, userName);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir usuarioEmail");
        }
    }

    public static void alterar (UsuarioEmail usuarioEmail) throws Exception
    {
        if (usuarioEmail==null)
            throw new Exception ("usuarioEmail nao fornecido");

        if (!cadastrado (usuarioEmail.getUserName()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE usuarioEmailS " +
                  "SET senha=? " +
                  "WHERE userName = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuarioEmail.getSenha ());
            BDSQLServer.COMANDO.setString (2, usuarioEmail.getUserName ());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar dados de usuarioEmail");
        }
    }

    public static UsuarioEmail getusuarioEmail (String userName) throws Exception
    {
    	UsuarioEmail usuarioEmail = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM usuarioEmailS " +
                  "WHERE userName = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, userName);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            usuarioEmail = new UsuarioEmail (resultado.getString   ("userName"),
                               resultado.getString("senha"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar usuarioEmail");
        }

        return usuarioEmail;
    }

    public static MeuResultSet getusuarioEmails () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM usuarioEmailS";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar usuarioEmails");
        }

        return resultado;
    }
    
    public static UsuarioEmail[] getArrayusuarioEmails () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM usuarioEmailS";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar usuarioEmails");
        }
        
        if(!resultado.first())
        	throw new Exception ("Nao tem nada");
        
        ArrayList<UsuarioEmail> usuarioEmails = new ArrayList<UsuarioEmail>();
        
        do
        {
	        String    userName = resultado.getString("userName");
	        String senha   = resultado.getString("senha");
	        
	        usuarioEmails.add(new UsuarioEmail(userName, senha));
        }while(resultado.next());
        
        UsuarioEmail[] ret = new UsuarioEmail[usuarioEmails.size()];
        
        for(int i = 0; i < ret.length; i++)
        	ret[i] = usuarioEmails.get(i);
        
        return ret;
    }
}