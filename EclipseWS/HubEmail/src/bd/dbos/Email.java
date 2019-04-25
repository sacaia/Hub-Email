package bd.dbos;

public class Email implements Cloneable
{
    private int idEmail;
    private int idHub;
    private String endereco;
    private String senha;
 
    public void setIdEmail (int novoIdEmail) throws Exception
    {
    	if (novoIdEmail < 0)
            throw new Exception ("id invalido");

        this.idEmail = novoIdEmail;
    }
    
    public void setIdHub (int novoIdHub) throws Exception
    {
        if (novoIdHub < 0)
            throw new Exception ("id invalido");

        this.idHub = novoIdHub;
    }

    public void setEndereco (String novoEndereco) throws Exception
    {
        if (novoEndereco==null || novoEndereco.equals(""))
            throw new Exception ("Endere�o nao fornecido");

        this.endereco = novoEndereco;
    }

    public void setSenha (String novaSenha) throws Exception
    {
        if (novaSenha==null || novaSenha.equals(""))
            throw new Exception ("Senha nao fornecida");

        this.senha = novaSenha;
    }

    public int getIdEmail ()
    {
        return this.idEmail;
    }

    public int getIdHub ()
    {
        return this.idHub;
    }

    public String getEndereco ()
    {
        return this.endereco;
    }

    public String getSenha ()
    {
        return this.senha;
    }

    public Email (int idEmail, int idHub, String endereco, String senha) throws Exception
    {
        this.setIdEmail  (idEmail);
        this.setIdHub    (idHub);
        this.setEndereco (endereco);
        this.setSenha    (senha);
    }

    public String toString ()
    {
        String ret="";

        ret+="idEmail.: "+this.idEmail  +"\n";
        ret+="idHub...: "+this.idHub    +"\n";
        ret+="endereco: "+this.endereco +"\n";
        ret+="senha...: "+this.senha;

        return ret;
    }

    public boolean equals (Object obj)
    {
        if (this==obj)
            return true;

        if (obj==null)
            return false;

        if (!(obj instanceof Email))
            return false;

        Email em = (Email)obj;

        if (this.idEmail != em.idEmail)
            return false;

        if (this.idHub != em.idHub)
            return false;

        if (!this.endereco.equals(em.endereco))
            return false;
        
        if (!this.senha.equals(em.senha))
            return false;

        return true;
    }

    public int hashCode ()
    {
        int ret=666;

        ret = 7*ret + new Integer(this.idEmail).hashCode();
        ret = 7*ret + new Integer(this.idHub).hashCode();
        ret = 7*ret + this.endereco.hashCode();
        ret = 7*ret + this.senha.hashCode();

        return ret;
    }


    public Email (Email modelo) throws Exception
    {
        this.idEmail  = modelo.idEmail;  // nao clono, pq nao eh clonavel
        this.idHub    = modelo.idHub;    // nao clono, pq nao eh clonavel
        this.endereco = modelo.endereco; // nao clono, pq nao eh objeto
        this.senha    = modelo.senha;    // nao clono, pq nao eh objeto
    }

    public Object clone ()
    {
        Email ret=null;

        try
        {
            ret = new Email (this);
        }
        catch (Exception erro)
        {} // nao trato, pq this nunca � null e construtor de
           // copia da excecao qdo seu parametro for null

        return ret;
    }
}