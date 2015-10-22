package jp.ac.tokushima_u.is.ll.form;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class eBookSearchForm implements Serializable {

	private String keyword; // 検索キーワード
	private String selected; // 選択した書籍のタイトル
	private String epubpath; // ePubファイルを置いておくディレクトリのパス
	private List<String> titlelist; // ディレクトリ内で見つかったePubのタイトルリスト
	private List<String> hittitlelist; // titlelistの内、検索の結果キーワードが一致したタイトルのリスト
	private Integer titlenum; // ディレクトリ内で見つかったePubファイルの数
	private Integer hittitlenum; // 検索の結果ヒットしたタイトルの数

	public eBookSearchForm(){
		this.titlelist = new ArrayList<String>();
		this.hittitlelist = new ArrayList<String>();
	}

	public void setKeyword(String str) {
		this.keyword = str;
	}
	public void setSelected(String str){
		this.selected = str;
	}
	public void setEpubPath(String str){
		this.epubpath = str;
	}
	public void addTitleList(String str){
		this.titlelist.add(str);
	}
	public void addHitTitleList(String str){
		this.hittitlelist.add(str);
	}
	public void setTitleNum(Integer num){
		this.titlenum = num;
	}
	public void setHitTitleNum(Integer num){
		this.hittitlenum = num;
	}


	public String getKeyword(){
		return this.keyword;
	}
	public String getSelected(){
		return this.selected;
	}
	public String getEpubPath(){
		return this.epubpath;
	}
	public List<String> getTitleList(){
		return this.titlelist;
	}
	public List<String> getHitTitleList(){
		return this.hittitlelist;
	}
	public Integer getTitleNum(){
		return this.titlenum;
	}
	public Integer getHitTitleNum(){
		return this.hittitlenum;
	}
}