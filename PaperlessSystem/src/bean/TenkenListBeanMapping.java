package bean;

import static entity.TenkenListEntity.*;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * TenkenListデータマッピングクラス
 * @author H.Hayashi
 *
 */
public class TenkenListBeanMapping implements ResultSetBeanMapping<TenkenListBean> {

	@Override
	public TenkenListBean createFromResultSet(ResultSet rs) throws SQLException {

		TenkenListBean bean = new TenkenListBean();

		bean.setSyubetuNo(rs.getInt(SYUBETUNO));			//種別No
		bean.setTenkenKbn(rs.getInt(TENKENKBN));			//点検区分
		bean.setSetubiNo(rs.getString(SETUBINO));			//設備No
		bean.setgLotID(rs.getString(LOTID));				//LOTID
		bean.setSheetNm(rs.getString(SHEETNM));				//シート名
		bean.setTagNm(rs.getString(TAGNM));					//タグ名
		bean.setCyohyoHansu(rs.getString(CYOHYOHANSU));		//版数
		bean.setHindo(rs.getString(HINDO));					//頻度
		bean.setTenkenPt(rs.getString(TENKENPT));			//点検パターン
		bean.setTenkenCD(rs.getString(TENKENCD));			//点検項目CD
		bean.setDataVal(rs.getString(DATAVAL));				//データ値
		bean.setHanteiRes(rs.getString(HANTEIRES));			//判定結果
		bean.setHanteiSel(rs.getString(HANTEISEL));			//判定選定
		bean.setHanteiVal(rs.getString(HANTEIVAL));			//判定値
		bean.setTenkenYear(rs.getInt(TENKENYEAR));			//点検年
		bean.setTenkenMonth(rs.getInt(TENKENMONTH));		//点検月
		bean.setTenkenDay(rs.getInt(TENKENDAY));			//点検日
		bean.setTenkenShift(rs.getInt(TENKENSHIFT));		//点検シフト
		bean.setTenkenNo(rs.getInt(TENKENNO));				//点検No
		bean.setParentSeqno(rs.getInt(PARENTSEQNO));		//親SEQ
		bean.setKaisu(rs.getInt(KAISU));					//処置回数
		bean.setOutputFlg(rs.getInt(OUTPUTFLG));			//出力フラグ
		bean.setTantouNm(rs.getString(TANTOUNM));			//担当者名
		bean.setSaveDate(rs.getTimestamp(SAVEDATE));		//保存日時

		return bean;
	}
}
