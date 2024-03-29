package bd.dbos;

public class Hub implements Cloneable
{
    private int idHub;
    private String username;
    private String senha;
    
    public void setIdHub (int novoIdHub) throws Exception
    {

        if (novoIdHub < 0)
            throw new Exception ("id invalido");

        this.idHub = novoIdHub;
    }

    public void setUsername (String novoUsername) throws Exception
    {
        if (novoUsername==null || novoUsername.equals(""))
            throw new Exception ("Username nao fornecido");

        this.username = novoUsername;
    }

    public void setSenha (String novaSenha) throws Exception
    {
        if (novaSenha==null || novaSenha.equals(""))
            throw new Exception ("Senha nao fornecida");

        this.senha = novaSenha;
    }

    public int getIdHub ()
    {
        return this.idHub;
    }

    public String getUsername ()
    {
        return this.username;
    }

    public String getSenha ()
    {
        return this.senha;
    }
    

    public Hub (int idHub, String username, String senha) throws Exception
    {
        this.setIdHub    (idHub);
        this.setUsername (username);
        this.setSenha    (senha);
    }
    
    public Hub (String username, String senha) throws Exception
    {
        this.setUsername (username);
        this.setSenha    (senha);
    }

    public String toString ()
    {
        String ret="";

        ret+="idHub...: "+this.idHub    +"\n";
        ret+="username: "+this.username +"\n";
        ret+="senha...: "+this.senha;

        return ret;
    }

    public boolean equals (Object obj)
    {
        if (this==obj)
            return true;

        if (obj==null)
            return false;

        if (!(obj instanceof Hub))
            return false;

        Hub hub = (Hub)obj;

        if (this.idHub != hub.idHub)
            return false;

        if (!this.username.equals(hub.username))
            return false;
        
        if (!this.senha.equals(hub.senha))
            return false;

        return true;
    }

    public int hashCode ()
    {
        int ret=666;
 
        ret = 7*ret + new Integer(this.idHub).hashCode();
        ret = 7*ret + this.username.hashCode();
        ret = 7*ret + this.senha.hashCode();

        return ret;
    }


    public Hub (Hub modelo) throws Exception
    {
        this.idHub    = modelo.idHub;    // nao clono, pq nao eh clonavel
        this.username = modelo.username; // nao clono, pq nao eh objeto
        this.senha    = modelo.senha;    // nao clono, pq nao eh objeto
    }

    public Object clone ()
    {
        Hub ret=null;

        try
        {
            ret = new Hub (this);
        }
        catch (Exception erro)
        {} // nao trato, pq this nunca � null e construtor de
           // copia da excecao qdo seu parametro for null

        return ret;
    }
}