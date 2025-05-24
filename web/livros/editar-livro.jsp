<%@page import="vo.LivroVO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <title>Editar Livro</title>
    </head>
    <body>

        <%
            LivroVO livroAtual = (LivroVO) request.getAttribute("livro");
            if (livroAtual != null) {
        %>
        <button onclick="history.back()">Voltar</button>

        <form action="../ProjetoWeb/LivroController?acao=7" method="POST">
            <input type="hidden" name="id" value="<%= livroAtual.getId()%>">

            <div>
                <label for="titulo">Título:</label>
                <input type="text" id="titulo" name="titulo" maxlength="150" required value="<%= livroAtual.getTitulo() != null ? livroAtual.getTitulo() : ""%>">
            </div>
            
             <div>
                <label for="imagem">URL de Imagem:</label>
                <input type="text" id="imagem" name="imagem_url" maxlength="150" required value="<%= livroAtual.getImagemUrl()!= null ? livroAtual.getImagemUrl() : ""%>">
            </div>

            <div>
                <label for="autor">Autor:</label>
                <input type="text" id="autor" name="autor" maxlength="100" value="<%= livroAtual.getAutor() != null ? livroAtual.getAutor() : ""%>">
            </div>

            <div>
                <label for="data_publicacao">Data de Publicação:</label>
                <input type="date" id="data_publicacao" name="data_publicacao" value="<%= livroAtual.getDataPublicacao()%>">
            </div>

            <div>
                <label for="editora">Editora:</label>
                <input type="text" id="editora" name="editora" maxlength="100" value="<%= livroAtual.getEditora() != null ? livroAtual.getEditora() : ""%>">
            </div>

            <div>
                <label for="quantidade_total">Quantidade Total:</label>
                <input type="number" id="quantidade_total" name="quantidade_total" min="1" step="1" value="<%= livroAtual.getQuantidadeTotal()%>" required>
            </div>

            <div>
                <button type="submit">Salvar Alterações</button>
            </div>
        </form>
        <%
        } else {
        %>
        <p>Livro não encontrado para edição.</p>
        <%
            }
        %>
    </body>
</html>