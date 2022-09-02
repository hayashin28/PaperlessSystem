package dao;

import static common.Enum.savekbn.*;
import static common.Enum.statuskbn.*;
import static common.Enum.statuskbn.update;
import static db.DataHandler.*;
import static db.DataHandler.update;
import static entity.TenkenListEntity.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Hashtable;
import java.util.List;

import bean.TenkenListBean;
import bean.TenkenListBeanMapping;
import common.Enum.savekbn;
import common.Enum.statuskbn;
import db.DBMS;
import db.DbConnection;

/**
 *
 * @author H.Hayashi
 *
 */
public class TenkenListDao {

	/***
	 * このクラスのインスタンスを取得する。
	 * @return
	 */
	public static TenkenListDao getInstance() {
		return new TenkenListDao();
	}

	/***
	 * 全件検索を行う。
	 * @return TenkenListオブジェクトを格納したList
	 * @throws SQLException
	 */
	public List<TenkenListBean> findAll() throws SQLException {

		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * ");
		sql.append("FROM " + L_TENKENLIST);
		return select(sql.toString(), null, new TenkenListBeanMapping(), DBMS.atlas.ordinal());
	}

	/**
	 *
	 * @param params
	 * @return
	 */
	public ArrayList<Hashtable<String, String>> findLast(List<? extends Object> params) {
		StringBuilder sql = new StringBuilder();

		sql.append("SELECT " + TAGNM + "," + DATAVAL + HALFSPACE);
		sql.append("FROM " 	 + L_TENKENLIST + HALFSPACE);
		sql.append("WHERE "	 + SYUBETUNO + "=0 ");
		sql.append("AND " 	 + SETUBINO  + "=CAST(? AS VARCHAR) ");
		sql.append("AND " 	 + SHEETNM   + "=? ");
		sql.append("AND "	 + TENKENNO  + " IN ");
		sql.append("( ");
		sql.append("	SELECT MAX("+ TENKENNO +") ");
		sql.append("	FROM "	+ L_TENKENLIST + HALFSPACE);
		sql.append("	WHERE " + SYUBETUNO	   + "=0 ");
		sql.append("	AND "	+ SETUBINO	   + "=CAST(? AS VARCHAR) ");
		sql.append("	AND "	+ SHEETNM	   + "=? ");
		sql.append("	AND TO_DATE(''|| " + TENKENYEAR + " || " + TENKENMONTH + " || " + TENKENDAY + ",'yyyyMMdd') IN ");
		sql.append("	( ");
		sql.append("		SELECT MAX(TO_DATE(''|| " + TENKENYEAR + " || " + TENKENMONTH + " || " + TENKENDAY + ",'yyyyMMdd')) ");
		sql.append("		FROM "  + L_TENKENLIST + HALFSPACE);
		sql.append("		WHERE " + SYUBETUNO + "=0 ");
		sql.append("		AND "	+ SETUBINO  + "=CAST(? AS VARCHAR) ");
		sql.append("		AND "	+ SHEETNM 	+ "=? ");
		sql.append("	) ");
		sql.append(") ");

		return select(sql.toString(), params, DBMS.atlas.ordinal());
	}

	/**
	 *
	 * @param params
	 * @return
	 */
	public ArrayList<Hashtable<String, String>> findLastCleaningData(List<? extends Object> params) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT " + TAGNM + "," + DATAVAL + HALFSPACE);
		sql.append(" FROM "	  + L_TENKENLIST + HALFSPACE + "A");
		sql.append(" WHERE "  + SYUBETUNO	+ "=0 ");
		sql.append(" AND "	  + SETUBINO	+ "=CAST(? AS VARCHAR) ");
		sql.append(" AND "	  + SHEETNM		+ "=? ");
		sql.append(" AND "	  + TENKENYEAR	+ "=? ");
		sql.append(" AND "	  + TENKENMONTH	+ "=? ");
		sql.append(" AND EXISTS(");
		sql.append("	SELECT " + TENKENNO);
		sql.append("	FROM "	 + L_TENKENLIST + HALFSPACE + "B");
		sql.append("	WHERE "  + SYUBETUNO	+ "=0 ");
		sql.append("	AND A."	 + SETUBINO		+ "=B." + SETUBINO);
		sql.append("	AND A."	 + SHEETNM		+ "=B." + SHEETNM);
		sql.append("	AND A."	 + TENKENYEAR	+ "=B." + TENKENYEAR);
		sql.append("	AND A."	 + TENKENMONTH	+ "=B." + TENKENMONTH);
		sql.append("	AND A."	 + TENKENNO		+ ">B." + TENKENNO);
		sql.append(" )");

