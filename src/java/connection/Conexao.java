/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
    private final String bd;
    private final String usuario;
    private final String senha;
    private Connection con; //*

    public Conexao() {
        bd = "jdbc:mysql://localhost/bookflow";
        usuario = "root";
        senha = "root";
        con = null; 
    }

    public Connection estabeleceConexao() throws SQLException {        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(bd, usuario, senha); //*
            return con; //*
        } catch (ClassNotFoundException erro) {
            System.out.println("Erro na conexão: " + erro);
            return null;
        }
    }    
    
    // método novo
    public void fecharConexao(){
        try{
            this.con.close();
        }catch(SQLException e){
            System.out.println(e);
        }
    }
    
}
