package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.*;

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
        String endereco = (String)request.getParameter("enderecoH");
        String senha = (String)request.getParameter("senhaH");
        
        System.err.println("destinatario: "+ destinatario);
        System.err.println("cc: "+ cc);
        System.err.println("cco: "+ cco);
        System.err.println("assunto: "+ assunto);
        System.err.println("msg: "+ mensagem);
        System.err.println("anexo: "+ anexo);
        System.err.println("endereco: "+ endereco);
        System.err.println("senha: "+ senha);
        String[] aux = new String[0];
        String[] destinatarios;
        String[] CCs;
        String[] CCOs;
        
        if(destinatario.indexOf(",") != -1)
        {
	        aux = destinatario.split(",");
	        destinatarios = new String[aux.length];
	        
	        for(int i=0; i<destinatarios.length; i++)
	        {
	        	destinatarios[i] = aux[i].trim();
	        }
        } else {
        	destinatarios = new String[1];
        	destinatarios[0] = destinatario;
        }
        
        if(cc.indexOf(",") != -1)
        {
	        aux = cc.split(",");
	        CCs = new String[aux.length];
	        
	        for(int i=0; i<CCs.length; i++)
	        {
	        	CCs[i] = aux[i].trim();
	        }
        } else {
        	CCs = new String[1];
        	CCs[0] = cc;
        }
        
        if(cco.indexOf(",") != -1)
        {
	        aux = cco.split(",");
	        CCOs = new String[aux.length];
	        
	        for(int i=0; i<CCOs.length; i++)
	        {
	        	CCOs[i] = aux[i].trim();
	        }
        } else {
        	CCOs = new String[1];
        	CCOs[0] = cco;
        } 
        
        try {
			GerenciadorEmail ge = new GerenciadorEmail(endereco, senha);
			ge.setSenderSession("587", "smtp.gmail.com");
			ge.enviarEmail(assunto, mensagem, null, destinatarios, CCs, CCOs);
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
