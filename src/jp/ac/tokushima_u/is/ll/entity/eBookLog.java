package jp.ac.tokushima_u.is.ll.entity;

import java.sql.Date;
import java.sql.Time;

public class eBookLog {

	private String id; // ログID
	private Date date; // 日付
	private Time time; //時刻
	private String userid; //ユーザID
	private String booktitle; //書籍名
	private String actioncode; //アクション名
	private Integer chapternumber; //章番号
	private Integer pagenumber; //ページ番号
	private String device; //端末名
	private String target; //対象
	private String classcode; //授業コード
	private Integer windowwidth; //ウィンドウサイズ_幅
	private Integer windowheight; //ウィンドウサイズ_高さ
	private String browsername; //ブラウザー名

	//----------------------------------------------
	//    Getter
	//----------------------------------------------

	public String getId() {
		return this.id;
	}
	public Date getDate() {
		return this.date;
	}
	public Time getTime() {
		return this.time;
	}
	public String getUserId() {
		return this.userid;
	}
	public String getBookTitle() {
		return this.booktitle;
	}
	public String getActionCode() {
		return this.actioncode;
	}
	public Integer getChapterNumber() {
		return this.chapternumber;
	}
	public Integer getPageNumber() {
		return this.pagenumber;
	}
	public String getDevice() {
		return this.device;
	}
	public String getTarget() {
		return this.target;
	}
	public String getClassCode() {
		return this.classcode;
	}
	public Integer getWindowWidth() {
		return this.windowwidth;
	}
	public Integer getWindowHeight() {
		return this.windowheight;
	}
	public String getBrowserName() {
		return this.browsername;
	}

	//----------------------------------------------
	//    Setter
	//----------------------------------------------


	public void setId(String str) {
		this.id = str;
	}
	public void setDate(Date d) {
		this.date = d;
	}
	public void setTime(Time t) {
		this.time = t;
	}
	public void setUserId(String str) {
		this.userid = str;
	}
	public void setBookTitle(String str) {
		this.booktitle = str;
	}
	public void setActionCode(String str) {
		this.actioncode = str;
	}
	public void setChapterNumber(Integer cn) {
		this.chapternumber = cn;
	}
	public void setPageNumber(Integer pn) {
		this.pagenumber = pn;
	}
	public void setDevice(String str) {
		this.device = str;
	}
	public void setTarget(String str) {
		this.target = str;
	}
	public void setClassCode(String str) {
		this.classcode = str;
	}
	public void setWindowWidth(Integer ww) {
		this.windowwidth = ww;
	}
	public void setWindowHeight(Integer wh) {
		this.windowheight = wh;
	}
	public void setBrowserName(String str) {
		this.browsername = str;
	}
}
