package model;

import java.util.Date;

/**
 * Classe utilizada para modelar os projetos do sistema...
 *
 * @author Cezar Augusto Crummenauer
 */
public class Projeto {

    private int id;
    private String nome;
    private Date dataCriacao;
    private String descricao;
    private String conteudo;
    private String situacao;

    public Projeto() {

    }

    public Projeto(String nome, Date dataCriacao, String descricao, String conteudo, String situacao) {
        this.nome = nome;
        this.dataCriacao = dataCriacao;
        this.descricao = descricao;
        this.conteudo = conteudo;
        this.situacao = situacao;
    }

    public Projeto(int id, String nome, Date dataCriacao, String descricao, String conteudo, String situacao) {
        this.id = id;
        this.nome = nome;
        this.dataCriacao = dataCriacao;
        this.descricao = descricao;
        this.conteudo = conteudo;
        this.situacao = situacao;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Date getDataCriacao() {
        return dataCriacao;
    }

    public void setDataCriacao(Date dataCriacao) {
        this.dataCriacao = dataCriacao;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getConteudo() {
        return conteudo;
    }

    public void setConteudo(String conteudo) {
        this.conteudo = conteudo;
    }

    public String getSituacao() {
        return situacao;
    }

    public void setSituacao(String situacao) {
        this.situacao = situacao;
    }
}
