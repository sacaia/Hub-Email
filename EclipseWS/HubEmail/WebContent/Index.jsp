<%@page import="java.nio.file.Files"%>
<%@ page language="java" 
	contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    session="true"
    import="bd.dbos.*,
     bd.daos.*,
      util.*,
       java.util.ArrayList,
       java.io.File,
       java.util.Arrays,
       org.jsoup.Jsoup,
       javax.mail.*,
       javax.mail.internet.*,
       com.google.gson.Gson"%>
<!DOCTYPE html>
<html>
<head>
    
<!-- Required meta tags -->
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="js/jquery.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.bundle.js"></script>

<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    
<!-- My CSS -->
    <link rel="stylesheet" href="css/style.css">

<!-- Fontawesome CSS -->
    <link rel="stylesheet" href="fontawesome-free-5.8.1-web/css/all.css">
    
	<title>MALI MAIL</title>
<%
	Gson gson = new Gson();

	/*Setando as Sessions*/
	Boolean recharge = false;
	if(request.getAttribute("recharge") != null && (Boolean)request.getAttribute("recharge"))
	{
		recharge = true;
		request.setAttribute("recharge", false);
	}
	
	if(request.getAttribute("logado") != null)
	{
		session.setAttribute("logado", true);
		if(((boolean)session.getAttribute("logado")) == false)
			response.sendRedirect("Login.jsp");
	}

	if(request.getAttribute("hub") != null)
		session.setAttribute("hub", request.getAttribute("hub"));

	if(session.getAttribute("hub") == null)
		response.sendRedirect("Login.jsp");
	
	if(session.getAttribute("logado") == null)
		response.sendRedirect("Login.jsp");

	if(session.getAttribute("logado") != null)
		if(!(boolean)session.getAttribute("logado"))
			response.sendRedirect("Login.jsp");
		
	if(request.getParameter("selectedFolder") != null)
	{
		session.setAttribute("selectedFolder", request.getParameter("selectedFolder"));
		recharge = true;
	}
	
	if(request.getParameter("selectedEmail") != null)
	{
		session.setAttribute("selectedEmail", Integer.parseInt((String)request.getParameter("selectedEmail")));
		recharge = true;
	}
	
	if(request.getParameter("selectedPagination") != null)
	{
		session.setAttribute("selectedPagination", Integer.parseInt((String)request.getParameter("selectedPagination")));
	}
	
	int selectedPagination = 1;
	if(session.getAttribute("selectedPagination") == null)
	{
		session.setAttribute("selectedPagination", selectedPagination);
	}
	else
		selectedPagination = (int)session.getAttribute("selectedPagination");
	
	
	if(request.getParameter("lengthEmails") != null)
	{
		session.setAttribute("lengthEmails", request.getParameter("lengthEmails"));
	}
	
	int lengthEmails = 0;
	if(session.getAttribute("lengthEmails") == null)
	{
		session.setAttribute("lengthEmails", lengthEmails);
	}
	else
		lengthEmails = (int)session.getAttribute("lengthEmails");
	

	/*Pega o email*/
	/*Hub hub = (Hub)session.getAttribute("hub");
	
	try{
	session.setAttribute("contas", Emails.getEmailsFromHub(hub.getIdHub()));
	}catch (Exception ex)
	{
		session.setAttribute("logado", false);
		response.sendRedirect("Login.jsp");
	}*/
    Hub hub = (Hub)session.getAttribute("hub");
    
	//System.err.println("Hub: "+hub);
	if(session.getAttribute("contas") == null && hub != null || recharge)
        session.setAttribute("contas", Emails.getEmailsFromHub(hub.getIdHub()));	
        
	Email[] contas = (Email[])session.getAttribute("contas");
	
	String selectedFolder = "INBOX";
	if(session.getAttribute("selectedFolder") != null)
		selectedFolder = (String)session.getAttribute("selectedFolder");
	else
		session.setAttribute("selectedFolder", selectedFolder);
	
	int selectedEmail = 0;
	if(session.getAttribute("selectedEmail") != null)
		selectedEmail = (int)session.getAttribute("selectedEmail");
	else
		session.setAttribute("selectedEmail", selectedEmail);
