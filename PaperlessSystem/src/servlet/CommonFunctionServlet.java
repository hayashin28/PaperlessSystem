package servlet;

import static common.DbCommonFunctions.*;
import static common.Enum.functionkbn.*;
import static dao.TenkenListDao.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import logger.logger;
import net.sf.json.JSONArray;

/**
 *
 * @author H.Hayashi
 *
 */
public class CommonFunctionServlet extends HttpServlet implements logger {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	final Logger logger = Logger.getLogger("CommonFunctionServlet");

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		response.setHeader("Cache-Control", "private");

		try {

			int funckbn = Integer.parseInt(request.getParameter("functionkbn"));
			Object param = request.getParameter("parameter");
			JSONArray json = null;
			/**
			 *
			 */
			if (funckbn == getPBLayoutDiagram.ordinal()) {
				param = getPBLayoutDiagram((String)param);
				List<String> array =  Arrays.asList((String)param);
				json = JSONArray.fromObject(array);
			}
			else if (funckbn == getItemName.ordinal()) {
				param = getItemName((String)param);
				List<String> array =  Arrays.asList((String)param);
				json = JSONArray.fromObject(array);
			}
			else if (funckbn == getPKG.ordinal()) {
				param = getPKG((String)param);
				List<String> array =  Arrays.asList((String)param);
				json = JSONArray.fromObject(array);
			}
			else if (funckbn == getSeries.ordinal()) {
				param = getSeries((String)param);
				List<String> array =  Arrays.asList((String)param);
				json = JSONArray.fromObject(array);
			}
			else if (funckbn == getEquipErrorMsg.ordinal()) {
				param = getEquipErrorMsg((String)param);
				List<String> array =  Arrays.asList((String)param);
				json = JSONArray.fromObject(array);
			}
			else if (funckbn == getSinrai.ordinal()) {
				param = getSinrai((String)param);
				List<String> array =  Arrays.asList((String)param);
				json = JSONArray.fromObject(array);
			}
			//
			else {
				ArrayList<Hashtable<String, String>> list = null;
				/**
				 *
				 */
				if (funckbn == getLastTenkenData.ordinal()) {
					list = getInstance().findLast(Arrays.asList(((String)param).split(",")));
				}
				/**
				 *
				 */
				else if (funckbn == getLastCleaningDateWB.ordinal()) {
					list = getInstance().findLastCleaningDate(Arrays.asList(((String)param).split(",")));
				}
				/**
				 *
				 */
				else if (funckbn == getLastCleaningData.ordinal()) {
					Timestamp time	 = getServerTime();
					Calendar calendar= Calendar.getInstance();
					calendar.setTimeInMillis(time.getTime());
					list = getInstance().findLastCleaningData(Arrays.asList(((String)param + "," + calendar.get(Calendar.YEAR) + "," +  (calendar.get(Calendar.MONTH) + 1)).split(",")));
				}
				//
				else {
					//続く…
				}
				json = JSONArray.fromObject(list);
			}
	        response.getOutputStream().write(json.toString().getBytes("UTF-8"));

		} catch (Exception e) {
			logger.warning(e.getLocalizedMessage());
			return;
		}
	}
}