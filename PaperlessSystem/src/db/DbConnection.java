package db;

import static common.CommonFunctions.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.ConnectionFactory;
import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDataSource;
import org.apache.commons.pool.ObjectPool;
import org.apache.commons.pool.impl.StackObjectPool;

/***
 * DB接続管理クラス
 * @author H.Hayashi
 *
 */
public class DbConnection {

	private Connection connection;

	private int connectionNo_;


	public DbConnection(int connectionNo) {
		connectionNo_ = connectionNo;
	}


	/**
	 * DB接続オブジェクトを生成
	 * @return
	 */
	public Connection getConnection() {
		if (connection == null) {
			try {
				connection=CreateConnection();
			} catch (Exception e) { e.printStackTrace(); return null; }
		}
		return connection;
	}

	/**
	 * DB接続を閉じる
	 */
	public void ConnectionClose() {
		try {
			if (connection != null) connection.close();
		} catch (SQLException e) { e.printStackTrace();
		} finally { connection = null; }
	}

	/**
	 * トランザクションのコミットを行う
	 * @throws SQLException
	 */
	public void commit() throws SQLException { if (connection != null) connection.commit(); }

	/**
	 * トランザクションのロールバックを行う
	 * @throws SQLException
	 */
	public void rollback() throws SQLException { if (connection != null) connection.rollback(); }


	/**
	 *
	 * @return
	 * @throws Exception
	 */
	private Connection CreateConnection() throws Exception {

		//プロパティファイルの読込み
		final Properties properties = getProperties("DbConnect.Properties");
		//JDBCドライバのロード
		Class.forName(properties.getProperty("PostgresDriver"));
		//ObjectPoolインスタンスを生成
		ObjectPool pool = new StackObjectPool();
		//各設定
		String url	= properties.getProperty(connectionNo_ +  ".url");
		String username	= properties.getProperty(connectionNo_ + ".username");
		String password	= properties.getProperty(connectionNo_ + ".password");

		//Connectionオブジェクトを生成するためのConnectionFactoryインスタンスを生成
		ConnectionFactory conFactory = new DriverManagerConnectionFactory(url, username, password);

		//PoolableConnectionFactoryインスタンスを生成
		/**
		 * 【PoolableConnectionFactoryのコンストラクタの引数】
		 * connFactory Connection 	オブジェクトを生成するためのConnectionFactoryインスタンス
		 * pool 					Connectionのプーリングに用いるObjectPoolインスタンス
		 * stmtPoolFactory 			PreparedStatementオブジェクトをプーリングする場合、プーリング用のKeyedObjectPoolオブジェクトを生成するためのKeyedObjectPoolFactoryインスタンス。PreparedStatementオブジェクトをプーリングしない場合はnullを指定
		 * validationQuery 			Connectionが有効であるかどうかを検査するためのSQL文
		 * defaultReadOnly 			プールから取り出されたConnectionを読み込み専用にする
		 * defaultAutoCommit 		プールから取り出されたConnectionを自動コミットモードにする
		 */
		new PoolableConnectionFactory(conFactory, pool, null, null, false, false);

		//プーリング機能を持つDataSourceインスタンスを生成
		DataSource daSource = new PoolingDataSource(pool);

		return daSource.getConnection();
	}
}