%>
	
<%!
	Folder toList = null;

   	public String ListarPastas(int dentro, String selectedFolder, Folder[] folder, String id)
   	{
		if(folder == null)
			return "";
		
		String ret = "";
		
    	for(int i = 0; i < folder.length; i++)
    	{
    		try{
    		folder[i].open(Folder.READ_ONLY);
    		}
    		catch (Exception erro){}
    		String active = "";
    		String abrir = "true";
    		 if(folder[i].getName().equals(selectedFolder))
    		 {
    			 toList = folder[i];
				active = "active";
				abrir = "true";
    		 }
    		 
    		 String icon = "fa-folder";
    		 
    		 if(folder[i].getName().equals("INBOX"))
    			 icon = "fa-inbox";
    		 
     		ret += "<a class='nav-link btn btn-outline-amarelo mt-3 pasta "
     		+ active + " ' data-toggle='collapse'role='button' href='#sub-pasta-" + (id + "_" + i)
     		+ "' aria-expanded='" + abrir + "'>" 
     		+ "<i class='fas " + icon + " fa-lg'></i><!--<div class='inline' style='visibility: hidden'>" + (id + "_" + i) + "</div>--><div class='inline' value='"
     		+ folder[i].getName() + "'>" 
     		+ folder[i].getName() + "</div></a>";
         try{
         Folder [] foldersAuxiliares = folder[i].list("*");
         ret += "<div class='collapse' id='sub-pasta-" + id + "_" + i + "' data-parent='#collapse-group'> <nav class='nav nav-pills flex-column'>";
         ret += ListarPastas(dentro + 1, selectedFolder, foldersAuxiliares, id + "_" + i);
         ret += "</nav></div>";
         }
         catch (Exception erro)
         {
        	 
         }
         try{
     		folder[i].close();
     		}
     		catch (Exception erro){}
    	}
    	
    	return ret;
   	}
%>

<%!
ArrayList<MimeBodyPart> attachs;
public String getTextFromMimeMultipart(
	    MimeMultipart mimeMultipart, int j){
	    String result = "";
	    int count = 0;
	    try{
	    count = mimeMultipart.getCount();}
	    catch (Exception erro){}
	    for (int i = 0; i < count; i++) {
	    	try{
	        BodyPart bodyPart = mimeMultipart.getBodyPart(i);
	        
	        if (bodyPart.isMimeType("text/plain")) 
	        {
	        	//is a text
	            result = result + "\n" + bodyPart.getContent();
	            break; // without break same text appears twice in my tests
	        } else 
	        	if (bodyPart.isMimeType("text/html")) 
	        	{
		            String html = (String) bodyPart.getContent();
		            result += "<div id='htmlElement'>" + Jsoup.parse(html).text() + "</div>";
		            //to read html and exibit it, jsoup library whould be needed
	        	}
	        	else
        		if (bodyPart.getContent() instanceof MimeMultipart)
        		{
        			//is a MimeMultipart
        			result = result + getTextFromMimeMultipart((MimeMultipart)bodyPart.getContent(), i);
        		}
        		else 
        		{
		        	//attachment
			        MimeBodyPart part = (MimeBodyPart) mimeMultipart.getBodyPart(i);
			        
			        if (MimeBodyPart.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) 
			        {
			        	attachs.add(part);
			        }
		        }
	        }catch (Exception erro){}
	    }
	    return result;
	    
	}
public String getTextFromMessage(Message message, int i) {
    String result = "";
    try{
    	result = message.getContent().toString();
	    if (message.isMimeType("text/plain")) {
	        result = message.getContent().toString();
	    } else
	    	if (message.isMimeType("multipart/*")) {
	        MimeMultipart mimeMultipart = (MimeMultipart) message.getContent();
	        result = getTextFromMimeMultipart(mimeMultipart, i);
	    }
    }
    catch (Exception erro)
    {
    	
    }
    return result;
}
%>

