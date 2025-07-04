<%@ page import="vo.UsuarioVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="pt">
<head>
    <title>Adicionar Livro</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../output.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>

<body class="">
<%
    UsuarioVO loggedInUser = (UsuarioVO) session.getAttribute("usuario");

    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/index.html");
        return;
    }

    int usuarioId = loggedInUser.getId();
    boolean ehAdmin = loggedInUser.getTemAdm();
%>

<div  style="background-color: #fcf0dc" class="mt-18 flex h-screen w-full flex-col">
    <div class="fixed h-20 top-0 items-center justify-center shadow flex w-full bg-slate-50/50 py-6 backdrop-blur-lg">
        <div class="flex w-full justify-between gap-4 mx-14 items-center">
            <div class="text-2xl w-32 hover:cursor-pointer hover:text-orange-400"><span
                    class="text-orange-300 font-light">Book</span><span class="font-bold">Flow</span></div>
            <div class="flex gap-4">
                <div>
                    <a href="./index.jsp" class="hover:cursor-pointer hover:text-orange-400 font-semibold text-lg">Home</a>
                </div>
                <div>
                    <a href="<%= request.getContextPath() %>/LivroController?acao=1" class="hover:cursor-pointer hover:text-orange-400 font-semibold text-lg">Descobrir</a>
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
    <button class="border border-orange-200 fixed left-6 top-16 mt-8 flex items-center gap-2 rounded-lg bg-white px-4 py-2 text-lg hover:cursor-pointer hover:border-orange-400" onclick="history.back()">
        <span class="material-icons text-orange-300">arrow_back</span>
        <p class="text-orange-300">Voltar</p>
    </button>

    <form action="../LivroController?acao=2" method="POST" class="mt-12 flex justify-center">
        <div class="flex w-8/12 flex-col gap-4 rounded-lg bg-white p-12 shadow-lg">
            <div>
                <p class="text-3xl font-bold">Novo Livro</p>
            </div>
            <div class="flex flex-col">
                <label class="text-lg font-semibold" for="titulo">Título</label>
                <input required name="titulo" placeholder="Os Códigos do Milhão" class="border-b border-b-gray-300 pt-1 pb-2 text-lg transition-all duration-500 ease-in-out focus:border-b-orange-200 focus:outline-none" id="titulo" type="text" />
            </div>
            <div class="flex flex-col">
                <label class="text-lg font-semibold" for="autor">Autor</label>
                <input required name="autor" placeholder="Pablo Marçal" class="border-b border-b-gray-300 pt-1 pb-2 text-lg transition-all duration-500 ease-in-out focus:border-b-orange-200 focus:outline-none" id="autor" type="text" />
            </div>
            <div class="flex flex-col">
                <label class="text-lg font-semibold" for="imagem">Imagem</label>
                <input required name="imagem" placeholder="https://www.heroui.com/images/album-cover.png" class="border-b border-b-gray-300 pt-1 pb-2 text-lg transition-all duration-500 ease-in-out focus:border-b-orange-200 focus:outline-none" id="imagem" type="text" />
            </div>
            <div class="flex flex-col">
                <label class="text-lg font-semibold" for="data">Data de Publicação</label>
                <input required class="border-b border-b-gray-200 py-2 focus:border-b-orange-200 focus:outline-none" type="date" name="data" id="data"/>
            </div>
            <div class="flex flex-col">
                <label class="text-lg font-semibold" for="genero">Gênero</label>
                <div class="relative mt-1 inline-block w-full">
                    <select class="block w-full appearance-none rounded border-b border-gray-300 bg-white py-3 pr-8text-gray-700 focus:border-orange-300 focus:bg-white focus:outline-none" name="genero" id="genero">
                        <option name="Aventura">Aventura</option>
                        <option name="Fantasia">Fantasia</option>
                        <option name="Terror">Terror</option>
                        <option name="Romance">Romance</option>
                    </select>
                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                        <svg class="h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                            <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
                        </svg>
                    </div>
                </div>
            </div>
            <div class="flex justify-center">
                <button class="hover:cursor-pointer w-full mt-6 py-4 bg-orange-300 hover:bg-orange-400 text-white font-semibold text-lg rounded-lg flex justify-center" type="submit">
                    Adicionar Livro
                </button>
            </div>
        </div>
    </form>
</div>
</body>

</html>