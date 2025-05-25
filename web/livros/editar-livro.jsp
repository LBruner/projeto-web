<%@page import="vo.LivroVO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page import="vo.UsuarioVO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Editar Livro</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="output.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>


    <body class="">
    <%
        UsuarioVO loggedInUser = (UsuarioVO) session.getAttribute("usuario");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        boolean ehAdmin = loggedInUser.getTemAdm();
    %>

    <div style="background-color: #fcf0dc" class="mt-18 flex h-screen w-full flex-col">
        <div class="fixed h-20 top-0 items-center justify-center shadow flex w-full bg-slate-50/50 py-6 backdrop-blur-lg">
            <div class="flex w-full justify-between gap-4 mx-14 items-center">
                <div class="text-2xl w-32 hover:cursor-pointer hover:text-orange-400"><span
                        class="text-orange-300 font-light">Book</span><span class="font-bold">Flow</span></div>
                <div class="flex gap-4">
                    <div>
                        <a href="./index.jsp" class="hover:cursor-pointer hover:text-orange-400 font-semibold text-lg">Home</a>
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


        <%
            LivroVO livroAtual = (LivroVO) request.getAttribute("livro");
            if (livroAtual != null) {
        %>
        <button class="border border-orange-200 fixed left-6 top-16 mt-8 flex items-center gap-2 rounded-lg bg-white px-4 py-2 text-lg hover:cursor-pointer hover:border-orange-400" onclick="history.back()">
            <span class="material-icons text-orange-300">arrow_back</span>
            <p class="text-orange-300">Voltar</p>
        </button>

        <form action="../ProjetoWeb/LivroController?acao=7" method="POST" class="mt-12 flex justify-center">
            <input type="hidden" name="id" value="<%= livroAtual.getId()%>">
            <div class="flex w-8/12 flex-col gap-4 rounded-lg bg-white p-12 shadow-lg">
                <div>
                    <p class="text-3xl font-bold">Editar Livro</p>
                </div>
                <div class="flex flex-col">
                    <label class="text-lg font-semibold" for="titulo">Título</label>
                    <input required name="titulo" maxlength="150" class="border-b border-b-gray-300 pt-1 pb-2 text-lg transition-all duration-500 ease-in-out focus:border-b-orange-200 focus:outline-none" id="titulo" type="text" value="<%= livroAtual.getTitulo() != null ? livroAtual.getTitulo() : ""%>" />
                </div>
                <div class="flex flex-col">
                    <label class="text-lg font-semibold" for="autor">Autor</label>
                    <input name="autor" maxlength="100" class="border-b border-b-gray-300 pt-1 pb-2 text-lg transition-all duration-500 ease-in-out focus:border-b-orange-200 focus:outline-none" id="autor" type="text" value="<%= livroAtual.getAutor() != null ? livroAtual.getAutor() : ""%>" />
                </div>
                <div class="flex flex-col">
                    <label class="text-lg font-semibold" for="imagem_url">Imagem</label>
                    <input required name="imagem_url" maxlength="150" class="border-b border-b-gray-300 pt-1 pb-2 text-lg transition-all duration-500 ease-in-out focus:border-b-orange-200 focus:outline-none" id="imagem_url" type="text" value="<%= livroAtual.getImagemUrl()!= null ? livroAtual.getImagemUrl() : ""%>" />
                </div>
                <div class="flex flex-col">
                    <label class="text-lg font-semibold" for="data_publicacao">Data de Publicação</label>
                    <input class="border-b border-b-gray-200 py-2 focus:border-b-orange-200 focus:outline-none" type="date" name="data_publicacao" id="data_publicacao" value="<%= livroAtual.getDataPublicacao()%>"/>
                </div>
                <div class="flex flex-col">
                    <label class="text-lg font-semibold" for="editora">Gênero</label>
                    <select class="block w-full appearance-none rounded border-b border-gray-300 bg-white py-3 pr-8 text-gray-700 focus:border-orange-300 focus:bg-white focus:outline-none" name="genero" id="genero">
                        <option value="Aventura" <%= "Aventura".equals(livroAtual.getGenero()) ? "selected" : "" %>>Aventura</option>
                        <option value="Fantasia" <%= "Fantasia".equals(livroAtual.getGenero()) ? "selected" : "" %>>Fantasia</option>
                        <option value="Terror" <%= "Terror".equals(livroAtual.getGenero()) ? "selected" : "" %>>Terror</option>
                        <option value="Romance" <%= "Romance".equals(livroAtual.getGenero()) ? "selected" : "" %>>Romance</option>
                    </select>
                </div>
                <div class="flex justify-center">
                    <button class="hover:cursor-pointer w-full mt-6 py-4 px-2 bg-orange-300 hover:bg-orange-400 text-white font-semibold text-lg rounded-lg flex justify-center" type="submit">
                        Salvar Alterações
                    </button>
                </div>
            </div>
        </form>
        <%
        } else {
        %>
        <div class="mt-12 flex justify-center">
            <div class="flex w-8/12 flex-col gap-4 rounded-lg bg-white p-12 shadow-lg">
                <p class="text-lg">Livro não encontrado para edição.</p>
            </div>
        </div>
        <%
            }
        %>
    </div>
    </body>

    </html>