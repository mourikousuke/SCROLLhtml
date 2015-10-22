package jp.ac.tokushima_u.is.ll.ws.service.model;

import java.io.Serializable;


public class BookModel implements Serializable {

    private String isbn;
    private String title;

    public BookModel(String isbn, String title){
    	this.isbn = isbn;
    	this.title = title;
    }

    public void setIsbn(String str){
    	this.isbn=str;
    }

    public void setTitle(String str){
    	this.title=str;
    }
    public String getIsbn(){
    	return this.isbn;
    }

    public String getTitle(){
    	return this.title;
    }
}
