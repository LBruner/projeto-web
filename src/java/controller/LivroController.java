package controller;

import dao.EmprestimoDAO;
import dao.LivroDAO;
import dao.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vo.LivroVO;
import vo.UsuarioVO;

public class LivroController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            int operacao = Integer.parseInt(request.getParameter("acao"));
            LivroDAO lDAO = new LivroDAO();

            switch (operacao) {
                //GET busca livros disponíveis para alugar
                case 1 -> {
                    request.setAttribute("livros_disponiveis", lDAO.buscarTodosLivrosDisponiveis());
                    RequestDispatcher rd = request.getRequestDispatcher("/livros/emprestrar-livros.jsp");
                    rd.forward(request, response);
                }

                //POST Salvar livro
                case 2 -> {
                    LivroVO l = new LivroVO();
                    l.setTitulo(request.getParameter("titulo"));
                    l.setAutor(request.getParameter("autor"));
                    l.setGenero(request.getParameter("genero"));
                    l.setImagemUrl(request.getParameter("imagem"));
                    l.setDataPublicacao(request.getParameter("data"));

                    if (lDAO.gravar(l)) {
                        response.sendRedirect("exibe_resultado.jsp?result=1");
                    } else {
                        response.sendRedirect("exibe_resultado.jsp?result=2");
                    }
                }

//              Devolução de livro;
                case 3 -> {
                    int chaveUsuario = Integer.parseInt(request.getParameter("usuario_id"));
                    int chaveEmprestimo = Integer.parseInt(request.getParameter("chave_emprestimo"));

                    if (lDAO.devolverLivro(chaveEmprestimo)) {
                        UsuarioDAO uDAO = new UsuarioDAO();
                        UsuarioVO usarioLogado = uDAO.pegaUsuario(chaveUsuario);
                        EmprestimoDAO eDAO = new EmprestimoDAO();
                        request.setAttribute("usuario", usarioLogado);
                        request.setAttribute("emprestimos", eDAO.buscarLivrosEmprestados(String.valueOf(usarioLogado.getId())));
                        RequestDispatcher rd = request.getRequestDispatcher("livros/index.jsp");
                        rd.forward(request, response);
                    } else {
                        response.sendRedirect("exibe_resultado.jsp?result=2");
                    }
                }
//              Alugar livro;
                case 4 -> {
                    int chaveUsuario = Integer.parseInt(request.getParameter("usuario_id"));
                    int chaveLivro = Integer.parseInt(request.getParameter("livro_id"));

                    if (lDAO.alugarLivro(chaveUsuario, chaveLivro)) {
                        response.sendRedirect("exibe_resultado.jsp?result=1");
                    } else {
                        response.sendRedirect("exibe_resultado.jsp?result=2");
                    }
                }
//              Gerenciar Livros
                case 5 -> {
                    EmprestimoDAO eDAO = new EmprestimoDAO();
                    request.setAttribute("todos_livros", eDAO.buscarTodosLivros());
                    RequestDispatcher rd = request.getRequestDispatcher("/livros/gerenciar-livros.jsp");
                    rd.forward(request, response);
                }
//              Mostrar Editar Livros
                case 6 -> {
                    int livroId = Integer.parseInt(request.getParameter("livro_id"));

                    EmprestimoDAO eDAO = new EmprestimoDAO();
                    request.setAttribute("livro", lDAO.buscarUmLivro(String.valueOf(livroId)));
                    RequestDispatcher rd = request.getRequestDispatcher("/livros/editar-livro.jsp");
                    rd.forward(request, response);
                }

//              Editar Livros
                case 7 -> {
                    int livroId = Integer.parseInt(request.getParameter("id"));
                    String titulo = request.getParameter("titulo");
                    String autor = request.getParameter("autor");
                    String editora = request.getParameter("editora");
                    String imagemUrl = request.getParameter("imagem_url");
                    String dataPublicacao = request.getParameter("data_publicacao");
                    int quantidadeTotal = Integer.parseInt(request.getParameter("quantidade_total"));

                    LivroVO livroParaEditar = new LivroVO();
                    livroParaEditar.setId(livroId);
                    livroParaEditar.setTitulo(titulo);
                    livroParaEditar.setAutor(autor);
                    livroParaEditar.setImagemUrl(imagemUrl);
                    livroParaEditar.setGenero(editora);
                    livroParaEditar.setDataPublicacao(dataPublicacao);

                    if (lDAO.editarLivro(livroParaEditar)) {
                        response.sendRedirect("exibe_resultado.jsp?result=1");
                    } else {
                        response.sendRedirect("exibe_resultado.jsp?result=2");
                    }
                }
                
//              Editar Livros
                case 8 -> {
                    int livroId = Integer.parseInt(request.getParameter("livro_id"));

                    if (lDAO.deletarLivro(livroId)) {
                        response.sendRedirect("exibe_resultado.jsp?result=1");
                    } else {
                        response.sendRedirect("exibe_resultado.jsp?result=2");
                    }
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
