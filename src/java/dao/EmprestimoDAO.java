package dao;

import connection.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import vo.EmprestimoVO;
import vo.LivroVO;

public class EmprestimoDAO {

    public ArrayList<EmprestimoVO> buscarLivrosEmprestados(String usuarioId) {
        PreparedStatement ps; // estrutura o sql
        ResultSet rs; //armazenará o resultado do bd
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql;
                sql = "SELECT l.*, e.id, e.data_emprestimo, e.data_devolucao, devolvido "
                        + "FROM emprestimos e LEFT JOIN livros l ON l.id = e.livro_id "
                        + "WHERE usuario_id = ? AND e.devolvido IS FALSE";
                ps = con.prepareStatement(sql);
                ps.setString(1, usuarioId);
                
                rs = ps.executeQuery();
                ArrayList<EmprestimoVO> lista = new ArrayList<>();
                while (rs.next()) {
                    LivroVO l = new LivroVO();
                    l.setId(rs.getInt("id"));
                    l.setAutor(rs.getString("autor"));
                    l.setTitulo(rs.getString("titulo"));
                    l.setGenero(rs.getString("genero"));
                    l.setImagemUrl(rs.getString("imagem_url"));
                    l.setDataPublicacao(rs.getString("data_publicacao"));
                    l.setId(rs.getInt("e.id"));

                    EmprestimoVO emprestimo = new EmprestimoVO(rs.getInt("e.id"), rs.getString("e.data_emprestimo"), rs.getString("e.data_devolucao"), rs.getBoolean("e.devolvido"), l);
                    lista.add(emprestimo);
                }
                con.close();
                return lista;
            } else {
                return null;
            }
        } catch (SQLException erro) {
            System.err.print("Exceção gerada ao tentar buscar os dados: " + erro.getMessage());
            return null;
        }
    }
    
    public ArrayList<LivroVO> buscarTodosLivros() {
        PreparedStatement ps; // estrutura o sql
        ResultSet rs; //armazenará o resultado do bd
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql;
                sql = "SELECT *"
                        + "FROM livros";
                ps = con.prepareStatement(sql);
                
                rs = ps.executeQuery();
                ArrayList<LivroVO> lista = new ArrayList<>();
                while (rs.next()) {
                    LivroVO l = new LivroVO();
                    l.setId(rs.getInt("id"));
                    l.setAutor(rs.getString("autor"));
                    l.setTitulo(rs.getString("titulo"));
                    l.setGenero(rs.getString("genero"));
                    l.setImagemUrl(rs.getString("imagem_url"));
                    l.setDataPublicacao(rs.getString("data_publicacao"));

                    lista.add(l);
                }
                con.close();
                return lista;
            } else {
                return null;
            }
        } catch (SQLException erro) {
            System.err.print("Exceção gerada ao tentar buscar os dados: " + erro.getMessage());
            return null;
        }
    }
}