<%!
	public String setPagination(int selectedPagination, int lengthEmails)
	{
	String ret = "";
	
	if(selectedPagination == 1)
	{
		
		ret +="<li class='page-item'><a class='page-link text-dark bg-selected myPagination' href='#' id='pag" + selectedPagination + "'>" + selectedPagination + "</a></li>";
		if(lengthEmails > 10)
		{
			ret += "<li class='page-item'><a class='page-link text-dark myPagination' href='#' id='pag" + (selectedPagination + 1) + "'>" + (selectedPagination + 1) + "</a></li>";
			if(lengthEmails > 20)
				ret += "<li class='page-item'><a class='page-link text-dark myPagination' href='#' id='pag" + (selectedPagination + 2) + "'>" + (selectedPagination + 2) + "</a></li>";
		}
	}
	else
	{
		if(Math.ceil(lengthEmails/10) != selectedPagination)
		{
			if(lengthEmails < 21)
			{
				ret +="<li class='page-item'><a class='page-link text-dark myPagination' href='#' id='pag" + (selectedPagination - 1) + "'>" + (selectedPagination - 1) + "</a></li>";
				ret += "<li class='page-item'><a class='page-link text-dark bg-selected myPagination' href='#' id='pag" + selectedPagination + "'>" + selectedPagination + "</a></li>";
			}
			else{
				ret +="<li class='page-item'><a class='page-link text-dark myPagination' href='#' id='pag" + (selectedPagination - 2) + "'>" + (selectedPagination - 2) + "</a></li>";
				ret += "<li class='page-item'><a class='page-link text-dark myPagination' href='#' id='pag" + (selectedPagination - 1) + "'>" + (selectedPagination - 1) + "</a></li>";
				ret += "<li class='page-item'><a class='page-link text-dark bg-selected myPagination' href='#' id='pag" + selectedPagination + "'>" + selectedPagination + "</a></li>";
			}
		}
		else
		{
			ret +="<li class='page-item'><a class='page-link text-dark myPagination' href='#' id='pag" + (selectedPagination - 1) + "'>" + (selectedPagination - 1) + "</a></li>";
			ret += "<li class='page-item'><a class='page-link text-dark bg-selected myPagination' href='#' id='pag" + selectedPagination + "'>" + selectedPagination + "</a></li>";
			ret += "<li class='page-item'><a class='page-link text-dark myPagination' href='#' id='pag" + (selectedPagination + 1) + "'>" + (selectedPagination + 1) + "</a></li>";
		}
	}
		ret = "<script>document.getElementById('paginationGambiarrinha').innerHTML += \"" + "<li class='page-item disabled' id='pag-ant-container'> <a class='page-link text-light bg-dark border-dark' href='#' tabindex='-1' id='pag-ant'><i class='fas fa-angle-left'></i></a></li>" + ret;
    	ret += "<li class='page-item' id='pag-prox-container'><a class='page-link text-light bg-dark border-dark' href='#' id='pag-prox'><i class='fas fa-angle-right'></i></a></li>\";</script>";
		return ret;
	
	}
%>
    
</head>
<body id='body'>

<!----------------------- Linha Principal ----------------------->
	<div class="row">
    
<!----------------------- Coluna de Pastas ----------------------->
        <div class="col-sm-2 p-0">
        
            <nav class="navbar navbar-expand-xl bg-navbar main-row py-0">
                <div class="container px-2">
                
                    <a class="nav-brand p-0 main-row" id="titulo-pastas">
                        <h1 class="pl-4 text-dark titulo-nav-limitado">Pastas</h1>
                    
                    </a>

<!----------------------- pra quando a tela ficar mt pequena aparece o botão ----------------------->
                        <button class="navbar-light navbar-toggler" type="button" data-toggle="collapse" data-target="#pastas">
                        <span class="navbar-toggler-icon"></span>
                        </button> 
                    
                </div>
            </nav>
            
        </div>
        
<!----------------------- Coluna de Emails ----------------------->
        <div class="col-sm-7 p-0">
        
            <nav class="navbar navbar-expand-xl bg-navbar main-row">
            
                <div class="container px-1">
                    
