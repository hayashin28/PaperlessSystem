package dao;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author hayas
 *
 * @param {@literal<T>}
 */
public interface ResultSetBeanMapping<T> {

	/**
	 * ResultSetを元にオブジェクトを作成する
	 */
    public T createFromResultSet(ResultSet rs)
            throws SQLException;

}
