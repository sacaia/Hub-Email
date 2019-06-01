<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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

<!----------------------- Linha Principal ----------------------->
	<div class="row">
	
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
		<div class="container">
			<a class="navbar-brand">Java Mali</a>
				<form action="Login.jsp">
					<input type="submit" value="Entrar" class="btn btn-primary ml-2">
				</form>
            
		    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
		          <span class="navbar-toggler-icon"></span>
		        </button>
		    <div class="collapse navbar-collapse" id="navbarResponsive">
		      <ul class="navbar-nav ml-auto">
		        <li class="nav-item active">
		          <a class="nav-link" href="Home.jsp">Home
		                <span class="sr-only">(current)</span>
		              </a>
		        </li>
		        <li class="nav-item">
		        	<a class="nav-link" href="Sobre.jsp">Sobre</a>
		          </li>
		        <li class="nav-item">
		          <a class="nav-link" href="Contato.jsp">Contato</a>
		        </li>
		      </ul>
		    </div>
		  </div>
		</nav>
<!-------------------------------------------------->
		
		
		<!-- Page Content -->

        <div id="carouselGrande" class="carousel slide" data-ride="carousel">

          <ol class="carousel-indicators">
          <li data-target="#carouselGrande" data-slide-to="0" class="active"></li>
          <li data-target="#carouselGrande" data-slide-to="1"></li>
          <li data-target="#carouselGrande" data-slide-to="2"></li>
          </ol>
          
          <div class="carousel-inner centerX">
          
            <div class="carousel-item imagem-carousel active" style="background-image: url('img/Tartaruga5.jpg')">    
                
                
                <div class="carousel-caption d-none d-sm-block ">
                    <h1>Praticidade</h1>
                    <p class="lead">Todos os seus emails em um unico lugar</p>
                </div>
            </div>
              
            <div class="carousel-item imagem-carousel" style="background-image: url('img/Tartaruga6.jpg')">        
                
                <div class="carousel-caption d-none d-sm-block">
                    <h1>Facilidade</h1>
                    <p class="lead">Gerencie todos os seus emails de maneira integrada</p>
                </div>
            </div>
              
            <div class="carousel-item imagem-carousel" style="background-image: url('img/Tartaruga4.jpg')">       
                
                <div class="carousel-caption d-none d-sm-block">
                    <h1>Segurança</h1>
                    <p class="lead">Emails protegidos com TLS</p>
                </div>
            </div>
              

          <a class="carousel-control-prev" href="#carouselGrande" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
            <span class="sr-only">Anterior</span>
          </a>
          
          <a class="carousel-control-next" href="#carouselGrande" role="button" data-slide="next">
            <span class="carousel-control-next-icon"></span>
            <span class="sr-only">Avançar</span>
          </a>
          
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
                    
                    <form>
                        
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputDestinatario">Destinatário:</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Para:</div>
                                    </div>
                                    <input type="text" class="form-control" id="inputDestinatario" placeholder="">
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
                                    <input type="text" class="form-control" id="inputCc" placeholder="">
                                </div>
                                
                            </div>

                             <div class="form-group col-sm-6">

                                <label for="inputCco">Com cópia oculta:</label>
                                 <div class="input-group">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Cco:</div>
                                    </div>
                                    <input type="text" class="form-control" id="inputCco" placeholder="">
                                </div>

                            </div>

                        </div>
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputAssunto">Assunto:</label>
                                <input type="text" class="form-control" id="inputAssunto">

                            </div>

                        </div>
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputMensagem">Mensagem:</label>
                                <textarea class="form-control" id="inputMensagem"></textarea>

                            </div>

                        </div>
                        <div class="form-row">  

                            <div class="form-group col-sm-12">

                                <label for="inputAnexo">Anexo:</label>
                                <br/>
                                <input type="file" class="form-control-file" id="inputAnexo">

                            </div>

                        </div>
                        
                  
                        <div class="modal-footer">
                    
                            <button type="submit" class="btn btn-danger btn-block" data-dismiss="modal">Enviar</button>

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
                                    <input type="email" class="form-control" id="inputEndereco" placeholder="Endereço">

                                </div>

                            </div>
                            <div class="form-row">  

                                <div class="form-group col-sm-12">

                                    <label for="inputEndereco">Senha:</label>
                                    <input type="password" class="form-control" id="inputSenha" placeholder="Senha">

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