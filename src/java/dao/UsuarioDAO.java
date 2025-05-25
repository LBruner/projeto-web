/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;

import connection.Conexao;

import vo.UsuarioVO;

public class UsuarioDAO {

    public UsuarioVO gravar(UsuarioVO u) {
        try {
            Conexao conexao = new Conexao();
            Connection con = conexao.estabeleceConexao();
            if (con != null) {
                PreparedStatement ps;
                String sql = "INSERT INTO usuarios (nome, email, senha, adm) VALUES (?, ?, ?, ?)";
                ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                ps.setString(1, u.getNome());
                ps.setString(2, u.getEmail());
                ps.setString(3, u.getSenha());
                ps.setBoolean(4, u.getTemAdm());

                int resultado = ps.executeUpdate();

                if (resultado > 0) {
                    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int id = generatedKeys.getInt(1);
                            u.setId(id);
                        }
                    }
                }

                conexao.fecharConexao();
                return u;
            } else {
                return null;
            }
        } catch (SQLException erro) {
            System.out.println("Exceção causada na inserção: " + erro);
            return null;
        }
    }

    public UsuarioVO fazerLogin(UsuarioVO u) {
        PreparedStatement ps; // estrutura o sql
        ResultSet rs; //armazenará o resultado do bd
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql = "select id, nome, email, adm from usuarios WHERE email = ? AND senha = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, u.getEmail());
                ps.setString(2, u.getSenha());

                UsuarioVO usuarioLogado = null;
                rs = ps.executeQuery();
                if (rs.next()) {
                    usuarioLogado = new UsuarioVO();
                    usuarioLogado.setId(rs.getInt("id"));
                    usuarioLogado.setNome(rs.getString("nome"));
                    usuarioLogado.setEmail(rs.getString("email"));
                    usuarioLogado.setTemAdm(rs.getBoolean("adm"));
                }
                con.close();

                return usuarioLogado;
            } else {
                return null;
            }
        } catch (SQLException erro) {
            System.err.print("Exceção gerada ao tentar buscar os dados: " + erro.getMessage());
            return null;
        }
    }

    public UsuarioVO pegaUsuario(int usuarioId) {
        PreparedStatement ps; // estrutura o sql
        ResultSet rs; //armazenará o resultado do bd
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql = "select id, nome, email, telefone from usuarios WHERE id = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, String.valueOf(usuarioId));

                UsuarioVO usuarioLogado = null;
                rs = ps.executeQuery();
                if (rs.next()) {
                    usuarioLogado = new UsuarioVO();
                    usuarioLogado.setId(rs.getInt("id"));
                    usuarioLogado.setNome(rs.getString("nome"));
                    usuarioLogado.setEmail(rs.getString("email"));
                }
                con.close();

                return usuarioLogado;
            } else {
                return null;
            }
        } catch (SQLException erro) {
            System.err.print("Exceção gerada ao tentar buscar os dados: " + erro.getMessage());
            return null;
        }
    }
}
