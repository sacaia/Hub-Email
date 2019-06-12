<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    session="true"%>
<html>
<head>
    
<!-- Required meta tags -->
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    
<!-- My CSS -->
    <link rel="stylesheet" href="css/login.css">

<!-- Fontawesome CSS -->
    <link rel="stylesheet" href="fontawesome-free-5.8.1-web/css/all.css">
    
	<title>Mali Mail</title>
    
</head>
<body>
<%
if(session.getAttribute("logado") != null)
	if((boolean)session.getAttribute("logado"))
	{
		if(session.getAttribute("hub") != null)
			response.sendRedirect("Index.jsp");
		else
			session.setAttribute("logado", false);
	}
%>
    <div class="container-fluid">
      <div class="row no-gutter">
        <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
        <div class="col-md-8 col-lg-6">
          <div class="login d-flex align-items-center py-5">
            <div class="container">
              <div class="row">
                <div class="col-md-9 col-lg-8 mx-auto">
                  <h3 class="login-heading mb-4 pl-3">Java Mali</h3>
                  <form method="POST" action="LOGAR">
                    <div class="form-label-group">
                      <input type="text" name="usuario" id="inputUsername" class="form-control" placeholder="Username" required autofocus>
                      <label for="inputUsername">Usuário</label>
                    </div>

                    <div class="form-label-group">
                      <input type="password" name="senha" id="inputPassword" class="form-control" placeholder="Password" required>
                      <label for="inputPassword">Senha</label>
                    </div>

                    <button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2" type="submit">Entrar</button>
                    <div class="text-center">
                      <a class="small" href="Cadastro.jsp">Não possui cadastro?</a></div>
                  </form>
                </div>
              </div>
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