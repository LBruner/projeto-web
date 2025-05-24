<%@page import="vo.LivroVO" %>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="output.css">
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/gsap.min.js"></script>
    <title>BookFlow - Descobrir</title>
</head><%
    HttpSession currentSession = request.getSession();
    String loggedInUser = "";

    if (currentSession.getAttribute("usuario_id") instanceof String) {
        loggedInUser = (String) currentSession.getAttribute("usuario_id");
    }

    List livrosDisponiveis = (List) request.getAttribute("livros_disponiveis");

    if (livrosDisponiveis != null && !livrosDisponiveis.isEmpty()) {
%>
<body class="">
<div  style="background-color: #fcf0dc" class="mt-18 flex h-screen w-full flex-col">
    <div class="fixed top-0 items-center justify-center shadow flex w-full bg-slate-50/50 py-6 backdrop-blur-lg">
        <div class="flex w-full justify-between gap-4 mx-14 items-center">
            <div class="text-2xl w-32 hover:cursor-pointer hover:text-orange-400"><span
                    class="text-orange-300 font-light">Book</span><span class="font-bold">Flow</span></div>
            <div class="flex gap-4">
                <div>
                    <a href="./livros/index.jsp" class="hover:cursor-pointer hover:text-orange-400  font-semibold text-lg">Home</a>
                </div>
                <div>
                    <a href="<%= request.getContextPath() %>/LivroController?acao=1" class="hover:cursor-pointer hover:text-orange-400 text-orange-500 font-semibold text-lg">Descobrir Livros</a>
                </div>
                <form method="post" action="/ProjetoWeb/UsuarioController?acao=3">
                    <button class="text-lg font-semibold hover:cursor-pointer hover:text-orange-400">Sair</button>
                </form>
            </div>
        </div>
    </div>

    <div class="mx-14 my-8 flex h-auto flex-col items-center justify-center gap-8 rounded-lg bg-slate-50 px-8 py-6 shadow-sm mb-12">
        <div class="flex w-full justify-between">
            <p class="text-2xl font-bold text-gray-800">Recomendados</p>
            <p class="rounded-lg bg-blue-100 px-4 py-2 font-bold text-blue-500 shadow hover:cursor-pointer hover:bg-blue-200 hover:text-blue-600">Ver Todos ></p>
        </div>
        <div class="grid grid-cols-6 gap-8 justify-items-center">
            <%
                for (int cont = 0; cont < livrosDisponiveis.size(); cont++) {
                    if (livrosDisponiveis.get(cont) instanceof LivroVO) {
                        LivroVO livroAtual = (LivroVO) livrosDisponiveis.get(cont);
            %>
            <div class="livro-card w-64 rounded-lg shadow-lg hover:cursor-pointer bg-white overflow-hidden transition-transform duration-300 hover:scale-105">
                <div class="rounded-t-md py-4 flex justify-center bg-gray-100">
                    <img class="rounded h-44 object-contain"
                         src="<%= livroAtual.getImagemUrl() %>"
                         alt="Capa do Livro <%= livroAtual.getTitulo() %>"
                         loading="lazy" />
                </div>
                <div class="px-4 py-2 flex flex-col gap-3">
                    <p class="line-clamp-1 text-xl font-bold text-ellipsis"><%= livroAtual.getTitulo() %></p>
                    <p class="font-light text-gray-600">Autor: <%= livroAtual.getAutor() %></p>
                    <div class="flex justify-center w-full items-center">
                        <a href="../ProjetoWeb/LivroController?acao=4&usuario_id=<%= loggedInUser %>&livro_id=<%= livroAtual.getId() %>"
                           class="w-10/12 font-semibold text-center mt-2 bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition-colors duration-200">
                            Emprestar
                        </a>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
<%
    }
%>


</html>
