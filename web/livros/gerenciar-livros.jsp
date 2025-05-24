<%@page import="vo.LivroVO"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%> 
<%@page import="java.time.format.DateTimeFormatter"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="output.css">
        <title>Gerenciar Livros</title>

    </head>
    <body>
        <button onclick="history.back()">Return to Previous Page</button>
        <button><a href="/ProjetoWeb/livros/adicionar-livro.html">Adicionar Livro</a></button>
        <h2>Gerenciar Livros</h2>

        <%
            List<?> todosLivros = (List<?>) request.getAttribute("todos_livros");

            if (todosLivros != null) {
        %>
    <center>Achados: <%= todosLivros.size()%></center><br><br>

    <div class="books-grid">
        <%
            for (Object obj : todosLivros) {
                if (obj instanceof LivroVO) {
                    LivroVO livroAtual = (LivroVO) obj;
        %>
        <div class="book-card">
            <div class="card-image">
                <%
                    String imageUrl = livroAtual.getImagemUrl();
                    if (imageUrl == null || imageUrl.trim().isEmpty()) {
                        imageUrl = "placeholder-book-image.png";
                    }
                %>
                <img src="<%= imageUrl%>" alt="Capa do Livro: <%= livroAtual.getTitulo()%>">
            </div>
            <div class="card-content">
                <p style="font-size: 28px; font-weight: bold;"><%= livroAtual.getTitulo() != null ? livroAtual.getTitulo() : "Título Desconhecido"%></p>
                <div class="card-info">
                    <div style="display: flex; flex-direction: column; gap: 15px;">
                        <span><strong>Autor:</strong></span>
                        <span><%= livroAtual.getAutor() != null ? livroAtual.getAutor() : "Autor Desconhecido"%></span>
                        <span><strong>Editora:</strong></span>
                        <span><%= livroAtual.getGenero() != null ? livroAtual.getGenero() : "Gênero Desconhecido"%></span>
                        <span><strong>Data de Publicação:</strong></span>
                        <span><%= livroAtual.getDataPublicacao()%></span>
                    </div>
                </div>
                <div class="card-actions">
                    <a href="../ProjetoWeb/LivroController?acao=6&livro_id=<%= livroAtual.getId()%>"><button>Editar</button></a>
                    <a href="../ProjetoWeb/LivroController?acao=8&livro_id=<%= livroAtual.getId()%>"
                       onclick="return confirm('Tem certeza que deseja excluir este livro?');"><button id="excluit-btn">Excluir</button></a>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>

    <%
    } else {
    %>
    <p>Nenhum livro encontrado.</p>
    <%
        }
    %>
</body>
</html>