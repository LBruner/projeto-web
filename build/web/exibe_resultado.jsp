<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="refresh"">
        <link rel="stylesheet" href="styles.css">
        <title>Carros</title>
    </head>
    <body>
    <center>
        <h1>
            <%

                int resultado = Integer.parseInt(request.getParameter("result"));
                if (resultado == 1) {
                    out.print("<font color=\"blue\">SUCESSO</font>");
                } else {
                    out.print("<font color=\"red\">ERRO</font>");
                }
            %>
        </h1>
    </center>
</body>
</html>
