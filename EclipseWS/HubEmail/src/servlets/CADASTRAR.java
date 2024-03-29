package servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import bd.daos.Hubs;
import bd.dbos.Hub;

/**
 * Servlet implementation class CADASTRAR
 */
@WebServlet("/CADASTRAR")
public class CADASTRAR extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CADASTRAR() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String usuario = (String)request.getParameter("usuario");
        String senha = (String)request.getParameter("senha");
        String confirmarSenha = (String)request.getParameter("confirmarSenha");
        
        if(!senha.equals(confirmarSenha))
        {
        	request.setAttribute("senhasDiferentes", true);
        	RequestDispatcher dispatcher = request.getRequestDispatcher("Cadastro.jsp");
            dispatcher.forward( request, response);
        	//response.sendRedirect("Cadastro.jsp");
        	return;
        }
    	try {
    		if(Hubs.cadastrado(usuario))
    		{
    			request.setAttribute("UsuarioJaCadastrado", true);
    			RequestDispatcher dispatcher = request.getRequestDispatcher("Cadastro.jsp");
                dispatcher.forward( request, response);
            	//response.sendRedirect("Cadastro.jsp");
    			return;
    		}
    	}
        catch (Exception e)
    	{
			
		}
        try {
    		MessageDigest encrypt = MessageDigest.getInstance("MD5");
    		encrypt.update(senha.getBytes());
    		byte[] digest = encrypt.digest();
    		senha = DatatypeConverter.printHexBinary(digest);
        	
        	Hub hub = new Hub(usuario, senha);
        	Hubs.incluir(hub);
        	
        	Hub h = Hubs.getHub(usuario, senha);
            
            request.setAttribute("logado", true);
            request.setAttribute("hub", h);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Index.jsp");
            dispatcher.forward( request, response);
        }
        catch(Exception e)
        {
        	request.setAttribute("erro", e.getMessage());
        	RequestDispatcher dispatcher = request.getRequestDispatcher("Cadastro.jsp");
            dispatcher.forward( request, response);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
