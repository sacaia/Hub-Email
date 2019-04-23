package bd.daos;

import java.sql.*;
import java.util.ArrayList;

import bd.*;
import bd.core.*;
import bd.dbos.*;

public class Emails
{

    public static boolean cadastrado (int idEmail) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM Email " +
                  "WHERE idEmail = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt(1, idEmail);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first(); // pode-se usar resultado.last() ou resultado.next() ou resultado.previous() ou resultado.absotule(numeroDaLinha)

            /* // ou, se preferirmos,

            String sql;

            sql = "SELECT COUNT(*) AS QUANTOS " +
                  "FROM ALUNO " +
                  "WHERE CODIGO = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, codigo);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            resultado.first();

            retorno = resultado.getInt("QUANTOS") != 0;

            */
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar Email");
        }

        return retorno;
    }

    public static void incluir (Email email) throws Exception
    {
        if (email==null)
            throw new Exception ("Aluno nao fornecido");

        try
        {
            String sql;

            sql = "INSERT INTO Email " +
                  "(idEmail,idHub,endereco, senha) " +
                  "VALUES " +
                  "(?, ?, ?, ?)";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt    (1, email.getIdEmail() );
            BDSQLServer.COMANDO.setInt    (2, email.getIdHub() );
            BDSQLServer.COMANDO.setString (3, email.getEndereco() );
            BDSQLServer.COMANDO.setString (4, email.getSenha() );

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir email");
        }
    }

    public static void excluir (int idEmail) throws Exception
    {
        if (!cadastrado (idEmail))
            throw new Exception ("Email não cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM Email " +
                  "WHERE idEmail = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, idEmail);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir email");
        }
    }

    public static void alterar (Email email) throws Exception
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getIdEmail() ))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET idHub = ?" +
                  ", endereco = ?" +
                  ", senha = ?" +
                  "WHERE idEmail = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setInt    (1, email.getIdHub() );
            BDSQLServer.COMANDO.setString (2, email.getEndereco() );
            BDSQLServer.COMANDO.setString (3, email.getSenha() );
            BDSQLServer.COMANDO.setInt    (4, email.getIdEmail() );

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar dados do email");
        }
    }
/////////////////// parei aqui ////////////////////
    public static Aluno getAluno (int ra) throws Exception
    {
        if (novoRA > 99999 || novoRA < 10000)
            throw new Exception ("RA invalido");

        String ra2 = "" + novoRA;

        return getAluno(ra2);
    }

    public static Aluno getAluno (String ra) throws Exception
    {
        Aluno aluno = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM ALUNO " +
                  "WHERE RA = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, ra);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            aluno = new Aluno (resultado.getString("RA"),
                               resultado.getString("NOME"),
                               resultado.getString("EMAIL"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar aluno");
        }

        return aluno;
    }

    public static MeuResultSet getAlunos () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM ALUNO";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar Alunos");
        }

        return resultado;
    }
    
    public static Aluno[] listar() throws Exception
    {
    	Aluno[] Alunos = null;
        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM ALUNO ";

            BDSQLServer.COMANDO.prepareStatement (sql);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao existem Alunos cadastrados");
            
            ArrayList<Aluno> lista = new ArrayList<Aluno>();
            int i=0;
            
            do
            {
            	lista.add(new Aluno(resultado.getString("RA"), resultado.getString("NOME"), resultado.getString("EMAIL")));
            	i++;
            }while(resultado.next() == true);
            	
            Alunos = new Aluno[i];
            for(int j=0; j<i; j++)
            {
            	Alunos[j] = lista.get(j);
            }
			
	    }
	    catch (SQLException erro)
	    {
	    	erro.printStackTrace();
	        throw new Exception ("Erro ao recuperar Alunos");
	    }
        
        return Alunos;
    }
}