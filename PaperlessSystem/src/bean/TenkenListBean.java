package bean;

import java.io.Serializable;
import java.sql.Timestamp;

/***
 * 点検リストBean
 * @author H.Hayashi
 *
 */
public class TenkenListBean implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private Integer		SyubetuNo;		//種別No
	private Integer		TenkenKbn;		//点検区分
	private String		SetubiNo;		//設備No
	private String		gLotID;			//LOTID
	private String		SheetNm;		//シート名
	private String		TagNm;			//タグ名
	private String		CyohyoHansu;	//版数
	private String		Hindo;			//頻度
	private String		TenkenPt;		//点検パターン
	private String		TenkenCD;		//点検項目CD
	private String		DataVal;		//データ値
	private String		HanteiRes;		//判定結果
	private String 		HanteiSel;		//判定選定
	private String		HanteiVal;		//判定値
	private Integer 	TenkenYear;		//点検年
	private Integer		TenkenMonth;	//点検月
	private Integer		TenkenDay;		//点検日
	private Integer		TenkenShift;	//点検シフト
	private Integer		TenkenNo;		//点検No
	private long		ParentSeqno;	//親SEQ
	private Integer		Kaisu;			//処置回数
	private Integer		OutputFlg;		//出力フラグ
	private String		TantouNm;		//担当者名
	private Timestamp	SaveDate;		//保存日時
	private int 		SvStatus;		//保存ステータス

	//種別No
	public Integer getSyubetuNo() { return SyubetuNo; }
	public void setSyubetuNo(Integer syubetuNo) { SyubetuNo = syubetuNo; }
	//点検区分
	public Integer getTenkenKbn() { return TenkenKbn; }
	public void setTenkenKbn(Integer tenkenKbn) { TenkenKbn = tenkenKbn; }
	//設備No
	public String getSetubiNo() { return SetubiNo; }
	public void setSetubiNo(String setubiNo) { SetubiNo = setubiNo; }
	//LOTID
	public String getgLotID() { return gLotID; }
	public void setgLotID(String gLotID) { this.gLotID = gLotID; }
	//シート名
	public String getSheetNm() { return SheetNm; }
	public void setSheetNm(String sheetNm) { SheetNm = sheetNm; }
	//タグ名
	public String getTagNm() { return TagNm; }
	public void setTagNm(String tagNm) { TagNm = tagNm; }
	//版数
	public String getCyohyoHansu() { return CyohyoHansu; }
	public void setCyohyoHansu(String cyohyoHansu) { CyohyoHansu = cyohyoHansu; }
	//頻度
	public String getHindo() { return Hindo; }
	public void setHindo(String hindo) { Hindo = hindo; }
	//点検パターン
	public String getTenkenPt() { return TenkenPt; }
	public void setTenkenPt(String tenkenPt) { TenkenPt = tenkenPt; }
	//点検項目CD
	public String getTenkenCD() { return TenkenCD; }
	public void setTenkenCD(String tenkenCD) { TenkenCD = tenkenCD; }
	//データ値
	public String getDataVal() { return DataVal; }
	public void setDataVal(String dataVal) { DataVal = dataVal; }
	//判定結果
	public String getHanteiRes() { return HanteiRes; }
	public void setHanteiRes(String hanteiRes) { HanteiRes = hanteiRes; }
	//判定選定
	public String getHanteiSel() { return HanteiSel; }
	public void setHanteiSel(String hanteiSel) { HanteiSel = hanteiSel; }
	//判定値
	public String getHanteiVal() { return HanteiVal; }
	public void setHanteiVal(String hanteiVal) { HanteiVal = hanteiVal; }
	//点検年
	public Integer getTenkenYear() { return TenkenYear; }
	public void setTenkenYear(Integer tenkenYear) { TenkenYear = tenkenYear; }
	//点検月
	public Integer getTenkenMonth() { return TenkenMonth; }
	public void setTenkenMonth(Integer tenkenMonth) { TenkenMonth = tenkenMonth; }
	//点検日
	public Integer getTenkenDay() { return TenkenDay; }
	public void setTenkenDay(Integer tenkenDay) { TenkenDay = tenkenDay; }
	//点検シフト
	public Integer getTenkenShift() { return TenkenShift; }
	public void setTenkenShift(Integer tenkenShift) { TenkenShift = tenkenShift; }
	//点検No
	public Integer getTenkenNo() { return TenkenNo; }
	public void setTenkenNo(Integer tenkenNo) { TenkenNo = tenkenNo; }
	//親SEQ
	public long getParentSeqno() { return ParentSeqno; }
	public void setParentSeqno(long parentSeqno) { ParentSeqno = parentSeqno; }
	//処置回数
	public Integer getKaisu() { return Kaisu; }
	public void setKaisu(Integer kaisu) { Kaisu = kaisu; }
	//出力フラグ
	public Integer getOutputFlg() { return OutputFlg; }
	public void setOutputFlg(Integer outputFlg) { OutputFlg = outputFlg; }
	//担当者名
	public String getTantouNm() { return TantouNm; }
	public void setTantouNm(String tantouNm) { TantouNm = tantouNm; }
	//保存日時
	public Timestamp getSaveDate() { return SaveDate; }
	public void setSaveDate(Timestamp saveDate) { SaveDate = saveDate; }
	//保存ステータス
	public int getSvStatus() { return SvStatus; }
	public void setSvStatus(int svStatust) { SvStatus = svStatust; }

}
