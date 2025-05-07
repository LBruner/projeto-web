package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import connection.Conexao;
import java.util.ArrayList;
import vo.LivroVO;
import java.sql.ResultSet;

public class LivroDAO {

    public boolean gravar(LivroVO l) {
        try {
            Conexao conexao = new Conexao();
            Connection con = conexao.estabeleceConexao();
            if (con != null) {
                PreparedStatement ps;
                String sql = "insert into livros (titulo, autor, data_publicacao, editora, quantidade_total,  quantidade_disponivel, imagem_url) values (?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, l.getTitulo());
                ps.setString(2, l.getAutor());
                ps.setString(3, l.getDataPublicacao());
                ps.setString(4, l.getEditora());
                ps.setString(5, String.valueOf(l.getQuantidadeTotal()));
                ps.setString(6, String.valueOf(l.getQuantidadeDisponivel()));
                ps.setString(7, String.valueOf(l.getImagemUrl()));

                int resultado = ps.executeUpdate();
                conexao.fecharConexao();
                return resultado != 0;
            } else {
                return false;
            }
        } catch (SQLException erro) {
            System.out.println("Exceção causada na inserção: " + erro);
            return false;
        }
    }

    public ArrayList<LivroVO> buscarTodosLivrosDisponiveis() {
        PreparedStatement ps; // estrutura o sql
        ResultSet rs; //armazenará o resultado do bd
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql = "SELECT * FROM livros l WHERE NOT EXISTS (  SELECT 1  FROM emprestimos e WHERE e.livro_id = l.id AND e.devolvido = FALSE);";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                ArrayList<LivroVO> lista = new ArrayList<>();
                while (rs.next()) {
                    LivroVO l = new LivroVO();
                    l.setId(rs.getInt("id"));
                    l.setAutor(rs.getString("autor"));
                    l.setTitulo(rs.getString("titulo"));
                    l.setEditora(rs.getString("editora"));
                    l.setImagemUrl(rs.getString("imagem_url"));
                    l.setDataPublicacao(rs.getString("data_publicacao"));
                    l.setQuantidadeTotal(rs.getInt("quantidade_total"));
                    l.setQuantidadeDisponivel(rs.getInt("quantidade_disponivel"));

                    System.err.println("oi");
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

    public LivroVO buscarUmLivro(String livroId) {
        PreparedStatement ps; // estrutura o sql
        ResultSet rs; //armazenará o resultado do bd
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql = "SELECT * FROM livros WHERE id = ? LIMIT 1;";
                ps = con.prepareStatement(sql);
                ps.setString(1, livroId);
                rs = ps.executeQuery();

                LivroVO livro = new LivroVO();
                while (rs.next()) {
                    livro.setId(rs.getInt("id"));
                    livro.setAutor(rs.getString("autor"));
                    livro.setTitulo(rs.getString("titulo"));
                    livro.setEditora(rs.getString("editora"));
                    livro.setImagemUrl(rs.getString("imagem_url"));
                    livro.setDataPublicacao(rs.getString("data_publicacao"));
                    livro.setQuantidadeTotal(rs.getInt("quantidade_total"));
                    livro.setQuantidadeDisponivel(rs.getInt("quantidade_disponivel"));
                }

                con.close();
                return livro;
            } else {
                return null;
            }
        } catch (SQLException erro) {
            System.err.print("Exceção gerada ao tentar buscar os dados: " + erro.getMessage());
            return null;
        }
    }

    public boolean alugarLivro(int chaveUsuario, int chaveLivro) {
        PreparedStatement ps; // estrutura o sql        
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql = "INSERT INTO emprestimos (usuario_id, livro_id) VALUES (?, ?)";
                ps = con.prepareStatement(sql);
                ps.setInt(1, chaveUsuario);
                ps.setInt(2, chaveLivro);
                int resultado = ps.executeUpdate();
                con.close();
                return resultado != 0;
            } else {
                return false;
            }
        } catch (SQLException erro) {
            return false;
        }
    }

    public boolean devolverLivro(int chaveEmprestimo) {
        PreparedStatement ps; // estrutura o sql        
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql = "UPDATE emprestimos SET devolvido = TRUE WHERE id = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, chaveEmprestimo);
                int resultado = ps.executeUpdate();
                con.close();
                return resultado != 0;
            } else {
                return false;
            }
        } catch (SQLException erro) {
            return false;
        }
    }

    public boolean editarLivro(LivroVO livro) {
        PreparedStatement ps; // estrutura o sql
        ResultSet rs; //armazenará o resultado do bd
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql = "UPDATE livros set titulo = ?, autor = ?, editora = ?, data_publicacao = ?, quantidade_total = ?, "
                        + "quantidade_disponivel = ?, imagem_url = ? WHERE id = ?";
                ps = con.prepareStatement(sql);
                System.err.println("AQUI");
                System.err.println(livro.getTitulo());

                ps.setString(1, livro.getTitulo());
                ps.setString(2, livro.getAutor());
                ps.setString(3, livro.getEditora());
                ps.setString(4, livro.getDataPublicacao());
                ps.setInt(5, livro.getQuantidadeTotal());
                ps.setInt(6, livro.getQuantidadeDisponivel());
                ps.setString(7, livro.getImagemUrl());
                ps.setInt(8, livro.getId());

                int resultado = ps.executeUpdate();

                con.close();
                return resultado != 0;
            } else {
                return false;
            }
        } catch (SQLException erro) {
            System.out.println("Exceção causada na edição: " + erro);
            return false;
        }
    }

    public boolean deletarLivro(int livroId) {
        PreparedStatement ps; // estrutura o sql
        ResultSet rs; //armazenará o resultado do bd
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql = "DELETE FROM livros WHERE id = ?";
                ps = con.prepareStatement(sql);

                ps.setInt(1, livroId);

                int resultado = ps.executeUpdate();

                con.close();
                return resultado != 0;
            } else {
                return false;
            }
        } catch (SQLException erro) {
            System.out.println("Exceção causada na deleção: " + erro);
            return false;
        }
    }
}
