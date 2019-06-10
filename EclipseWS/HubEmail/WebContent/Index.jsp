<%@ page language="java" 
	contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    session="true"
    import="bd.dbos.*, bd.daos.*, util.*, java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
    
<!-- Required meta tags -->
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    
<!-- My CSS -->
    <link rel="stylesheet" href="css/style.css">

<!-- Fontawesome CSS -->
    <link rel="stylesheet" href="fontawesome-free-5.8.1-web/css/all.css">
    
	<title>Mali Mail</title>
    
</head>
<body>
<%
	/*Setando as Sessions*/
	if(request.getAttribute("logado") != null)
	{
		session.setAttribute("logado", true);
		if(((boolean)session.getAttribute("logado")) == false)
			response.sendRedirect("Login.jsp");
	}

	if(request.getAttribute("hub") != null)
		session.setAttribute("hub", request.getAttribute("hub"));
	
	if(session.getAttribute("logado") == null)
		response.sendRedirect("Login.jsp");

	if(session.getAttribute("logado") != null)
		if(!(boolean)session.getAttribute("logado"))
			response.sendRedirect("Login.jsp");
		

	/*Pega o email*/
    Hub hub = (Hub)session.getAttribute("hub");
    
	System.err.println("Hub: "+hub);
	if(session.getAttribute("emails") == null && hub != null)
        session.setAttribute("emails", Emails.getEmailsFromHub(hub.getIdHub()));	
        
	session.setAttribute("emails", Emails.getEmailsFromHub(hub.getIdHub()));
	Email[] emails = (Email[])session.getAttribute("emails");
	
	int selectedItem = 0;
	if(session.getAttribute("selectedItem") != null)
		selectedItem = (int)session.getAttribute("selectedItem");
	
	String selectedFolder = "INBOX";
	if(session.getAttribute("selectedItem") != null)
		selectedFolder = (String)session.getAttribute("selectedFolder");
	else
		session.setAttribute("selectedFolder", selectedFolder);

%>

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
                                <i class="fas fa-trash-alt fa-2x icon-menu" id="deletar" tabindex="1" data-toggle="tooltip" data-placement="bottom" data-trigger="hover" title="Excluir"></i>
                            </li>
                    
                        </ul>
                        
<!----------------------- Formulário de pesquisa ----------------------->
                        <form class="form-inline d-flex justify-content-around">
                            <input class="form-control ml-4 mr-2" type="search" placeholder="Buscar...">
                            <button class="btn btn-outline-dark" type="Submit"><i class="fas fa-search"></i></button>
                        </form>
                        
