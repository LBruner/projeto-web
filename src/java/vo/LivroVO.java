package vo;

public class LivroVO {

    private int id;
    private String titulo;
    private String autor;
    private String editora;
    private int quantidadeTotal;
    private int quantidadeDisponivel;
    private String dataPublicacao;
    private String imagemUrl;

    public void setQuantidadeDisponivel(int quantidadeDisponivel) {
        this.quantidadeDisponivel = quantidadeDisponivel;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }
    
    public void setImagemUrl(String imagemUrl) {
        this.imagemUrl = imagemUrl;
    }

    public String getImagemUrl() {
        return imagemUrl;
    }

    public void setEditora(String editora) {
        this.editora = editora;
    }

    public void setQuantidadeTotal(int quantidadeTotal) {
        this.quantidadeTotal = quantidadeTotal;
    }

    public void setDataPublicacao(String dataPublicacao) {
        this.dataPublicacao = dataPublicacao;
    }

    public int getId() {
        return id;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getAutor() {
        return autor;
    }

    public String getEditora() {
        return editora;
    }

    public int getQuantidadeTotal() {
        return quantidadeTotal;
    }

    public int getQuantidadeDisponivel() {
        return quantidadeDisponivel;
    }

    public String getDataPublicacao() {
        return dataPublicacao;
    }

}