<!----------------------- Botão de enviar email ----------------------->
                    <a class="btn btn-outline-dark navbar-brand h1 mb-0" href="#" data-toggle="modal" data-target="#modal-email">Enviar <i class="fas fa-paper-plane"></i></a>
                    
<!----------------------- pra quando a tela ficar mt pequena aparece o botão ----------------------->
                    <button class="navbar-light navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarEmails">
                    <span class="navbar-toggler-icon"></span>
                    </button> 
                    
<!----------------------- Conteudo q vai expandir ----------------------->
                    <div class="collapse navbar-collapse" id="navbarEmails">
                       
<!----------------------- Icones de navegação ----------------------->
                        <ul class="nav nav-pills mr-auto">
                            
                            <li class="nav-item align-middle centerY mr-3">
                                <i class="far fa-square not-checked fa-2x icon-menu" id="checkboxAll" tabindex="1"></i>
                            </li>
                            
                            <li class="nav-item align-middle centerY mr-2">
                                <i class="fas fa-envelope fa-2x nao-lida icon-menu" id="lida-naoLida" tabindex="1" data-toggle="tooltip" data-placement="bottom" data-trigger="hover" title="Marcar como lida"></i>
                            </li>
                            
                            <li class="nav-item align-middle centerY">

                            <form method="POST" action="Index.jsp">
                            	<input type="hidden" id="deletaveis" name="deletar" value=''>
                                <button type="submit" style="background: none; border: none;"><i class="fas fa-trash-alt fa-2x icon-menu" id="deletar" tabindex="1" data-toggle="tooltip" data-placement="bottom" data-trigger="hover" title="Excluir" style="background: none;border: none;"></i></button>

                            </form>
                            </li>
                    
                        </ul>
                        
<!----------------------- Formulário de pesquisa ----------------------->
                        <form class="form-inline d-flex justify-content-around" method="POST" action="BUSCAR">
                            <input class="form-control ml-4 mr-2" type="search" placeholder="Buscar..." name="busca">
                            <input type="hidden" name="vetorEmails" value=''>
                            <button class="btn btn-outline-dark" type="Submit"><i class="fas fa-search"></i></button>
                        </form>
                        
<!----------------------- Pagination ----------------------->
                        <nav class="ml-3">
                            <ul class="pagination justify-content-end centerY" id="paginationGambiarrinha">
                                
                          </ul>
                        </nav>
                        
                    </div>
                    
                </div>
            
            </nav>
        
        </div>
        
<!----------------------- Coluna de Contas de Emails ----------------------->
        <div class="col-sm-3 p-0">
            
            <nav class="navbar navbar-expand-xl bg-navbar main-row py-0">
            <div class="container px-1">
            
                <a class="nav-brand py-0 main-row" id="titulo-contas">
                    <h1 class="pl-4 text-dark">Contas</h1>
                </a>
                
                <a class="btn btn-outline-dark navbar-brand h4 mb-0" href="Deslogar.jsp"><i class="fas fa-sign-out-alt fa-lg"></i></a>
                    
                
<!----------------------- pra quando a tela ficar mt pequena aparece o botão ----------------------->
                        <button class="navbar-light navbar-toggler" type="button" data-toggle="collapse" data-target="#contas">
                        <span class="navbar-toggler-icon"></span>
                        </button> 
                    
                </div>
            </nav>
        
        </div>

    </div>
<!----------------------- Segunda Linha ----------------------->
    <div class="row">
    
