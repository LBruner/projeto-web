package vo;

public class EmprestimoVO {

    private int id;
    private LivroVO livro;
    private UsuarioVO usuario;
    private String dataEmprestimo;
    private String dataDevolucao;
    private boolean devolvido;

    public EmprestimoVO(int id, String dataEmprestimo, String dataDevolucao, boolean devolvido, LivroVO livro) {
        this.id = id;
        this.livro = livro;
        this.dataEmprestimo = dataEmprestimo;
        this.dataDevolucao = dataDevolucao;
        this.devolvido = devolvido;
    }

    public void setDevolvido(boolean devolvido) {
        this.devolvido = devolvido;
    }

    public boolean isDevolvido() {
        return devolvido;
    }

    public int getEmprestimoId() {
        return id;
    }

    public void setDataEmprestimo(String dataEmprestimo) {
        this.dataEmprestimo = dataEmprestimo;
    }

    public void setDataDevolucao(String dataDevolucao) {
        this.dataDevolucao = dataDevolucao;
    }

    public String getDataEmprestimo() {
        return dataEmprestimo;
    }

    public String getDataDevolucao() {
        return dataDevolucao;
    }

    public void setLivro(LivroVO livro) {
        this.livro = livro;
    }

    public void setUsuario(UsuarioVO usuario) {
        this.usuario = usuario;
    }

    public int getId() {
        return id;
    }

    public LivroVO getLivro() {
        return livro;
    }

    public UsuarioVO getUsuario() {
        return usuario;
    }

}
