<%@page import="vo.EmprestimoVO" %>
<%@page import="java.util.List" %>
<%@page import="vo.LivroVO" %>
<%@page import="vo.UsuarioVO" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="styles.css">
    <title>Meus Livros</title>
</head>

<body class="">
<div  style="background-color: #fcf0dc" class="mt-18 flex h-screen w-full flex-col">
    <%
        UsuarioVO loggedInUser = (UsuarioVO) session.getAttribute("usuario");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        int usuarioId = loggedInUser.getId();
        boolean ehAdmin = loggedInUser.getTemAdm();
    %>

    <div class="fixed h-20 top-0 items-center justify-center shadow flex w-full bg-slate-50/50 py-6 backdrop-blur-lg">
        <div class="flex w-full justify-between gap-4 mx-14 items-center">
            <div class="text-2xl w-32 hover:cursor-pointer hover:text-orange-400"><span
                    class="text-orange-300 font-light">Book</span><span class="font-bold">Flow</span></div>
            <div class="flex gap-4">
                <div>
                    <a href="./index.jsp" class="hover:cursor-pointer hover:text-orange-400 font-semibold text-orange-500 text-lg">Home</a>
                </div>
                <div>
                    <a href="<%= request.getContextPath() %>/LivroController?acao=1" class="hover:cursor-pointer hover:text-orange-400 font-semibold  text-lg">Descobrir</a>
                </div>
                <% if (ehAdmin) { %>
                <div>
                    <a href="<%= request.getContextPath() %>/LivroController?acao=5"
                       class="hover:cursor-pointer hover:text-orange-400 font-semibold text-lg">
                        Gerenciar Livros
                    </a>
                </div>
                <% } %>
                <form method="post" action="/ProjetoWeb/UsuarioController?acao=3">
                    <button class="text-lg font-semibold hover:cursor-pointer hover:text-orange-400">Sair</button>
                </form>
            </div>
        </div>
    </div>

    <button><a href="<%= request.getContextPath() %>/LivroController?acao=1">Encontrar Livros</a></button>
    <button><a href="<%= request.getContextPath() %>/LivroController?acao=5">Gerenciar Livros</a></button>

    <p>User ID: <%= loggedInUser.getId() %>
    </p>
    <p>Name: <%= loggedInUser.getNome() %>
    </p>
    <p>Email: <%= loggedInUser.getEmail() %>
    </p>

    <%
        List<EmprestimoVO> emprestimos = (List<EmprestimoVO>) session.getAttribute("emprestimos");
        if (emprestimos != null && !emprestimos.isEmpty()) {
    %>
    <br><br><br>
    <table width="50%" border="1" cellspacing="0" align="center">
        <%
            for (EmprestimoVO emprestimoAtual : emprestimos) {
        %>
        <tr>
            <td><%= emprestimoAtual.getLivro().getTitulo() %>
            </td>
            <td><%= emprestimoAtual.getLivro().getAutor() %>
            </td>
            <td><%= emprestimoAtual.getLivro().getDataPublicacao() %>
            </td>
            <td><%= emprestimoAtual.getDataEmprestimo() %>
            </td>
            <td><%= emprestimoAtual.getDataDevolucao() %>
            </td>
            <td><%= emprestimoAtual.isDevolvido() %>
            </td>
            <td>
                <a href="<%= request.getContextPath() %>/LivroController?acao=3&usuario_id=<%= usuarioId %>&chave_emprestimo=<%= emprestimoAtual.getLivro().getId() %>">
                    Devolver
                </a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <%
    } else {
    %>
    <p>Nenhum empréstimo encontrado.</p>
    <%
        }
    %>
</body>

</html>