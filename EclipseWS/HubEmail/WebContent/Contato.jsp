<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    session="true"%>
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
<body class="body-contato">
    
<!----------------------- Linha Principal ----------------------->
	<div class="row">
	
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
		<div class="container">
			<a class="navbar-brand">Java Mali</a>
				<%
				if(session.getAttribute("logado") != null)
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
				else
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
		        <li class="nav-item">
		          <a class="nav-link" href="Home.jsp">Home</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="Sobre.jsp">Sobre</a>
		        </li>
		        <li class="nav-item active">
		          <a class="nav-link" href="Contato.jsp">Contato
                    <span class="sr-only">(current)</span>
                    </a>
		        </li>
		      </ul>
		    </div>
		  </div>
		</nav>
<!-------------------------------------------------->
    
    <div class="container my-5">
      <div class="card border-0 shadow my-5">
        <div class="card-body p-5">
          <h1 class="font-weight-light">Contato</h1>
          <p class="lead">Se por qualquer motivo precisar contactar os desenvolvedores, por favor não hesite</p>
          
              <section>
                <div class="container">
                  <div class="row align-items-center">
                    <div class="col-lg-6 order-lg-2">
                      <div class="p-5">
                        <img class="img-fluid rounded-circle" src="img/Vulpix2.0.png" alt="">
                      </div>
                    </div>
                    <div class="col-lg-6 order-lg-1">
                      <div class="p-5">
                        <h2 class="display-4">Lucas Romani</h2>
                        <p class="lead">Raposas</p>
                      </div>
                    </div>
                  </div>
                </div>
              </section>

              <section>
                <div class="container">
                  <div class="row align-items-center">
                    <div class="col-lg-6">
                      <div class="p-5">
                        <img class="img-fluid rounded-circle" src="img/Maian.jpg" alt="">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="p-5">
                        <h2 class="display-4">Francisco Maian</h2>
                        <p class="lead">Gado q atrai cabelo colorido</p>
                      </div>
                    </div>
                  </div>
                </div>
              </section>

              <section>
                <div class="container">
                  <div class="row align-items-center">
                    <div class="col-lg-6 order-lg-2">
                      <div class="p-5">
                        <img class="img-fluid rounded-circle" src="img/Tales.jpg" alt="">
                      </div>
                    </div>
                    <div class="col-lg-6 order-lg-1">
                      <div class="p-5">
                        <h2 class="display-4">Tales Nicoletti</h2>
                        <p class="lead">Gamer nato</p>
                      </div>
                    </div>
                  </div>
                </div>
              </section>
            
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