<!----------------------- Pagination ----------------------->
                        <nav class="ml-3">
                            <ul class="pagination justify-content-end centerY">
                                <li class="page-item disabled" id="pag-ant-container">
                                    <a class="page-link text-light bg-dark border-dark" href="#" tabindex="-1" id="pag-ant"><i class="fas fa-angle-left"></i></a>
                                </li>
                                <li class="page-item"><a class="page-link text-dark bg-selected" href="#" id="pag1">1</a></li>
                                <li class="page-item"><a class="page-link text-dark" href="#" id="pag2">2</a></li>
                                <li class="page-item"><a class="page-link text-dark" href="#" id="pag3">3</a></li>
                                <li class="page-item" id="pag-prox-container">
                                    <a class="page-link text-light bg-dark border-dark" href="#" id="pag-prox"><i class="fas fa-angle-right"></i></a>
                                </li>
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
                        	
                        	GerenciadorEmail geMain = new GerenciadorEmail(emails[selectedItem].getEndereco(), emails[selectedItem].getSenha());
                        	geMain.setSenderSession(emails[selectedItem].getPorta(), emails[selectedItem].getHost());
                    		
                        	geMain.setStore(emails[selectedItem].getHost(), emails[selectedItem].getProtocolo() + "s");
                        	
                        	ArrayList<String> folderNames = geMain.listarPastas("0");
                        	
                        	for(int i = 0; i < folderNames.size(); i++)
                        	{
                        		String nomeSing = folderNames.get(i);
                        		
                        		String aux = ";";
                        		if(nomeSing == "INBOX")
                        			aux = "pasta";
                        		else
                        			aux = "mt-3 pasta";
                        		
                        		String active  = "";
                        		
                        		if(i == selectedItem)
                        			active  = "active";
                        		
                        	%>
                            <a class="nav-link btn btn-outline-amarelo <%= aux + " " + active %>" data-toggle="collapse"role="button" href="#inbox-collapse" aria-expanded="false"><i class="fas fa-inbox fa-lg"></i> <%= folderNames.get(i)%></a>

                            <div class="collapse" id="inbox-collapse" data-parent="#collapse-group"></div>
                            
                            <%
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
                        <li class="list-group-item list-group-item-action pl-2 email">
                            <i class="far fa-square checkbox"></i>
                            <h6 class="username inline">Username Remetente</h6>
                            <h7 class="assunto inline">Assunto Email</h7>
                            <p class="conteudo inline text-muted">- Texto do email, bla bla bla......</p>
                        </li>
                        <li class="list-group-item list-group-item-action pl-2 email">
                            <i class="far fa-square checkbox"></i>
                            <h6 class="username inline">Sacaia</h6>
                            <h7 class="assunto inline">Texto n fica fixo</h7>
                            <p class="conteudo inline text-muted">- Já to ficando pito com esse texto</p>
                        </li>
                        <li class="list-group-item list-group-item-action pl-2 email">
                            <i class="far fa-square checkbox"></i>
                            <h6 class="username inline">Alguem ai</h6>
                            <h7 class="assunto inline">Algum assunto ai</h7>
                            <p class="conteudo inline text-muted">- bla bla bla......</p>
                        </li>
                        <li class="list-group-item list-group-item-action pl-2 email">
                            <i class="far fa-square checkbox"></i>
                            <h6 class="username inline">Maian</h6>
                            <h7 class="assunto inline">N sei faze projeto</h7>
                            <p class="conteudo inline text-muted">- bla bla bla......</p>
                        </li>
                        <li class="list-group-item list-group-item-action pl-2 email">
                            <i class="far fa-square checkbox"></i>
                            <h6 class="username inline">Maiana</h6>
                            <h7 class="assunto inline">Esponjas</h7>
                            <p class="conteudo inline text-muted">- Já to bla bla bla......</p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        
<!----------------------- Coluna de Contas de Emails ----------------------->
        <div class="col-sm-3 p-0">
            
            <div class="collapse show" id="contas">
                <div class="list-group">
					
                <%
                
			if(session.getAttribute("emails") != null)
			{
            	Email[] emails = (Email[])session.getAttribute("emails");
            
            	for(int i = 0; i < emails.length; i++)
            	{
            		GerenciadorEmail ge = new GerenciadorEmail(emails[i].getEndereco(), emails[i].getSenha());
            		ge.setSenderSession(emails[i].getPorta(), emails[i].getHost());
            		
            		ge.setStore(emails[i].getHost(), emails[i].getProtocolo() + "s");
            		
            		if(i == 0)
            		{
            	%>
                    <a href="#" class="list-group-item list-group-item-action flex-column conta active">
				<%
            		}
            		else
            		{
				%>
					<a href="#" class="list-group-item list-group-item-action flex-column conta">
				<%
            		}
				%>
                        <div class="d-flex w-100 justify-content-between">
                            <h5 class="mb-1 texto-limitado"><%= emails[i].getEndereco() %></h5><span class="badge badge-danger p-2 text-end"><%= ge.receive().size() %></span>
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
                                    <input type="text" name="destinatario" class="form-control" id="inputDestinatario" placeholder="">
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
                                <input type="text" name="assunto" class="form-control" id="inputAssunto">

                            </div>

                        </div>
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputMensagem">Mensagem:</label>
                                <textarea name="mensagem" class="form-control" id="inputMensagem" form ="formEnviar"></textarea>

                            </div>

                        </div>
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputAnexo">Anexo:</label>
                                <br/>
                                <input type="file" name="anexo" class="form-control-file" id="inputAnexo">

                            </div>

                        </div>
                        
                  
                        <div class="modal-footer">
                    		<input type="hidden" name="gerenciador" value="<%= %>">
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
                        
                        <form>
                  
                            
                            <div class="form-row">  

                                <div class="form-group col-sm-12">

                                    <label for="inputEndereco">Endereço de email:</label>
                                    <input type="email" name="enderecoC" class="form-control" id="inputEndereco" placeholder="Endereço">

                                </div>

                            </div>
                            <div class="form-row">  

                                <div class="form-group col-sm-12">

                                    <label for="inputEndereco">Senha:</label>
                                    <input type="password" name="senhaC" class="form-control" id="inputSenha" placeholder="Senha">

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
                                <button type="button" class="btn btn-danger btn-block" data-dismiss="modal">Adicionar</button>
                            </div>

                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
      </div>
    
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="js/jquery-slim.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.bundle.js"></script>
    <script src="js/script.js"></script>
    
    <script>
        
        $(function () {
            $('[data-toggle="popover"]').popover()
        });
        
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        });
      
    </script>
    
</body>
</html>