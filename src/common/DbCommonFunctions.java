package common;

import static db.DataHandler.*;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;

import db.DBMS;

/**
 *
 * @author H.Hayashi
 *
 */
public class DbCommonFunctions {

	private DbCommonFunctions(){}

	/**
	 * DBMSサーバの現在時刻を取得する
	 * @return
	 * @throws SQLException
	 */
	public static Timestamp getServerTime() {
		try {
			HashMap<String, Object> map = select("SELECT NOW()", DBMS.atlas.ordinal());
			return (Timestamp) map.get("now");
		} catch (Exception e) {
			e.printStackTrace();
			return new Timestamp(new Date().getTime());
		}
	}

	/**
	 * LotNoからPBレイアウト図を取得する
	 * @return
	 */
	public static String getPBLayoutDiagram(String kLot) {
		ArrayList<Hashtable<String, String>> list;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT KOMOKUDATA ");
		sql.append("FROM( ");
		sql.append("	SELECT ROW_NUMBER() OVER() AS NUM, KOMOKUDATA ");
		sql.append("	FROM ");
		sql.append("	(SELECT KOMOKUDATA FROM PUBLIC.JYOKENDATA WHERE KLOTNO=? AND KOMOKUNAME LIKE 'PB-LAYOUT図%') AS t ");
		sql.append(") AS t ");
		sql.append("WHERE NUM=1 ");
		list = select(sql.toString(), Arrays.asList(kLot.replaceFirst("%L", "")), DBMS.lsi_db.ordinal());
		return list.get(0).get("komokudata");
	}

	/**
	 * LotNoから品名を取得する
	 * @return
	 */
	public static String getItemName(String kLot) {
		ArrayList<Hashtable<String, String>> list;
		String sql = "SELECT KOMOKUDATA FROM PER.JYOKENDATA WHERE KLOTNO=? AND KOMOKUNAME='品名'";
		list = select(sql, Arrays.asList(kLot.replaceFirst("%L", "")), DBMS.atlas.ordinal());
		if (list != null && 0 < list.size()) return list.get(0).get("komokudata");
		list = select(sql.replaceFirst("PER.", "PUBLIC."), Arrays.asList(kLot.replaceFirst("%L", "")), DBMS.lsi_db.ordinal());
		return list.get(0).get("komokudata");
	}

	/**
	 * LotNoからPKGを取得する
	 * @return
	 */
	public static String getPKG(String kLot) {
		ArrayList<Hashtable<String, String>> list;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT T.GAIKEI1 || T.GAIKEI2 || T.GAIKEI3 AS KOMOKUDATA ");
		sql.append("FROM( ");
		sql.append("	SELECT ");
		sql.append("	 ARRAY_TO_STRING(ARRAY_AGG(CASE WHEN KOMOKUNAME like '製品外形1' THEN KOMOKUDATA ELSE '' END),'') AS GAIKEI1 ");
		sql.append("	,ARRAY_TO_STRING(ARRAY_AGG(CASE WHEN KOMOKUNAME like '製品外形2' THEN KOMOKUDATA ELSE '' END),'') AS GAIKEI2 ");
		sql.append("	,ARRAY_TO_STRING(ARRAY_AGG(CASE WHEN KOMOKUNAME like '製品外形3' THEN KOMOKUDATA ELSE '' END),'') AS GAIKEI3 ");
		sql.append("	FROM PER.JYOKENDATA ");
        sql.append("    WHERE KLOTNO=? ");
		sql.append(") AS t ");
		list = select(sql.toString(), Arrays.asList(kLot.replaceFirst("%L", "")), DBMS.atlas.ordinal());
		if (0 < list.size()) return list.get(0).get("komokudata");
		list = select(sql.toString().replaceFirst("PER.", "PUBLIC."), Arrays.asList(kLot.replaceFirst("%L", "")), DBMS.lsi_db.ordinal());
		return list.get(0).get("komokudata");
	}

	/**
	 * 装置IDから装置シリーズを取得する。
	 * @param equip_ID
	 * @return
	 */
	public static String getSeries(String equip_ID) {
		ArrayList<Hashtable<String, String>> list;
		String sql = "SELECT SERIES FROM KAD.T_EQUIP_REG WHERE EQUIP_ID=? AND (BIT_LENGTH(SERIES)<>0 AND SERIES IS NOT NULL) ";
		list = select(sql.toString(), Arrays.asList(equip_ID.replaceFirst("%M", "")), DBMS.atlas.ordinal());
		return list.get(0).get("series");
	}

	/**
	 *
	 * @param equip_ID
	 * @return
	 */
	public static String getEquipErrorMsg(String equip_Data) {

		String[] params = equip_Data.replaceAll("%M", "").split(",");
		ArrayList<Hashtable<String, String>> list;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT MESSAGES ");
		sql.append("FROM KAD.T_ERR_CODE_INFO ");
		sql.append("WHERE CODE=? ");
		sql.append("AND ERR_INFO_ID = (SELECT ERR_INFO_ID FROM KAD.T_EQUIP_REG WHERE EQUIP_ID=?)");

		list = select(sql.toString(), Arrays.asList(params), DBMS.atlas.ordinal());
		return list.get(0).get("messages");
	}

	/**
	 * LotNoから信頼度区分を取得する。
	 * @param kLot
	 * @return
	 */
	public static String getSinrai(String kLot) {
		ArrayList<Hashtable<String, String>> list;
		String sql = "SELECT KOMOKUDATA FROM PER.JYOKENDATA WHERE KLOTNO=? AND KOMOKUNAME='信頼度区分' ";
		list = select(sql.toString(), Arrays.asList(kLot.replaceFirst("%L", "")), DBMS.atlas.ordinal());
		if (list != null && 0 < list.size()) return "Sinrai," + list.get(0).get("komokudata");
		list = select(sql.toString().replaceFirst("PER.", "PUBLIC."), Arrays.asList(kLot.replaceFirst("%L", "")), DBMS.lsi_db.ordinal());
		return list.get(0).get("komokudata");
	}

	/**
	 * 不良カテゴリの名称を取得する。
	 * @return
	 */
	public static String getCategoryName() {
		ArrayList<Hashtable<String, String>> list;
		String sql = "SELECT CATEGORY_NAME FROM TRA.T_NG_CATEGORY_INFO WHERE EQUIP_TYPE=6";
		list = select(sql, null, DBMS.atlas.ordinal());
		StringBuilder lst = new StringBuilder();
		for (int i = 0, count = list.size(); i < count; i++) { lst.append(list.get(0).get("category_name")).append("|"); }
		// インデックスを指定して削除して表示
		return lst.deleteCharAt(lst.lastIndexOf("|")).toString();
	}

	/*
	//格納したデータをすべて表示する
	for (int i = 0; i < sss.size(); i++) {
		//データi件目のフィールド名リストを取得
		Enumeration<String> keyList = sss.get(i).keys();
		System.out.println("---------- " + (i+1) + "件目データ ----------");
		while(keyList.hasMoreElements()) {
			//フィールド名取得
			String key = (String)keyList.nextElement();
			//データ出力
			System.out.println(key + ":" + sss.get(i).get(key));
		}
	}
*/
}
