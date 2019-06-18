package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.GerenciadorEmail;

/**
 * Servlet implementation class MOVERPASTA
 */
@WebServlet("/MOVERPASTA")
public class MOVERPASTA extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MOVERPASTA() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String origem = (String)request.getParameter("origem");
        String destino = (String)request.getParameter("dest");
        String numEmail = (String)request.getParameter("numEmail");
        String user = (String)request.getParameter("user");
        String senha = (String)request.getParameter("senha");
        String host = (String)request.getParameter("host");
        String mode = (String)request.getParameter("mode");
        
        GerenciadorEmail ge = new GerenciadorEmail(user, senha);
        try {
			ge.setStore(host, mode);
			
			ge.moverParaPasta(origem, destino, Integer.parseInt(numEmail));
			
		} catch (Exception e) {
			e.printStackTrace();
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
