package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bd.daos.Emails;
import bd.dbos.Email;
import util.GerenciadorEmail;

/**
 * Servlet implementation class NOVACONTA
 */
@WebServlet("/NOVACONTA")
public class NOVACONTA extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NOVACONTA() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String endereco = (String)request.getParameter("enderecoC");
        String senha    = (String)request.getParameter("senhaC");
        String host     = (String)request.getParameter("hostC");
        String porta    = (String)request.getParameter("portaC");
        String mode     = (String)request.getParameter("modeC");
        String hub      = (String)request.getParameter("hubC");
        
        try {
        	//GerenciadorEmail a = new GerenciadorEmail(endereco, senha);
        	//a.setStore(host, mode);
        	
        } catch (Exception e)
        {        	
        	//request.setAttribute("autenticacaoInvalida", true);
        	//RequestDispatcher dispatcher = request.getRequestDispatcher("Index.jsp");
        	//dispatcher.forward( request, response);
        	System.err.println(e.getMessage());
        	return;
        }
        
        Email email = null;
        
        try {
        email = new Email(Integer.parseInt(hub), endereco, senha, host, porta, mode);
        Emails.incluir(email);
        } catch (Exception e) {
        	System.err.println(e.getMessage());
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