		return select(sql.toString(), params, DBMS.atlas.ordinal());
	}

	/**
	 *
	 * @param params
	 * @return
	 */
	public ArrayList<Hashtable<String, String>> findLastCleaningDate(List<? extends Object> params) {
		StringBuilder sql = new StringBuilder();

		sql.append("SELECT 'Cleaning' AS " + TAGNM + ", TO_CHAR(TO_DATE(MAX('' || " + TENKENYEAR + " || "+ TENKENMONTH + " || " + TENKENDAY + "),'yyyymmdd'),'mm/dd') AS " + DATAVAL + HALFSPACE);
		sql.append("FROM "	+ L_TENKENLIST + HALFSPACE);
		sql.append("WHERE " + SYUBETUNO + "=0 ");
		sql.append("AND "	+ SETUBINO	+"=CAST(? AS VARCHAR) ");
		sql.append("AND "	+ SHEETNM	+"=? ");
		sql.append("AND ");
		sql.append("( ");
		sql.append("   (" + TAGNM + "='Item03' AND " + DATAVAL + " ='○') ");
		sql.append("OR (" + TAGNM + "='Item04' AND " + DATAVAL + "<>'＼') ");
		sql.append("OR (" + TAGNM + "='Item07' AND " + DATAVAL + " ='○') ");
		sql.append("OR (" + TAGNM + "='Item08' AND " + DATAVAL + "<>'＼') ");
		sql.append("OR (" + TAGNM + "='Item11' AND " + DATAVAL + " ='○') ");
		sql.append("OR (" + TAGNM + "='Item12' AND " + DATAVAL + "<>'＼') ");
		sql.append("OR (" + TAGNM + "='Item15' AND " + DATAVAL + " ='○') ");
		sql.append("OR (" + TAGNM + "='Item16' AND " + DATAVAL + "<>'＼') ");
		sql.append("OR (" + TAGNM + "='Item19' AND " + DATAVAL + " ='○') ");
		sql.append("OR (" + TAGNM + "='Item20' AND " + DATAVAL + "<>'＼') ");
		sql.append("OR (" + TAGNM + "='Item23' AND " + DATAVAL + " ='○') ");
		sql.append("OR (" + TAGNM + "='Item24' AND " + DATAVAL + "<>'＼') ");
		sql.append(") ");

		return select(sql.toString(), params, DBMS.atlas.ordinal());
	}

	/**
	 *
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	public Integer nextTenkenNo(List<? extends Object> params) throws SQLException {

		StringBuilder sql = new StringBuilder();

		sql.append("SELECT COALESCE(MAX(" + TENKENNO + ") + 1, 1) AS COUNT ");
		sql.append("FROM "	+ L_TENKENLIST + HALFSPACE);
		sql.append("WHERE 1=1 ");
		sql.append("AND " + SHEETNM		+ "=? ");
		sql.append("AND " + TENKENYEAR	+ "=? ");
		sql.append("AND " + TENKENMONTH	+ "=? ");

		return selectCount(sql.toString(), params, DBMS.atlas.ordinal());
	}

	public Integer getTenkenDataStatus(List<? extends Object> params, savekbn kbn) {

		StringBuilder sql = new StringBuilder();

		sql.append(" SELECT COUNT(*) AS COUNT ");
		sql.append(" FROM "  + L_TENKENLIST);
		sql.append(" WHERE " + TENKENKBN + "=0 ");
		sql.append(" AND "   + TENKENNO  + "=0 ");
		sql.append(" AND "   + SETUBINO  + "=? ");
		sql.append(" AND "   + SHEETNM   + "=? ");
		sql.append(" AND "   + TAGNM     + "=? ");
		if (kbn == savekbn.TmpSavedIncludingDate) { sql.append("AND TENKENYEAR=? "); sql.append("AND TENKENMONTH=? "); }

		int count =selectCount(sql.toString(), params, DBMS.atlas.ordinal());

		return 0 == count ? statuskbn.insert.ordinal() : statuskbn.update.ordinal();
	}

	/**
	 *
	 * @return
	 */
	public Integer execQuery(List<TenkenListBean> lst, int savekbn) {
		DbConnection con = new DbConnection(DBMS.atlas.ordinal());
		int count = 0;
		try {
			for (TenkenListBean bean : lst) {
				if (bean.getSvStatus() == insert.ordinal()) {
					count+=insertTenkenList(bean, con);
				} else if (bean.getSvStatus() == update.ordinal()) {
					count+=updateTenkenList(savekbn==TmpSaved.ordinal() ?
							Arrays.asList(new Object[]{bean.getDataVal(),bean.getTenkenNo(),bean.getTantouNm(),bean.getSaveDate(),bean.getSetubiNo(),bean.getSheetNm(),bean.getTagNm()})
							: Arrays.asList(new Object[]{bean.getDataVal(),bean.getTenkenNo(),bean.getTantouNm(),bean.getSaveDate(),bean.getSetubiNo(),bean.getSheetNm(),bean.getTagNm(),bean.getTenkenYear(),bean.getTenkenMonth()})
							, savekbn, con);
				}
			}
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				con.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		} finally {
			con.ConnectionClose();
		}
		return count;
	}

	/**
	 *
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	private Integer insertTenkenList(TenkenListBean bean, DbConnection con) throws SQLException {

		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO "+ L_TENKENLIST + " (");
		sql.append(		 SYUBETUNO);							//種別No
		sql.append("," + TENKENKBN);							//点検区分
		sql.append("," + SETUBINO);								//設備No
		sql.append("," + LOTID);								//LOTID
		sql.append("," + SHEETNM);								//シート名
		sql.append("," + TAGNM);								//タグ名
		sql.append("," + DATAVAL);								//データ値
		sql.append("," + HANTEIRES);							//判定結果
		sql.append("," + HANTEISEL);							//判定選定
		sql.append("," + HANTEIVAL);							//判定値
		sql.append("," + TENKENYEAR);							//点検年
		sql.append("," + TENKENMONTH);							//点検月
		sql.append("," + TENKENDAY);							//点検日
		sql.append("," + TENKENSHIFT);							//点検シフト
		sql.append("," + TENKENNO);								//点検No
		sql.append("," + KAISU);								//処置回数
		sql.append("," + OUTPUTFLG);							//出力フラグ
		sql.append("," + TANTOUNM);								//担当者名
		sql.append("," + SAVEDATE);								//保存日時
		sql.append(") VALUES ( ");
		sql.append("	?");									//種別No
		sql.append(",	?");									//点検区分
		sql.append(",	?");									//設備No
		sql.append(",	?");									//LOTID
		sql.append(",	?");									//シート名
		sql.append(",	?");									//タグ名
		sql.append(",	?");									//データ値
		sql.append(",	?");									//判定結果
		sql.append(",	?");									//判定選定
		sql.append(",	?");									//判定値
		sql.append(",	?");									//点検年
		sql.append(",	?");									//点検月
		sql.append(",	?");									//点検日
		sql.append(",	?");									//点検シフト
		sql.append(",	?");									//点検No
		sql.append(",	?");									//処置回数
		sql.append(",	?");									//出力フラグ
		sql.append(",	?");									//担当者名
		sql.append(",	?");									//保存日時
		sql.append(")");

		List<Object> params = new ArrayList<Object>(Arrays.asList(
								bean.getSyubetuNo(),			//種別No
								bean.getTenkenKbn(),			//点検区分
								bean.getSetubiNo(),				//設備No
								bean.getgLotID(),				//LOTID
								bean.getSheetNm(),				//シート名
								bean.getTagNm(),				//タグ名
								bean.getDataVal(),				//データ値
								bean.getHanteiRes(),			//判定結果
								bean.getHanteiSel(),			//判定選定
								bean.getHanteiVal(),			//判定値
								bean.getTenkenYear(),			//点検年
								bean.getTenkenMonth(),			//点検月
								bean.getTenkenDay(),			//点検日
								bean.getTenkenShift(),			//点検シフト
								bean.getTenkenNo(),				//点検No
								bean.getKaisu(),				//処置回数
								bean.getOutputFlg(),			//出力フラグ
								bean.getTantouNm(),				//担当者名
								bean.getSaveDate()				//保存日時
		));
		return update(con, sql.toString(), params);
	}

	/**
	 *
	 * @param list
	 * @return
	 * @throws SQLException
	 */
	private Integer updateTenkenList(List<? extends Object> params, int savekbn, DbConnection con) throws SQLException {
		StringBuilder sql = new StringBuilder();
		sql.append(" UPDATE "+ L_TENKENLIST );

		sql.append(" SET ");
		sql.append(		  DATAVAL  + "=?");				//データ値
		sql.append(" ," + TENKENNO + "=?");				//点検No
		sql.append(" ," + TANTOUNM + "=?");				//担当者名
		sql.append(" ," + SAVEDATE + "=?");				//保存日時
		sql.append(" WHERE ");

		sql.append(		 	 SYUBETUNO   + "=0");		//種別No
		sql.append(" AND " + SETUBINO	 + "=?");		//設備No
		sql.append(" AND " + SHEETNM	 + "=?");		//シート名
		sql.append(" AND " + TAGNM		 + "=?");		//タグ名

		if (savekbn == TmpSavedIncludingDate.ordinal()) {
			sql.append(" AND " + TENKENYEAR  + "=?");	//点検年
			sql.append(" AND " + TENKENMONTH + "=?");	//点検月
		}
		return update(con, sql.toString(), params);
	}
}