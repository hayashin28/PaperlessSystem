package servlet;
import static common.CommonFunctions.*;
import static common.Enum.savekbn.*;
import static dao.TenkenListDao.*;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.TenkenListBean;
import logger.logger;


/***
 *
 * @author H.Hayashi
 *
 */
public class TenkenListServlet extends HttpServlet implements logger {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	final Logger logger = Logger.getLogger("TenkenListServlet");

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("UTF-8");

		//long count = 0;
		List<String> elements;
		String  setuB	 = new String();	//装置No
		String  lotNo	 = new String();	//ロットNo
		String  sheet	 = new String();	//シート名
		String  week  	 = new String();	//曜日
		String  tanname  = new String();	//処理担当名
		String  connect	 = new String();	//通信判定
		Integer savekbn	 = null;			//保存区分
		Integer tenkenNo = null;			//点検No

		try {
			TenkenListBean bean = null;
			List<TenkenListBean> lst = new ArrayList<TenkenListBean>();

			Calendar calendar = Calendar.getInstance();

			elements = Arrays.asList(request.getParameter("params").split(","));
			setuB	 = join(request.getParameterValues("Setubi"));
			lotNo	 = join(request.getParameterValues("Lot"));
			sheet	 = join(request.getParameterValues("sheetnm"));
			tanname	 = join(request.getParameterValues("tanname"));
			connect	 = join(request.getParameterValues("connect"));
			savekbn  = intCast(request.getParameter("savekbn"));

			for (String element : elements) {
				String[] data = element.split(";");
				if ("Setubi".equals(data[0]) || "Lot".equals(data[0])) continue;
				if ("Week".equals(data[0])) week = data[1];

				bean = new TenkenListBean();

				/* 点検Noの確定 */
				tenkenNo= savekbn==Saved.ordinal() || !"ajax".equals(connect) ? getInstance().nextTenkenNo(Arrays.asList(new Object[]{sheet, calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1})) : 0;

				bean.setSyubetuNo(0);											//種別No
				bean.setTenkenKbn(0);											//点検区分
				bean.setSetubiNo(setuB);										//設備No
				bean.setgLotID(lotNo);											//LOTID
				bean.setSheetNm(sheet);											//シート名
				bean.setTagNm(data[0]);											//タグ名
				bean.setDataVal((data.length < 2) ? "/" : data[1]);				//データ値
				bean.setHanteiRes("");											//判定結果
				bean.setHanteiSel("");											//判定選定
				bean.setHanteiVal("");											//判定値
				bean.setTenkenYear(calendar.get(Calendar.YEAR));				//点検年
				bean.setTenkenMonth(calendar.get(Calendar.MONTH) + 1);			//点検月
				bean.setTenkenDay(calendar.get(Calendar.DATE));					//点検日
				bean.setTenkenShift(0);											//点検シフト
				bean.setTenkenNo(tenkenNo);										//点検No
				bean.setKaisu(0);												//処置回数
				bean.setOutputFlg(0);											//出力フラグ
				bean.setTantouNm(tanname);										//処理担当者名
				bean.setSaveDate(new Timestamp(calendar.getTime().getTime()));	//保存日時

				/* 保存種別を指定 */
				int status = savekbn==Saved.ordinal()?Saved.ordinal() :
								getInstance().getTenkenDataStatus(
										Arrays.asList(savekbn==TmpSaved.ordinal() ? new Object[]{bean.getSetubiNo(),bean.getSheetNm(),bean.getTagNm()} : new Object[]{bean.getSetubiNo(),bean.getSheetNm(),bean.getTagNm(),bean.getTenkenYear(),bean.getTenkenMonth()}),
										savekbn==TmpSaved.ordinal() ? TmpSaved : TmpSavedIncludingDate);
				bean.setSvStatus(status);
				lst.add(bean);
			}
			getInstance().execQuery(lst, savekbn);
		} catch (SQLException e) {
			logger.warning(e.getLocalizedMessage());
		} finally {
			try {
				/** セッションに設備Noを格納する */
				HttpSession session = request.getSession();
				session.setAttribute("setuB", setuB);	//装置No
				session.setAttribute("Week",  week);	//曜日
				/** 呼出し元に遷移する */
				response.sendRedirect(new URI(request.getHeader("referer")).getPath());
			} catch (URISyntaxException e) {
				logger.warning(e.getLocalizedMessage());
			}
		}

//		/** ヘッダ情報から呼出し元URLを取得 */
//		String referer = request.getHeader("referer");
//		int idx = referer.indexOf(request.getContextPath());
//		idx+=request.getContextPath().length();
//		String url=referer.substring(idx);
//		/** 呼出し元に遷移する */
//		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
//		dispatcher.forward(request, response);
	}

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
	}
}