<!----------------------- Coluna de Pastas ----------------------->
        <div class="col-sm-2 p-0">
            
            <div class="colapse show" id="pastas">
                <nav id="navbarVertical" class="navbar navbar-light pt-3">
                    <nav class="nav nav-pills flex-column col-11 ml-3">

                        <div id="collapse-group">
                        	<%
                        	
                        	if(contas.length != 0)
                        	{
	                        	GerenciadorEmail geMain = new GerenciadorEmail(contas[selectedEmail].getEndereco(), contas[selectedEmail].getSenha());
	                        	geMain.setSenderSession(contas[selectedEmail].getPorta(), contas[selectedEmail].getHost());
	                    		
	                        	try
	                        	{
		                        	geMain.setStore(contas[selectedEmail].getHost(), contas[selectedEmail].getProtocolo() + "s");
		                        	Folder[] folders = geMain.getFolders();
		                        	
		                        	
		                        	%>
		                        		<%= ListarPastas(0, (String)session.getAttribute("selectedFolder"), folders, "") %>
		                        	<%
	                        	
	                        	}
	                        	catch (Exception erro){}
                        	}
                            %>

                            <!-- <a class="nav-link btn btn-outline-amarelo mt-3 pasta" data-toggle="collapse" href="#sub-pasta1" role="button" aria-expanded="false"><i class="fas fa-folder fa-lg"></i> Pasta 1</a>

                            <div class="collapse" id="sub-pasta1" data-parent="#collapse-group">
                                <nav class="nav nav-pills flex-column">

                                    <a class="nav-link btn btn-outline-amarelo ml-3 mt-2 pasta" href="#"><i class="fas fa-folder fa-lg"></i> Pasta 1.1</a>
                                    <a class="nav-link btn btn-outline-amarelo ml-3 mt-2 pasta" href="#"><i class="fas fa-folder fa-lg"></i> Pasta 1.2</a>

                                </nav>
                            </div>



                            <a class="nav-link btn btn-outline-amarelo mt-3 pasta" data-toggle="collapse" href="#sub-pasta2" role="button" aria-expanded="false"><i class="fas fa-folder fa-lg"></i> Pasta 2</a>

                            <div class="collapse" id="sub-pasta2" data-parent="#collapse-group">
                                <nav class="nav nav-pills flex-column">

                                    <a class="nav-link btn btn-outline-amarelo ml-3 mt-2 pasta" href="#"><i class="fas fa-folder fa-lg"></i> Pasta 2.1</a>
                                    <a class="nav-link btn btn-outline-amarelo ml-3 mt-2 pasta" href="#"><i class="fas fa-folder fa-lg"></i> Pasta 2.2</a>
                                    <a class="nav-link btn btn-outline-amarelo ml-3 mt-2 pasta" href="#"><i class="fas fa-folder fa-lg"></i> Pasta 2.3</a>

                                </nav>
                            </div> -->
                        </div>
                    </nav>
                </nav>
            </div>
            
        </div>
        
