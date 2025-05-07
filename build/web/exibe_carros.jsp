<%@page import="java.util.List"%>
<%@page import="vo.UsuarioVO"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Listagem</title>

    </head>
    <body>
        <%
            List pessoas = (List) request.getAttribute("lista");
            if (pessoas != null) {
                out.print("<center>Achados: " + pessoas.size() + "</center><br><br><br>");
                out.print("<table width=\"50%\" border=\"1\" cellspacing=\"0\" align=\"center\">");
                for (int cont = 0; cont < pessoas.size(); cont++) {
                    CarroVO p = new CarroVO();
                    p = (CarroVO) pessoas.get(cont);
                    out.print("<tr>");
                    out.print("<td>" + p.getMarca() + "</td>");
                    out.print("<td>" + p.getModelo() + "</td>");
                    out.print("<td>" + p.getChave() + "</td>");
                    out.print("<td>" + p.getAno() + "</td>");
        
                    out.print("<td><a href=\"CarroController?acao=3&chave=" + p.getChave() + "\">Excluir</a></td>");
                    out.print("<td><a href=\"ProdutoController?operacao=3&chave="+p.getChave()+"\">Alterar</a></td>");
                    out.print("</tr>");
                }
                out.print("</table>");
            }
        %>

    </body>
</html>
