package servlets;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import bd.daos.Hubs;
import bd.dbos.Hub;

/**
 * Servlet implementation class LOGAR
 */
@WebServlet("/LOGAR")
public class LOGAR extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LOGAR() {
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
        
        try {
        	MessageDigest encrypt = MessageDigest.getInstance("MD5");
    		encrypt.update(senha.getBytes());
    		byte[] digest = encrypt.digest();
    		senha = DatatypeConverter.printHexBinary(digest);

    		Hub h = Hubs.getHub(usuario, senha);
    		request.setAttribute("logado", true);
            request.setAttribute("hub", h);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Index.jsp");
            dispatcher.forward( request, response);
          
        }
        catch(Exception e)
        {
        	//e.printStackTrace();
        	System.err.println(e.getMessage());
        	response.sendRedirect("Login.jsp");
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
