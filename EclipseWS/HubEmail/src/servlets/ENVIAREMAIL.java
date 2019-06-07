package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ENVIAREMAIL
 */
@WebServlet("/ENVIAREMAIL")
public class ENVIAREMAIL extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ENVIAREMAIL() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String destinatario = (String)request.getParameter("destinatario");
        String cc = (String)request.getParameter("cc");
        String cco = (String)request.getParameter("cco");
        String assunto = (String)request.getParameter("assunto");
        String mensagem = (String)request.getParameter("mensagem");
        String anexo = (String)request.getParameter("anexo");
        /*
        System.err.println("destinatario: "+ destinatario);
        System.err.println("cc: "+ cc);
        System.err.println("cco: "+ cco);
        System.err.println("assunto: "+ assunto);
        System.err.println("msg: "+ mensagem);
        System.err.println("anexo: "+ anexo);
        */
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
