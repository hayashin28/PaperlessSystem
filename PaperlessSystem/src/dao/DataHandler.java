package dao;

import static common.CommonFunctions.*;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * データベースアクセスをするクラス
 * 全てのDAOはこのクラスを継承する
 *
 * @author hayas
 *
 * 更新履歴
 * 2019.06.05 PreparedStatementの数字列を文字列に扱えない不具合を修正（hayas）
 * 2019.06.06 コメントの一部が原因でJavaDocが生成できない不具合を修正（hayas）
 *
 */
public abstract class DataHandler {

	private Connection db = null;			// ＤＢ接続用
	private PreparedStatement ps = null;	// ＳＱＬ文発行用

	/**
	 *  コネクションオブジェクトを設定
	 */
	public void connectSetting() {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context
					.lookup("java:comp/env/jdbc/myds");
			db = ds.getConnection();
			db.setAutoCommit(false);
		} catch (Exception e) {
			throw new IllegalStateException(e);
		}
	}

	/**
	 * @return　SQL発行用オブジェクトを返す
	 * @param sql	SQL文
	 * @param params{@literal<T>}　プレースフォルダに引き渡す文字列
	 */
	@SuppressWarnings("deprecation")
	protected PreparedStatement getPsSetParam(String sql, List<Object> params) throws SQLException {
		ps = db.prepareStatement(sql);
		if (params != null) {
			int i =0;
			for (Object param : params) {
				i++;
				if (param == null)					{ ps.setNull(i, java.sql.Types.NULL);		 continue; }
				if (param instanceof Timestamp)		{ ps.setTimestamp(i, (Timestamp) param);	 continue; }
				if (param instanceof Integer)		{ ps.setInt(i, (Integer) param);			 continue; }
				if (param instanceof Long)		 	{ ps.setLong(i, (Long) param);				 continue; }
				if (param instanceof BigDecimal)	{ ps.setBigDecimal(i, (BigDecimal) param);	 continue; }
				if (param instanceof String)		{ ps.setString(i, (String) param);			 continue; }
				if (isNumber(param)) 				{ ps.setInt(i, new Integer((String) param)); continue; }
				if (param instanceof Object)		{ ps.setObject(i, param);					 continue; }
			}
		}
		return ps;
	}

	/**
	 * データーベースを閉じる
	 */
	protected void closeDb() {
		try {
			if (ps != null) {
				ps.close();
			}
			if (db != null) {
				db.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 *
	 * @param sql	SQL文
	 * @param params{@literal<T>}　プレースフォルダに引き渡す文字列
	 * @return（処理件数）を戻す
	 */
	protected int execUpdate(String sql, List<Object> params) {
		int count = 0;
		try {
			getPsSetParam(sql, params);
			count = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			count = -1;
		}
		return count;
	}

	/**
	 * 検索SQLを発行して、結果をオブジェクトのListに入れて返す。
	 * ResultSetからListへの変換は、ResultSetBeanMappingが行う
	 *
	 * @param sql	SQL文
	 * @param params{@literal<T>}　プレースフォルダに引き渡す文字列
	 * @param mapping{@literal<T>}　1レコードの情報（beans）オブジェクトを返すクラス
	 */
	protected <T> ArrayList<T> execQuery(String sql, List<Object> params,
			ResultSetBeanMapping<T> mapping) {

		ArrayList<T> list = null;
		try {
			list = new ArrayList<T>();
			connectSetting();
			getPsSetParam(sql, params);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				T bean = mapping.createFromResultSet(rs);

				list.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("DataHandler=" + e);
		} finally {
			closeDb();
		}
		return list;
	}

	/**
	 *
	 * @param sql
	 * @return
	 */
	protected Object execQuery(String sql) {
		Object obj = null;
		try {
			connectSetting();
			getPsSetParam(sql, null);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				obj = rs.getObject(0);
			}
		} catch (SQLException e) {
			System.out.println("DataHandler=" + e);
		} finally {
			closeDb();
		}
		return obj;
	}

	/**
	 * 引数retが-1ならロールバックし、
	 * 処理件数があればDBへ反映させる
	 * その後コネクションを閉じる
	 * @param ret
	 * @throws SQLException
	 */
	protected void reflectProc(int ret) throws SQLException {
		if (ret == -1) {
			db.rollback();
		} else {
			db.commit();
		}
		closeDb();
	}
}
