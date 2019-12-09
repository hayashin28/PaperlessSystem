package bean;

import java.sql.ResultSet;
import java.sql.SQLException;


/***
 * データマッピングインタフェース
 * @author H.Hayashi
 *
 * @param <T>
 */
public interface ResultSetBeanMapping<T> {
	public T createFromResultSet(ResultSet rs) throws SQLException;
}
