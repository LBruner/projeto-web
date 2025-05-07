<%@page import="vo.LivroVO"%>
<%@page import="java.util.List"%>
<%@page import="vo.UsuarioVO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <title>Encontrar Livros</title>
    </head>
    <body>        
        <button onclick="history.back()">Return to Previous Page</button>
        <%
            HttpSession currentSession = request.getSession();
            String loggedInUser = "";
            
            if (currentSession.getAttribute("usuario_id") instanceof String) {
                loggedInUser = (String) currentSession.getAttribute("usuario_id");
            }

            List livrosDisponiveis = (List) request.getAttribute("livros_disponiveis");

            if (livrosDisponiveis != null) {
                out.print("<center>Achados: " + livrosDisponiveis.size() + "</center><br><br><br>");
                out.print("<table width=\"50%\" border=\"1\" cellspacing=\"0\" align=\"center\">");
                for (int cont = 0; cont < livrosDisponiveis.size(); cont++) {
                    if (livrosDisponiveis.get(cont) instanceof LivroVO) {
                        LivroVO livroAtual = null;
                        livroAtual = (LivroVO) livrosDisponiveis.get(cont);

                        out.print("<tr>");
                        out.print("<td>" + livroAtual.getId() + "</td>");
                        out.print("<td>" + livroAtual.getTitulo() + "</td>");
                        out.print("<td>" + livroAtual.getAutor() + "</td>");
                        out.print("<td>" + livroAtual.getDataPublicacao() + "</td>");

                        out.print("<td><a href=\"../ProjetoWeb/LivroController?acao=4&usuario_id=" + loggedInUser + "&livro_id=" + livroAtual.getId() + "\">Emprestar</a></td>");
                        out.print("</tr>");
                    }
                }
                out.print("</table>");
            }
        %>
    </body>
</html>
