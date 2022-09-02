package common;

/**
 * @author H.Hayashi
 */
public class Enum {

	/**
	 * DBCommonFunctionServletの処理呼出し区分
	 */
	public enum functionkbn {
		nothing,				//使わない										 0
		getPBLayoutDiagram,		//PBレイアウト図取得							 1
		getLastTenkenData,		//点検リストのシート別各月の最終データ取得		 2
		getLastCleaningDateWB,	//WB最終清掃日（頻度：月）取得					 3
		getLastCleaningData,	//最新清掃データ取得							 4
		getItemName,			//品名を取得									 5
		getPKG,					//PKGを取得										 6
		getSeries,				//装置シリーズを取得							 7
		getEquipErrorMsg,		//装置のエラーメッセージを取得					 8
		getSinrai,				//信頼度区分を取得								 9
		getCategoryName,		//不良カテゴリの名称を取得						10
	}

	/**
	 * 保存処理の区分
	 */
	public enum savekbn {
		Saved,					//保存					0
		TmpSaved,				//一時保存				1
		TmpSavedIncludingDate,	//日付含む一時保存		2
	}

	/**
	 *
	 */
	public enum statuskbn {
		insert,		//挿入	0
		update,		//更新	1
		delete,		//削除	2
	}
}
