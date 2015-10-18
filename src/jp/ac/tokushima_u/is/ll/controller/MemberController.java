package jp.ac.tokushima_u.is.ll.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import jp.ac.tokushima_u.is.ll.common.orm.Page;
import jp.ac.tokushima_u.is.ll.entity.Item;
import jp.ac.tokushima_u.is.ll.entity.Jplevelwords;
import jp.ac.tokushima_u.is.ll.entity.LoginConfirm;
import jp.ac.tokushima_u.is.ll.entity.Users;
import jp.ac.tokushima_u.is.ll.entity.Usertest;
import jp.ac.tokushima_u.is.ll.form.ItemSearchCondForm;
import jp.ac.tokushima_u.is.ll.security.SecurityUserHolder;
import jp.ac.tokushima_u.is.ll.service.GoogleMapService;
import jp.ac.tokushima_u.is.ll.service.ItemService;
import jp.ac.tokushima_u.is.ll.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private ItemService itemService;
	@Autowired
	private UserService userService;
	@Autowired
	private GoogleMapService googleMapService;

	private static final String DATE_PATTERN = "yyyy-MM-dd HH:mm:ss";
	SimpleDateFormat dateformat = new SimpleDateFormat(DATE_PATTERN);

	@ModelAttribute("googleMapApi")
	public String googleApiKey() {
		return googleMapService.getGoogleMapApi();
	}

	@RequestMapping
	public String index(ModelMap model) {
		Users user = userService.getById(SecurityUserHolder.getCurrentUser()
				.getId());

		ItemSearchCondForm form = new ItemSearchCondForm();
		form.setUserId(user.getId());
		form.setIncludeRelog(true);
		Page<Item> itemPage = itemService.searchItemPageByCond(form);
		model.addAttribute("myitems", itemPage);

		ItemSearchCondForm form2 = new ItemSearchCondForm();
		form2.setAnsweruserId(user.getId());
		Page<Item> answerPage = itemService.searchItemPageByCond(form2);
		model.addAttribute("answeritems", answerPage);
		model.addAttribute("user", user);

		// ■wakebe 経験値の加算(仮)
		userService.addExperiencePoint(user.getId(), 0);

		// ■wakebe 次のレベルまでの経験値取得
		model.addAttribute("nextExperiencePoint",
				this.userService.getNextExperiencePoint(user.getId()));

		// ■wakebe 現在の合計経験値取得
		model.addAttribute("nowExperiencePoint",
				this.userService.getNowExperiencePoint(user.getId()));

		Usertest userid = userService.findById(SecurityUserHolder
				.getCurrentUser().getId());

		LoginConfirm mygoal = userService.getmygoal(userid.getId());

		// 現在日時
		Calendar now = Calendar.getInstance();
		// 目標時間
		Calendar now2 = Calendar.getInstance();

		// Calendarクラスのインスタンスを生成
		Date nowdate = new Date();

		now.setTime(nowdate);

		if (mygoal == null || mygoal.getTotaltime().equals("")) {

		} else {
			//mygoal create time
			Date goaltime = mygoal.getCreate_time();
			now2.setTime(mygoal.getCreate_time());
			now2.add(Calendar.DAY_OF_MONTH,
					Integer.parseInt(mygoal.getTotaltime()));

			// extend deadline
			if (now.after(now2) == true) {
				mygoal.setNowdate(nowdate);
				mygoal.setJplevel("please setting again");
				mygoal.setTotaltime("please setting again");
				mygoal.setOnetime("please setting again");
				mygoal.setTotalword("please setting again");
				mygoal.setOneword("please setting again");
				model.addAttribute("mygoal", mygoal);
			} else {
				mygoal.setNowdate(nowdate);
				String formatDate = dateformat.format(now2.getTime());
				mygoal.setNickname(formatDate);

				model.addAttribute("mygoal", mygoal);

				// all data
				List<Jplevelwords> alljplevelwords = new ArrayList<Jplevelwords>();
				alljplevelwords = itemService
						.getalljplevelwords(userid.getId());
				model.addAttribute("myjplevel", alljplevelwords);

				// one day logs
				List<Jplevelwords> Today = new ArrayList<Jplevelwords>();
				List<Jplevelwords> totalword = new ArrayList<Jplevelwords>();
				Date todaydate = new Date();
				// 現在日時
				Calendar todaytime = Calendar.getInstance();

				todaytime.setTime(todaydate);
				todaytime.set(Calendar.HOUR_OF_DAY, 0);
				todaytime.set(Calendar.SECOND, 0);
				Date indexdate = todaytime.getTime();
				System.out.print(indexdate);
				Today = itemService.gettoday(userid.getId(), indexdate);
				totalword = itemService.gettoday(userid.getId(), goaltime);
				model.addAttribute("todaylogs", Today);
				int todaygoal;
				todaygoal = Integer.parseInt(mygoal.getOneword())
						- Today.size();
				if (todaygoal > 0) {
					model.addAttribute("todayplan", todaygoal
							+ " words to the today goal");
					model.addAttribute("onelog",todaygoal);
				} else {
					model.addAttribute("todayplan", "Today goal clear!!!");
					model.addAttribute("onelog",0);
				}
				
				//残りのログ数
	
				if(Integer.parseInt(mygoal.getTotalword())-totalword.size()>0){
					model.addAttribute("goallog",Integer.parseInt(mygoal.getTotalword())-totalword.size());	
				}
				else{
					model.addAttribute("goallog",0);
				}
				
				
				//目標までのログ数
				
			}
		}
		
		List<LoginConfirm> importance = itemService.getimportance(user.getId());
		model.addAttribute("importance",importance);
		
		return "member/index";
	}
}
