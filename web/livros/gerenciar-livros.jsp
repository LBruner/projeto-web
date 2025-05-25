<%@page import="vo.LivroVO" %>
<%@page import="java.util.List" %>
<%@ page import="vo.UsuarioVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="output.css">
    <title>Gerenciar Livros</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
</head>

<%
    UsuarioVO loggedInUser = (UsuarioVO) session.getAttribute("usuario");

    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/index.html");
        return;
    }

    boolean ehAdmin = loggedInUser.getTemAdm();
%>

<body class="h-screen" style="background-color: #fcf0dc">
<div  class="">
    <div class="mt-18 flex h-screen w-full flex-col">
        <nav style="background-color: #fcfdfe" class="fixed h-20 top-0 items-center justify-center shadow flex w-full bg-slate-50/50 py-6 backdrop-blur-lg">
            <div class="flex w-full justify-between gap-4 mx-14 items-center">
                <div class="text-2xl w-32 hover:cursor-pointer hover:text-orange-400">
                    <span class="text-orange-300 font-light">Book</span><span class="font-bold">Flow</span>
                </div>
                <div class="flex gap-4">
                    <div>
                        <a href="./livros/index.jsp"
                           class="hover:cursor-pointer hover:text-orange-400 font-semibold text-lg">Home</a>
                    </div>
                    <div>
                        <a href="<%= request.getContextPath() %>/LivroController?acao=1"
                           class="hover:cursor-pointer hover:text-orange-400 font-semibold text-lg">Descobrir</a>
                    </div>
                    <% if (ehAdmin) { %>
                    <div>
                        <a href="<%= request.getContextPath() %>/LivroController?acao=5"
                           class="hover:cursor-pointer hover:text-orange-400 font-semibold text-lg text-orange-400">
                            Gerenciar Livros
                        </a>
                    </div>
                    <% } %>
                    <form method="post" action="/ProjetoWeb/UsuarioController?acao=3">
                        <button class="text-lg font-semibold hover:cursor-pointer hover:text-orange-400">Sair</button>
                    </form>
                </div>
            </div>
        </nav>

        <div class="mt-12 flex w-full flex-col items-center justify-center shadow">
            <div class="h-16 border-b border-b-gray-200 w-10/12 bg-white rounded-t-lg px-6 py-8 flex justify-between items-center">
                <p class="text-xl font-bold">Lista de Livros</p>
                <%
                    List<?> todosLivros = (List<?>) request.getAttribute("todos_livros");
                    if (todosLivros != null) {
                %>
                <%
                } else {
                %>
                <p class="font-light">0 livros encontrados</p>
                <%
                    }
                %>
                <a type="submit"
                        class="hover:cursor-pointer py-2 px-2 bg-orange-400 text-orange-50 font-semibold text-md rounded-lg flex justify-center"
                        href="./livros/adicionar-livro.jsp">Adicionar livro
                </a>
            </div>

            <%
                if (todosLivros != null && !todosLivros.isEmpty()) {
            %>
            <table class="table-fixed w-10/12 border-collapse  bg-white">
                <thead>
                <tr class="text-center">
                    <th class="p-3 text-lg font-normal text-gray-600">ID</th>
                    <th class="p-3 text-lg font-normal text-gray-600">Título</th>
                    <th class="p-3 text-lg font-normal text-gray-600">Autor</th>
                    <th class="p-3 text-lg font-normal text-gray-600">Imagem</th>
                    <th class="p-3 text-lg font-normal text-gray-600">Gênero</th>
                    <th class="p-3 text-lg font-normal text-gray-600">Data</th>
                    <th class="p-3 text-lg font-normal text-gray-600">Ações</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Object obj : todosLivros) {
                        if (obj instanceof LivroVO) {
                            LivroVO livroAtual = (LivroVO) obj;
                            String imageUrl = livroAtual.getImagemUrl();
                            if (imageUrl == null || imageUrl.trim().isEmpty()) {
                                imageUrl = "placeholder-book-image.png";
                            }
                %>
                <tr class="hover:bg-gray-50">
                    <td class="border-y border-y-gray-200 p-4 text-center font-semibold text-blue-950"><%= livroAtual.getId() %>
                    </td>
                    <td class="border-y border-y-gray-200 p-4 text-center font-semibold text-blue-950">
                        <%= livroAtual.getTitulo() != null ? livroAtual.getTitulo() : "Título Desconhecido" %>
                    </td>
                    <td class="border-y border-y-gray-200 p-4 text-center font-semibold text-blue-950">
                        <%= livroAtual.getAutor() != null ? livroAtual.getAutor() : "Autor Desconhecido" %>
                    </td>
                    <td class="border-y border-y-gray-200 p-4 text-center font-semibold text-blue-950">
                        <div class="flex justify-center">
                            <img class="h-auto w-12 rounded-lg shadow transition-all duration-300 hover:rounded-none ease-in-out hover:scale-150 hover:z-10 hover:shadow-lg"
                                 src="<%= imageUrl %>"
                                 alt="Capa do livro: <%= livroAtual.getTitulo() %>" />
                        </div>
                    </td>
                    <td class="border-y border-y-gray-200 p-4 text-center font-semibold text-blue-950">
                        <%= livroAtual.getGenero() != null ? livroAtual.getGenero() : "Gênero Desconhecido" %>
                    </td>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        String formattedDate = LocalDate.parse(livroAtual.getDataPublicacao()).format(formatter);
                    %>
                    <td class="border-y border-y-gray-200 p-4 text-center font-semibold text-blue-950">
                        <%= formattedDate %>
                    </td>
                    <td class="border-y border-y-gray-200 p-4 text-center font-semibold text-blue-950">
                        <a href="../ProjetoWeb/LivroController?acao=6&livro_id=<%= livroAtual.getId() %>"
                           class="hover:cursor-pointer">
                            <span class="material-icons text-lg text-blue-400 hover:text-blue-600">edit_note</span>
                        </a>
                        <a href="../ProjetoWeb/LivroController?acao=8&livro_id=<%= livroAtual.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir este livro?');"
                           class="hover:cursor-pointer">
                            <span class="material-icons ml-1 text-lg text-red-400 hover:text-red-600">delete</span>
                        </a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
            <div class="rounded-b-lg border-b border-b-gray-200 w-10/12 bg-white px-6 mb-12 py-4 flex justify-between items-center">
                <p class="font-normal"><%= todosLivros.size() %> livros encontrados</p>
            </div>
            <%
            } else {
            %>
            <div class="w-10/12 rounded-b-lg bg-white p-8 text-center">
                <p class="text-gray-500">Nenhum livro encontrado.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
</html>