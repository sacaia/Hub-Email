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
<%
	try{
		if((boolean)request.getAttribute("logado"))
		{
			session.setAttribute("logado", true);
			session.setAttribute("hub", request.getAttribute("logado"));
		}
	}
	catch (Exception e)
	{
		
	}

%>

<!----------------------- Linha Principal ----------------------->
	<div class="row">
	
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
		<div class="container">
			<a class="navbar-brand">Java Mali</a>
				<%
				try
				{
					if((boolean)session.getAttribute("logado"))
					{
				%>		
						<form action="Index.jsp">
				<%
					}
					else
					{
				%>
						<form action="Login.jsp">
				<%
					}
				}
				catch (Exception e)
				{
				%>
					<form action="Login.jsp">
				<%
				}
				%>
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