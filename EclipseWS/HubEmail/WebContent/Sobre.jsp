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
<body class="body-sobre">
    
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
		        <li class="nav-item active">
		          <a class="nav-link" href="Sobre.jsp">Sobre
                    <span class="sr-only">(current)</span>
                    </a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="Contato.jsp">Contato</a>
		        </li>
		      </ul>
		    </div>
		  </div>
		</nav>
<!-------------------------------------------------->
    
    <div class="container my-5">
      <div class="card border-0 shadow my-5">
        <div class="card-body p-5">
          <h1 class="font-weight-light">Sobre</h1>
          <p class="lead">Este é um projeto desevolvido para nosso amado e querido professor André, mais conhecido como Maligno ❤️</p>
          
              <section>
                <div class="container">
                  <div class="row align-items-center">
                    <div class="col-lg-6 order-lg-2">
                      <div class="p-5">
                        <img class="img-fluid rounded-circle" src="img/maligno.jpg" alt="">
                      </div>
                    </div>
                    <div class="col-lg-6 order-lg-1">
                      <div class="p-5">
                        <h2 class="display-4">Maligno</h2>
                        <p class="lead">Conheça este amor de pessoa.</p>
                        <p class="lead" style="text-align: justify">Este, magnífico e maravilhoso professor, não só, tem um ótimo coração como é como um pai para nós, agradecemos seus ensinamentos e carinho para conosco. Te amamos Maligno</p>
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
                        <img class="img-fluid rounded-circle" src="img/toalha.png" alt="">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="p-5">
                        <h2 class="display-4">Dia da Toalha</h2>
                        <p class="lead">Dia 25 de Maio, famoso dia do orgulho nerd, foi incrível poder encontrar nosso deus e amigos com suas toalhas para, juntos, comemorarmos este inesquecivel dia</p>
                      </div>
                    </div>
                  </div>
                </div>
              </section>
            
              <section>
                  <h1 class="font-weight-light text-center text-lg-left mt-4 mb-0">Galeria 📷</h1>

                  <hr class="mt-2 mb-5">

                  <div class="row text-center text-lg-left">

                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="img/a.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="img/b.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="img/c.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="img/d.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="img/e.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="f.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="g.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="h.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="i.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="j.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="k.jpg" alt="">
                          </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-6">
                      <a class="d-block mb-4 h-100">
                            <img class="img-fluid img-thumbnail" src="l.jpg" alt="">
                          </a>
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