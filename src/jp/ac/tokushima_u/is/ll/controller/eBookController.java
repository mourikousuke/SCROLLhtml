package jp.ac.tokushima_u.is.ll.controller;



import java.io.File;
import java.util.ArrayList;
import java.util.List;

import jp.ac.tokushima_u.is.ll.form.eBookSearchForm;
import jp.ac.tokushima_u.is.ll.service.ItemService;
import jp.ac.tokushima_u.is.ll.service.TaskService;
import jp.ac.tokushima_u.is.ll.service.UserService;
import jp.ac.tokushima_u.is.ll.ws.service.model.BookModel;
import jp.ac.tokushima_u.is.ll.ws.service.model.OptionsModel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/ebook") // ルート
public class eBookController {

	private static String ePubFilesPath = "C:/ebook/epub/"; //ePubファイルの入っているディレクトリのパス

	@Autowired
	private UserService userService;

	@Autowired
	private TaskService taskService;

	@Autowired
	private ItemService itemService;

	@ModelAttribute
	public eBookSearchForm setUpSearchForm(){ // eBookSearchFormをモデルに付加(モデルからeBookSearchFormと同じ要素が利用可能に)
		eBookSearchForm booksearch = new eBookSearchForm();
		return booksearch;
	}
	@ModelAttribute
	public OptionsModel setUpOptionsModel(){
		OptionsModel optionsModel = new OptionsModel();
		return optionsModel;
	}
	@ModelAttribute
	public BookModel setUpBook(){
		BookModel book = new BookModel("","");
		return book;
	}

	@RequestMapping
	public String index(ModelMap model) { // 上記のルートにアクセスしたときに呼ばれるメソッド
		return "ebook/index"; // ebook/index.jspをレンダリング
	}

	@RequestMapping(value="/reading/bookselect") // ebook/reading/bookselectにアクセスすると呼ばれるメソッド
	public String bookSelect(eBookSearchForm form,  ModelMap model) {

		List<BookModel> books = new ArrayList<>();
		Integer id = 0;
		model.addAttribute("keyword", form.getKeyword()); // eBookSearchForm.javaのkeyword要素を取得
		if(form.getKeyword()!=""){ //キーワードが空文字でない
			getEpubFiles(form); //epub一覧を取得
			List<String> titles = new ArrayList<String>();
			titles = form.getTitleList();
			for(int i = 0; i < titles.size(); i++){ //取得できたepubファイルの数だけループ
				String title = titles.get(i); //順にタイトルを参照
				if(title.indexOf(form.getKeyword()) != -1){ //キーワードに対してタイトルが部分一致したものを抜き出してhittitlelistに追加
					form.addHitTitleList("hittitlelist");
					books.add(new BookModel("id", title));
					id++;
				}
			}
		}
		if(id != 0){
			model.addAttribute("books", books);
			return "ebook/reading/bookselect"; //一冊でも見つかれば選択画面へ
		}else{
			return "ebook/index"; //一冊も見つからない場合indexへ
		}
	}

	@RequestMapping(value="/reading/viewer")
	public String openViewer(eBookSearchForm form,  ModelMap model) {;
		model.addAttribute("selected", form.getSelected());
		return "ebook/reading/viewer";
	}

	public static void getEpubFiles(eBookSearchForm form) {
	    String path = ePubFilesPath;
	    File dir = new File(path);
	    File[] files = dir.listFiles();
	    if(dir.isDirectory()){
	    	for (int i = 0; i < files.length; i++) {
	    		String orgTitle = files[i].getName();
	    		String[] splitTitle = orgTitle.split("\\."); // [0]:タイトル、[1]拡張子に分割
	    		if(splitTitle[1].equals("epub")) //拡張子がepubならタイトルリストに登録
	    			form.addTitleList(splitTitle[0]);
	    	}
	    }else{
	    	System.out.println("not found : Check ePubFilesPath.");
	    }
	}
}