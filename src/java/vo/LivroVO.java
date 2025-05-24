package vo;

public class LivroVO {

    private int id;
    private String titulo;
    private String autor;
    private String genero;
    private String dataPublicacao;
    private String imagemUrl;

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

    public String getGenero() {
        return genero;
    }

    public void setGenero(String editora) {
        this.genero = editora;
    }

    public void setDataPublicacao(String dataPublicacao) {
        this.dataPublicacao = dataPublicacao;
    }

    public int getId() {
        return id;
    }

    public String getTitulo() { return titulo; }

    public String getAutor() {
        return autor;
    }

    public String getDataPublicacao() {
        return dataPublicacao;
    }

}
