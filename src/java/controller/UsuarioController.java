package controller;

import dao.EmprestimoDAO;
import dao.UsuarioDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vo.EmprestimoVO;
import vo.UsuarioVO;

public class UsuarioController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            int operacao = Integer.parseInt(request.getParameter("acao"));
            UsuarioDAO uDAO = new UsuarioDAO();

            switch (operacao) {
                //Criar usuário
                case 1 -> {
                    UsuarioVO u = new UsuarioVO();
                    u.setNome(request.getParameter("nome"));
                    u.setTelefone(request.getParameter("telefone"));
                    u.setEmail(request.getParameter("email"));
                    u.setSenha(request.getParameter("senha"));

                    if (uDAO.gravar(u)) {
                        response.sendRedirect("exibe_resultado.jsp?result=1");
                    } else {
                        response.sendRedirect("exibe_resultado.jsp?result=2");
                    }
                }
                //Login
                case 2 -> {
                    UsuarioVO u = new UsuarioVO();
                    u.setEmail(request.getParameter("email"));
                    u.setSenha(request.getParameter("senha"));

                    EmprestimoDAO eDAO = new EmprestimoDAO();
                    UsuarioVO usuarioLogado = uDAO.fazerLogin(u);

                    if (usuarioLogado != null) {
                        // Store everything in session
                        HttpSession session = request.getSession();
                        session.setAttribute("usuario_id", String.valueOf(usuarioLogado.getId()));
                        session.setAttribute("usuario", usuarioLogado);
                        List<EmprestimoVO> emprestimos = eDAO.buscarLivrosEmprestados(String.valueOf(usuarioLogado.getId()));
                        session.setAttribute("emprestimos", emprestimos);
                        response.sendRedirect(request.getContextPath() + "/livros/index.jsp");
                    } else {
                        response.sendRedirect("exibe_resultado.jsp?result=2");
                    }
                }
                //Logout
                case 3 -> {
                    HttpSession session = request.getSession();
                    session.removeAttribute("usuario_id");
                    session.removeAttribute("usuario");
                    session.removeAttribute("emprestimos");
                    response.sendRedirect("index.html");
                }

//                //Listagem dos dados
//                case 2 -> {
//                    request.setAttribute("lista", cDAO.buscarCarros());
//                    RequestDispatcher rd = request.getRequestDispatcher("/exibe_carros.jsp");
//                    rd.forward(request, response);
//                }
//
//                //Exclusão dos dados
//                case 3 -> {
//                    int id = Integer.parseInt(request.getParameter("chave"));
//                    if (cDAO.excluir(id)) {
//                        response.sendRedirect("exibe_resultado.jsp?result=1");
//                    } else {
//                        response.sendRedirect("exibe_resultado.jsp?result=2");
//                    }
//                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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
