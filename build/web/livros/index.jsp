<%@page import="vo.EmprestimoVO"%>
<%@page import="java.util.List" %>
<%@page import="vo.LivroVO" %>
<%@page import="vo.UsuarioVO" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <title>Início</title>
    </head>

    <body>

        <%
            Object userAttribute = request.getAttribute("usuario");
            UsuarioVO loggedInUser = null;

            if (userAttribute instanceof UsuarioVO) {
                loggedInUser = (UsuarioVO) userAttribute;
            }

            int usuarioId = loggedInUser.getId();

            out.println("<button><a href=\"/ProjetoWeb/LivroController?acao=1" + "" + "\">Encontrar Livros</a></button>");
            out.println("<button><a href=\"/ProjetoWeb/LivroController?acao=5" + "" + "\">Gerenciar Livros</a></button>");

            if (loggedInUser != null) {
                out.println("<p>User ID: " + loggedInUser.getId() + "</p>");
                out.println("<p>Name: " + loggedInUser.getNome() + "</p>");
                out.println("<p>Email: " + loggedInUser.getEmail() + "</p>");
                out.println("<p>Telefone: " + loggedInUser.getTelefone() + "</p>");
            } else {
                out.println("<p>User information not found in request.</p>");
            }
        %>

        <%
            List emprestimos = (List) request.getAttribute("emprestimos");
            if (emprestimos != null) {
                out.print("<center>Achados: " + emprestimos.size() + "</center><br><br><br>");
                out.print("<table width=\"50%\" border=\"1\" cellspacing=\"0\" align=\"center\">");
                for (int cont = 0; cont < emprestimos.size(); cont++) {
                    if (emprestimos.get(cont) instanceof EmprestimoVO) {
                        EmprestimoVO emprestimoAtual = null;
                        emprestimoAtual = (EmprestimoVO) emprestimos.get(cont);

                        out.print("<tr>");
                        out.print("<td>" + emprestimoAtual.getLivro().getTitulo() + "</td>");
                        out.print("<td>" + emprestimoAtual.getLivro().getAutor() + "</td>");
                        out.print("<td>" + emprestimoAtual.getLivro().getDataPublicacao() + "</td>");
                        out.print("<td>" + emprestimoAtual.getDataEmprestimo() + "</td>");
                        out.print("<td>" + emprestimoAtual.getDataDevolucao() + "</td>");
                        out.print("<td>" + emprestimoAtual.isDevolvido() + "</td>");

                        out.print("<td><a href=\"../ProjetoWeb/LivroController?acao=3&usuario_id=" + loggedInUser.getId() + "&chave_emprestimo=" + emprestimoAtual.getLivro().getId() + "\">Devolver</a></td>");
                        out.print("</tr>");
                    }

                }
                out.print("</table>");
            }
        %>
    </body>

</html>