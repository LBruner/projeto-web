<%@page import="vo.EmprestimoVO" %>
<%@page import="java.util.List" %>
<%@page import="vo.LivroVO" %>
<%@page import="vo.UsuarioVO" %>
<%@ page import="dao.EmprestimoDAO" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <title>Meus Livros</title>
    <style>
        .book-card {
            transition: all 0.3s ease;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>

<body class="bg-[#fcf0dc]">
<%
    UsuarioVO loggedInUser = (UsuarioVO) session.getAttribute("usuario");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/index.html");
        return;
    }

    int usuarioId = loggedInUser.getId();
    boolean ehAdmin = loggedInUser.getTemAdm();

    EmprestimoDAO eDAO = new EmprestimoDAO();
    List<EmprestimoVO> emprestimos = eDAO.buscarLivrosEmprestados(String.valueOf(usuarioId));
    session.setAttribute("emprestimos", emprestimos);
%>

<div style="background-color: #fcfdfe" class="fixed top-0 flex h-20 w-full items-center justify-center bg-slate-50/50 py-6 shadow backdrop-blur-lg z-50">
    <div class="flex w-full justify-between gap-4 mx-14 items-center">
        <div class="text-2xl w-32 hover:cursor-pointer hover:text-orange-400">
            <span class="text-orange-300 font-light">Book</span><span class="font-bold">Flow</span>
        </div>
        <div class="flex gap-4">
            <a href="./index.jsp" class="text-lg font-semibold hover:text-orange-400 text-orange-400">Home</a>
            <a href="<%= request.getContextPath() %>/LivroController?acao=1" class="text-lg font-semibold hover:text-orange-400">Descobrir</a>
            <% if (ehAdmin) { %>
            <a href="<%= request.getContextPath() %>/LivroController?acao=5" class="text-lg font-semibold hover:text-orange-400">
                Gerenciar Livros
            </a>
            <% } %>
            <form method="post" action="/ProjetoWeb/UsuarioController?acao=3">
                <button class="text-lg font-semibold hover:text-orange-400">Sair</button>
            </form>
        </div>
    </div>
</div>

<div class="mt-32 px-8 pb-8">
        <h1 class="text-2xl mb-4 font-bold mb-8">Meus Empréstimos</h1>
    <% if (emprestimos != null && !emprestimos.isEmpty()) { %>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <% for (EmprestimoVO emprestimoAtual : emprestimos) {
            LivroVO livro = emprestimoAtual.getLivro();
            String imageUrl = livro.getImagemUrl() != null && !livro.getImagemUrl().isEmpty() ?
                    livro.getImagemUrl() :
                    "https://via.placeholder.com/150x200?text=No+Cover";
        %>
        <div class="book-card bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg">
            <div class="h-48 overflow-hidden">
                <img src="<%= imageUrl %>"
                     alt="Capa de <%= livro.getTitulo() %>"
                     class="w-full h-full object-cover">
            </div>

            <div class="p-4">
                <h3 class="text-xl font-bold mb-2 truncate"><%= livro.getTitulo() %></h3>
                <p class="text-gray-600 mb-1"><span class="font-semibold">Autor:</span> <%= livro.getAutor() %></p>
                <p class="text-gray-600 mb-1"><span class="font-semibold">Gênero:</span> <%= livro.getGenero() %></p>

                <div class="mt-4 pt-4 border-t border-gray-100">
                    <p class="text-sm text-gray-500 mb-1">
                        <span class="font-semibold">Empréstimo:</span>
                        <%
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                            String formattedDate = LocalDate.parse(emprestimoAtual.getDataEmprestimo()).format(formatter);
                        %>
                        <%= formattedDate %>
                    </p>
                    <p class="text-sm text-gray-500 mb-1">
                        <span class="font-semibold">Devolução:</span>
                        <%= emprestimoAtual.getDataDevolucao() != null ?
                                emprestimoAtual.getDataDevolucao() : "Pendente" %>
                    </p>
                    <p class="text-sm mb-3">
                        Status:
                        <span class="font-semibold <%= emprestimoAtual.isDevolvido() ? "text-green-500" : "text-orange-500" %>">
                                        <%= emprestimoAtual.isDevolvido() ? "Devolvido" : "Em empréstimo" %>
                                    </span>
                    </p>

                    <% if (!emprestimoAtual.isDevolvido()) { %>
                    <a href="<%= request.getContextPath() %>/LivroController?acao=3&usuario_id=<%= usuarioId %>&chave_emprestimo=<%= livro.getId() %>"
                       class="block w-full mt-2 py-2 px-4 bg-orange-500 hover:bg-orange-600 text-white text-center rounded transition-colors">
                        Devolver Livro
                    </a>
                    <% } %>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="bg-white rounded-lg shadow p-8 text-center">
        <span class="material-icons text-6xl text-gray-300 mb-4">book</span>
        <h3 class="text-xl font-semibold text-gray-600 mb-2">Nenhum empréstimo encontrado</h3>
        <p class="text-gray-500 mb-4">Você não possui livros emprestados no momento.</p>
        <a href="<%= request.getContextPath() %>/LivroController?acao=1"
           class="inline-block px-6 py-2 bg-orange-500 text-white rounded hover:bg-orange-600 transition-colors">
            Encontrar Livros
        </a>
    </div>
    <% } %>
</div>
</body>
</html>