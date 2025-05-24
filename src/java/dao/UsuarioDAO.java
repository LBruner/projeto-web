/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import connection.Conexao;

import java.sql.ResultSet;

import vo.UsuarioVO;

public class UsuarioDAO {

    public boolean gravar(UsuarioVO u) {
        try {
            Conexao conexao = new Conexao();
            Connection con = conexao.estabeleceConexao();
            if (con != null) {
                PreparedStatement ps;
                String sql = "insert into usuarios (nome, email, senha, telefone) values (?, ?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, u.getNome());
                ps.setString(2, u.getEmail());
                ps.setString(3, u.getSenha());
                ps.setString(4, u.getTelefone());

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

    public UsuarioVO fazerLogin(UsuarioVO u) {
        PreparedStatement ps; // estrutura o sql
        ResultSet rs; //armazenará o resultado do bd
        Connection con; //conexão com o bd

        try {
            Conexao conexao = new Conexao();
            con = conexao.estabeleceConexao();
            if (con != null) {
                String sql = "select id, nome, email, telefone from usuarios WHERE email = ? AND senha = ?";
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
                    usuarioLogado.setTelefone(rs.getString("telefone"));
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
                    usuarioLogado.setTelefone(rs.getString("telefone"));
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
