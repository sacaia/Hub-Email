<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
    
<!-- Required meta tags -->
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    
<!-- My CSS -->
    <link rel="stylesheet" href="css/cadastro.css">

<!-- Fontawesome CSS -->
    <link rel="stylesheet" href="fontawesome-free-5.8.1-web/css/all.css">
    
	<title>Mali Mail</title>
    
</head>
<body>
    <div class="container">
        <div class="row">
          <div class="col-lg-10 col-xl-9 mx-auto">
            <div class="card card-signin flex-row my-5">
              <div class="card-img-left d-none d-md-flex">
                 <!-- Background image for card set in CSS! -->
              </div>
              <div class="card-body">
                <h5 class="card-title text-center">Cadastro</h5>
                <form class="form-signin" method="POST" action="CADASTRAR">
                  <div class="form-label-group">
                    <input type="text" name="usuario" id="inputUserame" class="form-control" placeholder="Username" required autofocus>
                    <label for="inputUserame">Usuario</label>
                  </div>

                  <hr>

                  <div class="form-label-group">
                    <input type="password" name="senha" id="inputPassword" class="form-control" placeholder="Password" required>
                    <label for="inputPassword">Senha</label>
                  </div>

                  <div class="form-label-group">
                    <input type="password" name="confirmarSenha" id="inputConfirmPassword" class="form-control" placeholder="Password" required>
                    <label for="inputConfirmPassword">Confirmar senha</label>
                  </div>

                  <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Cadastrar</button>
                  <a class="d-block text-center mt-2 small" href="Login.jsp">Login</a>
                  <hr class="my-4">
                  <button class="btn btn-lg btn-google btn-block text-uppercase" type="submit"><i class="fab fa-google mr-2"></i> Login com Google</button>
                  <button class="btn btn-lg btn-facebook btn-block text-uppercase" type="submit"><i class="fab fa-facebook-f mr-2"></i> Login com Facebook</button>
                </form>
              </div>
            </div>
          </div>
        </div>
    </div>
<!-- -------------------------------------- -->
<%
try{
	if((boolean)session.getAttribute("senhasDiferentes"))
	{
%>
	<div role="alert" aria-live="assertive" aria-atomic="true" class="toast" data-autohide="false" id="toast" style="position: absolute; bottom: 0; right: 0; max-width: 38vh; width: 38vh">
  <div class="toast-header">
    <strong class="mr-auto">Senhas diferentes</strong>
    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  <div class="toast-body">
    Digite senhas iguais
  </div>
</div>
<%
		session.setAttribute("senhasDiferentes", false);
	}
}catch(Exception e) {}
%>
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
        
        $('#toast').toast('show')
      
    </script>
    
</body>
</html>