<!----------------------- Coluna de Emails ----------------------->
        <div class="col-sm-7 p-0">
            <div class="container pl-0 pt-3 ">
                <a class="titulo-divisoria" href="#" data-toggle="collapse" data-target="#importantes">
                    <h4 class="text-dark"><i class="fas fa-caret-down"> Importantes</i></h4>
                </a>
                <div class="collapse show pt-1" id="importantes">
                    <ul class="list-group">
	                    <%
	                    Message[] msgs = new Message[0];
	                    
                    	if(toList != null)
                    	{
                    		try{

                    		toList.open(Folder.READ_WRITE);
                    		msgs = toList.getMessages();
                    		}
                    		catch (Exception erro)
                    		{
                    			toList = null;
                    		}
                    		
                    	}
                    	if(session.getAttribute("emails") == null || recharge)
	                    {
                    	session.setAttribute("emails", msgs);
	                    }
	                    else
	                    	msgs = (Message[])session.getAttribute("emails");
	                    
                    	if(request.getParameter("deletar") != null)
                    	{
                    		String a =request.getParameter("deletar").toString();
                    		String b = a.substring(0, a.length() -1);
                    		System.err.println(b);
                    		String[] del = b.split("/");
                    		System.err.println(del.length);
                    		for(int i=0; i < del.length; i++)
                    			msgs[Integer.parseInt(del[i])].setFlag(Flags.Flag.DELETED, true);
                    		
                    		session.setAttribute("emails", msgs);
                    	}

                    		int auxi = (selectedPagination * 10);
                    		
                    		if(auxi > msgs.length - 1)
                    			auxi = msgs.length - 1;
                    			
	                   		for(int i = auxi; i > (selectedPagination-1) * 10; i--)
	                   		{
	                   			if(msgs[i].getFlags().contains(Flags.Flag.DELETED))
	                   				continue;
	                   			String auxFrom = Arrays.toString(msgs[i].getFrom());
	                   			auxFrom = auxFrom.substring(1);
	                   			auxFrom = auxFrom.substring(0, auxFrom.length() - 1);
	                   			auxFrom = Jsoup.parse(auxFrom).text();
	                   			String from = auxFrom;
	                   			if(auxFrom.length() > 20)
	                   				auxFrom = auxFrom.substring(0, 17) + "...";
	                   			
	                   			while(auxFrom.length() < 20)
	                   				auxFrom += " ";
	                   			
	                   			String auxSub = msgs[i].getSubject();
	                   			auxSub = Jsoup.parse(auxSub).text();
	                   			if(auxSub.length() > 20)
	                   				auxSub = auxSub.substring(0, 17) + "...";
	                   			if(auxSub.trim().equals(""))
	                   				auxSub = "sem assunto...";
	                   			
	                   			while(auxSub.length() < 20)
	                   				auxSub += " ";
	                   			
	                   			attachs = new ArrayList<MimeBodyPart>();
	                   			String auxCont = getTextFromMessage(msgs[i], i);
	                   			String contWithHTML = auxCont;
	                   			
	                   			auxCont = Jsoup.parse(auxCont).text();
	                   			
	                   			String allRecipients = "";
	                   					
	                   			for (Address aux :msgs[i].getAllRecipients())
	                   				allRecipients += aux.toString() + "; ";
	                   	%>
	                   	
	                   	<li class="list-group-item list-group-item-action pl-2 email">
                            <i class="far fa-square checkbox"></i>
                            <div id="email-<%= i %>" class="display inline">
	                            <h6 class="username inline">
	                            	<%= auxFrom %>
	                            </h6>
	                            <h6 class="assunto inline">
	                            	<%= auxSub %>
	                            </h6>
	                            <p class="conteudo inline text-muted">
	                            	<%= auxCont %>
	                            </p>
                            </div>
                        </li>
                        <script>
	                        $(document).ready(function() {
	                            $('#email-<%= i %>').click(function (){
	                            	$('#modal-ver-email-<%= i %>').modal('show');
	                            });
	                        });
                        </script>
                        <div class="modal fade" id="modal-ver-email-<%= i %>" tabindex="-1" role="dialog"> <!-- fade = animação -->
					        <div class="modal-dialog modal-lg" role="document">
					            <div class="modal-content">
					            
					                <div class="modal-header">
					                    
					                    <h3 class="modal-title"><%= msgs[i].getSubject() %></h3>
					                    
					                    <button type="button" class="close" data-dismiss="modal">
					                        <span>&times;</span><!-- $time; = x -->
					                    </button>
					                    
					                </div>
					                
					                <div class="modal-body">
					                        
				                        <div class="form-row">  
				
				                            <div class="form-group col-sm-12">
				                                
				                                    
				                                        <h4 class="h4 inline">De: </h4>
				                                    
				                                    <label id="inputDestinatario-<%= i %>" class="inline"><%= from %></label>
				                                <br>
														<h5 class="h5 inline">Cc:&nbsp&nbsp</h5>
				                                    
				                                    <label id="ccEmail-<%= i %>" class="inline text-muted"><%= allRecipients %></label>
				                            </div>
				
				                        </div>
				                       
				                        <div class="form-row">  
				
				                            <div class="form-group col-sm-12">
				
				                                <h4 class="h4">Mensagem:</h4>
				                                <p id="mensagemEmail-<%= i %>">&nbsp<%= contWithHTML %></p>
				
				                            </div>
					
					                        </div>
					                        <div class="form-row">  
					
					                            <div class="form-group col-sm-12">
					                            <%
					                            	if(attachs.size() == 0){
					                            %>
					                                <label for="anexoEmail-<%= i %>">Anexos:</label>
					                                
					                                <input type="file" value="choose file">
					                                
					                                <br/>
					                            <%
					                            	}
					                            %>
					
					                            </div>
					
					                        </div>
					                        
					                  
					                        <div class="modal-footer">
					                        <%
					                        	if(session.getAttribute("emailAtual") != null)
					                        	{
					                        %>
					                    		<input type="hidden" name="enderecoH" value="<%=((Email)session.getAttribute("emailAtual")).getEndereco() %>">
					                            <input type="hidden" name="senhaH" value="<%=((Email)session.getAttribute("emailAtual")).getSenha() %>">
					                         <%
					                        	}
					                         %>   
					                            <button type="submit" class="btn btn-danger btn-block">reply</button>
											
					                        </div>
					                </div>
					
					            </div>
					        </div>
					      </div>
	                   	<%
	                   		}
	                   		if(msgs.length == 0)
	                   		{
	                   		%>
	                   			Sem emails aqui amigão :^|
	                   		<%
	                   		}
							//try{toList.close();}catch (Exception erro){}//Shhhhhh!!!
	                   	%>
                    </ul>
                </div>
            </div>
        </div>
        
