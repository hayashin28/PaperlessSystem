/**
 *
 */



/**
 *
 */
var functionkbn = {
	nothing: 				 0,	//…
	getPBLayoutDiagram:		 1,	//PBレイアウト図取得
	getLastTenkenData:		 2,	//点検リストのシート別各月の最終データ取得
	getLastCleaningDateWB:	 3,	//WB最終清掃日（頻度：月）取得
	getLastCleaningData:	 4,	//最新清掃データ取得
	getItemName:			 5,	//品名取得
	getPKG:					 6,	//PKG取得
	getSeries:				 7,	//装置シリーズを取得
	getEquipErrorMsg:		 8,	//装置のエラーメッセージを取得
	getSinrai:				 9,	//信頼度区分を取得
	getCategoryName:		10,	//不良カテゴリの名称を取得
}

/**
 *
 */
var datekbn = {
	nothing:	0,	//…
	date:		1,	//日付
	datetime:	2,	//日時
}


/**
 * 保存処理の区分
 */
var savekbn = {
	Saved:					0,	//保存
	TmpSaved:				1,	//一時保存
	TmpSavedIncludingDate:	2,	//日付含む一時保存
}

