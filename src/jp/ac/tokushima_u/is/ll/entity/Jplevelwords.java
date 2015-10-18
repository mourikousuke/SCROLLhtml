package jp.ac.tokushima_u.is.ll.entity;

import java.util.Date;

public class Jplevelwords {

	private String id;
	private Date create_time; 
	private String content;
	private String kana;
	private String kanji;
	private String level;
	private String leveltotal;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getKana() {
		return kana;
	}
	public void setKana(String kana) {
		this.kana = kana;
	}
	public String getKanji() {
		return kanji;
	}
	public void setKanji(String kanji) {
		this.kanji = kanji;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getLeveltotal() {
		return leveltotal;
	}
	public void setLeveltotal(String leveltotal) {
		this.leveltotal = leveltotal;
	}
	
	
}