<!----------------------- Coluna de Contas de Emails ----------------------->
        <div class="col-sm-3 p-0">
            
            <div class="collapse show" id="contas">
                <div class="list-group">
					
                <%
                
			if(session.getAttribute("contas") != null)
			{
            	Email[] ems = (Email[])session.getAttribute("contas");
            
            	for(int i = 0; i < ems.length; i++)
            	{
            		GerenciadorEmail ge = new GerenciadorEmail(ems[i].getEndereco(), ems[i].getSenha());
            		ge.setSenderSession(ems[i].getPorta(), ems[i].getHost());
            		
            		ge.setStore(ems[i].getHost(), ems[i].getProtocolo() + "s");
            		
            		int lengthEmailAtual = ge.receive().size();
            		
            		if(i == selectedEmail)
            		{
            			session.setAttribute("emailAtual", ems[i]);
            			session.setAttribute("lengthEmails", lengthEmailAtual);
            	%>
            		<%= setPagination(selectedPagination ,lengthEmailAtual) %>
                    <a href="#" class="list-group-item list-group-item-action flex-column conta active" value="<%= i %>">
				<%
            		}
            		else
            		{
				%>
					<a href="#" class="list-group-item list-group-item-action flex-column conta" value="<%= i %>">
				<%
            		}
				%>
                        <div class="d-flex w-100 justify-content-between">
                            <h5 class="mb-1 texto-limitado"><%= ems[i].getEndereco() %></h5><span class="badge badge-danger p-2 text-end"><%= lengthEmailAtual %></span>
                        </div>

                    </a>
                 <%
                 ge.closeStore();
            	}
			}
                 %>
                    <a class="list-group-item list-group-item-action flex-column" id="btnAdicionarConta">

                        <div class="d-flex w-100 justify-content-between">
                            <button class="btn btn-outline-danger btn-block btn-lg" href="#" data-toggle="modal" data-target="#modal-conta"><i class="fas fa-plus"></i> Nova conta</button>
                        </div>

                    </a>

                </div>
            </div>
            
        </div>
    
    </div>
    
