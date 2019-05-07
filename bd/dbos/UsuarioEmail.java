package bd.dbos;

import java.security.*;

import javax.xml.bind.DatatypeConverter;

public class UsuarioEmail implements Cloneable
{
    private String userName;
    private String senha;
 
    public void setUserName (String userName) throws Exception
    {
        if (userName == null || userName.equals(""))
            throw new Exception ("userName não dado");

        this.userName = userName;
    }   

    public void setSenha (String senha) throws Exception
    {
        if (senha==null || senha.equals(""))
            throw new Exception ("Nome nao fornecido");

        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(senha.getBytes());
        byte[] digest = md.digest();
        String str = DatatypeConverter.printHexBinary(digest).toLowerCase();
        
        this.senha = str;
    }

    public String getUserName ()
    {
        return this.userName;
    }

    public String getSenha ()
    {
        return this.senha;
    }

    public UsuarioEmail (String userName, String senha) throws Exception
    {
        this.setUserName(userName);
        this.setSenha   (senha);
    }

    public String toString ()
    {
        String ret="";

        ret+="Username: " + this.userName + "\n";
        ret+="Senha   : " + this.senha;
        
        return ret;
    }

    public boolean equals (Object obj)
    {
        if (this==obj)
            return true;

        if (obj==null)
            return false;

        if (!(obj instanceof UsuarioEmail))
            return false;

        UsuarioEmail usu = (UsuarioEmail)obj;

        if (!this.userName.equals(usu.userName))
            return false;

        if (!this.senha.equals(usu.senha))
            return false;

        return true;
    }

    public int hashCode ()
    {
        int ret=666;

        ret = 7*ret + this.userName.hashCode();
        ret = 7*ret + this.senha.hashCode();

        return ret;
    }


    public UsuarioEmail (UsuarioEmail modelo) throws Exception
    {
        this.userName = modelo.userName; // nao clono, pq nao eh objeto
        this.senha    = modelo.senha   ;   // nao clono, pq nao eh clonavel  // nao clono, pq nao eh objeto
    }

    public Object clone ()
    {
        UsuarioEmail ret = null;

        try
        {
            ret = new UsuarioEmail (this);
        }
        catch (Exception erro)
        {} // nao trato, pq this nunca é null e construtor de
           // copia da excecao qdo seu parametro for null

        return ret;
    }
}