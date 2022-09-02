package db;

import static common.CommonFunctions.*;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.logging.Logger;

import bean.ResultSetBeanMapping;
import logger.logger;

/***
 *
 * @author H.Hayashi
 *
 */
public final class DataHandler implements logger {
	private DataHandler() {}

	final static Logger logger = Logger.getLogger("DataHandler");

	@SuppressWarnings("deprecation")
	private static PreparedStatement getStatement(Connection con, String sql, List<? extends Object> params) throws SQLException {

		PreparedStatement ps = con.prepareStatement(sql);

		if (params != null) {
			int i =0;
			for (Object param : params) {
				i++;
				if (param == null)					 { ps.setNull(i, java.sql.Types.NULL);		  continue; }
				if (param instanceof Timestamp)		 { ps.setTimestamp(i, (Timestamp) param);	  continue; }
				if (param instanceof Integer)		 { ps.setInt(i, (Integer) param);			  continue; }
				if (param instanceof Long)			 { ps.setLong(i, (Long) param);				  continue; }
				if (param instanceof BigDecimal)	 { ps.setBigDecimal(i, (BigDecimal) param);	  continue; }
				if (isNumber(param)) 				 { ps.setInt(i, new Integer((String) param)); continue; }
				if (param instanceof String)		 { ps.setString(i, (String) param);			  continue; }
				if (param instanceof Object)		 { ps.setObject(i, param);					  continue; }
			}
		}
		return ps;
	}

	/**
	 * 簡単な（パラメータの無い）SQLを実行します。
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public static HashMap<String, Object> select(String sql, int dbms) {

		DbConnection con = new DbConnection(dbms);
		ResultSet rs = null;
		HashMap<String , Object> map = null;

		try {
			PreparedStatement ps = getStatement(con.getConnection() , sql, null);
			rs = ps.executeQuery();
			//メタデータ
			ResultSetMetaData rsm = rs.getMetaData();
			map = new HashMap<String, Object>();

			while (rs.next()) {
				for (int i = 0; i < rsm.getColumnCount(); i++){
					String key = rsm.getColumnName(i + 1);
					Object val = rs.getObject(key);
					map.put(key, val);
				}
			}
		} catch (Exception e) {
			logger.warning(e.getLocalizedMessage());
		} finally {
			con.ConnectionClose();
		}
		return map;
	}

	/**
	 *
	 * @param sql
	 * @param params
	 * @return
	 */
	public static ArrayList<Hashtable<String, String>> select(String sql, List<? extends Object> params, int dbms) {
		DbConnection con = new DbConnection(dbms);
		ArrayList<Hashtable<String, String>> list = null;
		try {
			PreparedStatement ps =getStatement(con.getConnection(), sql, params);
			ResultSet rs = ps.executeQuery();

			//フィールド名取得
			ResultSetMetaData rsmd= rs.getMetaData();
			//フィールド数取得
			int rscnt = rsmd.getColumnCount();
			//データ格納
			list = new ArrayList<Hashtable<String, String>>();
			while(rs.next()) {
				//1件分のデータ(連想配列)
				Hashtable<String, String> hdata = new Hashtable<String, String>();
				for (int i = 1; i <= rscnt; i++) {
					//フィールド名
					String field = rsmd.getColumnName(i);
					//フィールド名に対するデータ
					String getdata = rs.getString(field);
					if (getdata == null) { getdata = ""; }
					//データ格納(フィールド名, データ)
					hdata.put(field, getdata);
				}
				//1件分のデータを格納
				list.add(hdata);
			}
		} catch (Exception e) {
			logger.warning(e.getLocalizedMessage());
		} finally {
			con.ConnectionClose();
		}
		return list;
	}

	/**
	 *
	 * @param sql
	 * @param params
	 * @param mapping
	 * @return
	 * @throws SQLException
	 */
	public static <T> List<T> select(String sql, List<? extends Object> params, ResultSetBeanMapping<T> mapping, int dbms) {

		List<T> list=null;
		DbConnection con = new DbConnection(dbms);
		try {
			PreparedStatement ps = getStatement(con.getConnection(), sql, params);

			ResultSet rs = ps.executeQuery();

			list = new ArrayList<T>();
			while(rs.next()) {

				T bean = mapping.createFromResultSet(rs);
				list.add(bean);
			}
		} catch (Exception e) {
			logger.warning(e.getLocalizedMessage());
		} finally {
			con.ConnectionClose();
		}
		return list;
	}

	/**
	 * 抽出したい数値を返却します。
	 * 数値のフィールドは必ずCOUNTにしてください。
	 * @param sql
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	public static Integer selectCount(String sql, List<? extends Object> params, int dbms) {

		DbConnection con = new DbConnection(dbms);
		@SuppressWarnings("deprecation")
		Integer count = new Integer(0);
		try {
			PreparedStatement ps = getStatement(con.getConnection(), sql, params);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) { count = rs.getInt("COUNT"); }
		} catch (Exception e) {
			logger.warning(e.getLocalizedMessage());
		} finally {
			con.ConnectionClose();
		}
		return count;
	}

	/**
	 *
	 * @param sql
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	public static Integer update(DbConnection con, String sql, List<? extends Object> params) throws SQLException {
		PreparedStatement ps = getStatement(con.getConnection(), sql, params);
		return ps.executeUpdate();
	}
}