<!---------------------------------MODAL-EMAIL--------------------------------->
    <div class="modal fade" id="modal-email" tabindex="-1" role="dialog"> <!-- fade = animação -->
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
            
                <div class="modal-header">
                    
                    <h3 class="modal-title">Enviar Email</h3>
                    
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span><!-- $time; = x -->
                    </button>
                    
                </div>
                
                <div class="modal-body">
                    
                    <form action="ENVIAREMAIL" method="POST" id="formEnviar">
                        
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputDestinatario">Destinatário:</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Para:</div>
                                    </div>
                                    <input type="text" name="destinatario" class="form-control" id="inputDestinatario" placeholder="" required>
                                </div>

                            </div>

                        </div>
                        <div class="form-row">

                            <div class="form-group col-sm-6">

                                <label for="inputCc">Com cópia:</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Cc:</div>
                                    </div>
                                    <input type="text" name="cc" class="form-control" id="inputCc" placeholder="">
                                </div>
                                
                            </div>

                             <div class="form-group col-sm-6">

                                <label for="inputCco">Com cópia oculta:</label>
                                 <div class="input-group">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Cco:</div>
                                    </div>
                                    <input type="text" name="cco" class="form-control" id="inputCco" placeholder="">
                                </div>

                            </div>

                        </div>
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputAssunto">Assunto:</label>
                                <input type="text" name="assunto" class="form-control" id="inputAssunto" required>

                            </div>

                        </div>
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputMensagem">Mensagem:</label>
                                <textarea name="mensagem" class="form-control" id="inputMensagem" form ="formEnviar" required></textarea>

                            </div>

                        </div>
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputAnexo" id="file">Anexo:</label>
                                <br/>
                                <input type="file" name="anexo" class="form-control-file" id="inputAnexo" multiple="multiple"> 


                            </div>

                        </div>
                        
                  
                        <div class="modal-footer">
                        <%
                        	if(session.getAttribute("emailAtual") != null)
                        	{
                        %>
                    		<input type="hidden" name="enderecoH" value="<%=((Email)session.getAttribute("emailAtual")).getEndereco() %>">
                            <input type="hidden" name="senhaH" value="<%=((Email)session.getAttribute("emailAtual")).getSenha() %>">
                         <%
                        	}
                         %>   
                            <button type="submit" class="btn btn-danger btn-block">Enviar</button>
						
                        </div>
                    </form>
                </div>

            </div>
        </div>
      </div>
<!---------------------------------MODAL-CONTA--------------------------------->
      
      <div class="modal fade" id="modal-conta" tabindex="-1" role="dialog"> <!-- fade = animação -->
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
            
                <div class="modal-header">
                    
                    <h3 class="modal-title">Nova conta</h3>
                    
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span><!-- $time; = x -->
                    </button>
                    
                </div>
                
                <div class="modal-body">
                    <div class="container-fluid">
                        
                        <form action="NOVACONTA" method="POST">
                  
                            
                            <div class="form-row">  

                                <div class="form-group col-sm-12">

                                    <label for="inputEndereco">Endereço de email:</label>
                                    <input type="email" name="enderecoC" class="form-control" id="inputEndereco" placeholder="Endereço">

                                </div>

                            </div>
                            <div class="form-row">  

                                <div class="form-group col-sm-12">

                                    <label for="inputSenha">Senha:</label>
                                    <input type="password" name="senhaC" class="form-control" id="inputSenha" placeholder="Senha">

                                </div>

                            </div>
                            
                            <div class="form-row">  

                                <div class="form-group col-sm-12">

                                    <label for="inputPorta">Porta:</label>
                                    <input type="number" name="portaC" class="form-control" id="inputPorta" placeholder="Porta">

                                </div>

                            </div>
                            
                            <div class="form-row">  

                                <div class="form-group col-sm-12">

                                    <label for="inputHost">Host:</label>
                                    <input type="text" name="hostC" class="form-control" id="inputHost" placeholder="Host">

                                </div>

                            </div>
                            
                            <div class="form-row">  

                                <div class="form-group col-sm-12">

                                    <label for="inputMode">Protocolo:</label>
                                    <input type="text" name="modeC" class="form-control" id="inputMode" placeholder="Protocolo">

                                </div>

                            </div>
                            <div class="form-row">

                                <div class="form-group col-sm-12">

                                    <div class="form-check">

                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox"> Abrir ao final da inserção
                                        </label>

                                    </div>

                                </div>

                            </div>
                            
                            <div class="modal-footer">
                            <%
                        		if(session.getAttribute("hub") != null)
                        	{
                        	%>
                    			<input type="hidden" name="hubC" value="<%=((Hub)session.getAttribute("hub")).getIdHub() %>">
                         	<%
                        		}
                         	%> 
                            
                            
                                <button type="submit" class="btn btn-danger btn-block">Adicionar</button>
                            </div>

                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
      </div>
    
    <script>
        
        $(function () {
            $('[data-toggle="popover"]').popover()
        });
        
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        });
        
        
    </script>
    
    <script src="js/script.js"></script>
    
</body>
</html>