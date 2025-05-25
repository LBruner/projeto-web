package vo;

public class UsuarioVO {
    private int id;
    private String nome;
    private String email;
    private String senha;
    private Boolean temAdm;

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNome() {
        return nome;
    }

    public String getEmail() {
        return email;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getSenha() {
        return senha;
    }

    public void setTemAdm(Boolean temAdm) {
        this.temAdm = temAdm;
    }

    public Boolean getTemAdm() {
        return temAdm;
    }
}
