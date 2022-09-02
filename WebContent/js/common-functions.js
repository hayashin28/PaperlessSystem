/**
 * JavaScript共通関数
 * @author H.Hayashi
 */



/**
* コンテキストパスを取得
* @return ContextPath
*/
function getContextPath() {
	var path = './';
	var e = document.createElement('span');
	e.innerHTML = '<a href="' + path + '" />';
	url = e.firstChild.href;
	var p = url.split('/');
	return '/'+p[3]+'/';
}

/**
 *
 * @param forms
 * @returns {String}
 */
function getSerializableData(forms) {
	//
	var params = new Object();
	for (var i = 0; i < forms.length; i++) {
		var param='';
		var elem = forms.elements[i];

		if (elementValidater(elem)) {
			/* 連想配列のkey(id)が定義済みか確認する⇒ID重複による値の上書きを制御 */
			if (!params[elem.id] && !params[elem.name]) {
				//チェックボックスの選択値を取得
				if ($("#" + elem.id).is(':checkbox')) {
					$('[name='+elem.name+']:checked').each(function() {
						param += ($(this).val() === undefined ? "/" : $(this).val()) + "/";
					});
					//文字列の先頭1文字を削除する
					params[elem.name] = param.substr(0, param.length-1);
				}
				else if ($("#" + elem.id).is(':radio')) {
					params[elem.name] =  ($('input[name='+elem.name+']:checked').val() === undefined ? "/" : $('input[name='+elem.name+']:checked').val());
				}
				else if ($("#" + elem.id).is(':disabled')===true) {
					params[elem.id] = "/";
				}
				else {
					params[elem.id] = $('#' + elem.id).val();
				}
			}
		}
	}

	var serializable = ''
	Object.keys(params).forEach(function(key) {
		serializable += key + ";" + params[key] + ",";
	});
	//文字列の先頭1文字を削除する
	serializable = serializable.substr(0, serializable.length-1);
	return serializable;
}

/**
 *
 */
function isRange(val1, val2, val3) {
	if (!$.isNumeric(val1)) {return false;}
	if (!$.isNumeric(val2)) {return false;}
	if (!$.isNumeric(val3)) {return false;}
	return (val1<=val3 && val3<=val2);
}

/**
 *
 * @param name
 * @param bool
 */
function SelectorControl(name, bool) {
	$("#"+name).hide();
	if (bool) {$("#"+name).show();}
	$("#"+name).find('input[type="checkbox"],input[type="radio"],input[type="text"]').each(function(i, elem) {
		var val=(elem.name.length!==0)?elem.name:elem.id;
		$(":input[name="+val+"]").prop('disabled', !bool);
		$("#"+val).prop('disabled', !bool);
	});
}

/**
 *
 */
function fncWords(words, dataid, id, kbn) {
	if (words.length===0 || kbn===0) { return false; }
	setCookie(id, words);
	var defer = $.Deferred();
	setTimeout(function() {
		var result=collCommonFunctionServlet(kbn, words);
		result.done(function(response) {
			if (dataid!==null) { $("#"+dataid).val(response); setCookie(dataid, response); }
			defer.resolve(); // 承認
		});
		result.fail(function() {
			bootbox.alert("データが存在しません。");
			if (dataid!==null) { $("#"+dataid).val(""); setCookie(dataid, ""); }
			defer.reject(); // 却下
		});
	},0)
	return defer.promise(); // プロミスを作って返す
}


function callTenkenListServlet(Setubi, sheetnm, params, tanname, savekbn) {
	return $.ajax({
		type:'POST',
		url :'/PT/TenkenListServlet',
		dataType:'json',
		data:{
				Setubi   : Setubi,
				sheetnm  : sheetnm,
				params   : params,
				tanname  : tanname,
				savekbn  : savekbn,
				connect  : 'ajax'
		 }
	});
}

/**
 *
 * @param parameter
 * @returns
 */
function collCommonFunctionServlet(functionkbn, parameter) {
	return $.ajax({
		type:'POST',
		url :'/PT/CommonFunctionServlet',
		dataType:'json',
		data:{
				functionkbn : functionkbn,
				parameter   : parameter
		 }
	});
}

/**
 *
 * @param elem
 * @returns {Boolean}
 */
function elementValidater(elem) {
	return (!$.isEmptyObject(elem.id) && elem.id.match(/params/ig)===null && elem.id.match(/tbl/ig)===null && elem.id.match(/btn/ig)===null) && elem.id.match(/Setubi/ig)===null;
}

/**
 *
 * @param message
 * @returns
 */
function confirmSave(message) {

	var defer = new $.Deferred();

	setTimeout(function() {
		bootbox.confirm(message+"保存処理を継続しますか？", function(result) {
			//OKならtrue、Cancelならfalse
			if(result) {
				defer.resolve();//解決
			} else {
				defer.reject(); //却下
			}
		});
	}, 0);
	return defer.promise(); //プロミスを作って返す
};

/**
 *
 * @param code
 * @returns
 */
function replaceCode(code) {
	return code.replace("%H","").replace("%K","").replace("%L","").replace("%N","").replace("%M","").replace("%V","").replace("%P","").replace("%BA","").replace("%GA","");
}

/**
 * 全角から半角への変換関数
 * 入力値の英数記号を半角変換して返却します。
 * [引数]   strVal: 入力値
 * [返却値] String(): 半角変換された文字列
 */
function toHalfWidth(strVal){
	// 半角変換
	var halfVal = strVal.replace(/[！-～]/g,
			function(tmpStr) {
		// 文字コードをシフト
		return String.fromCharCode(tmpStr.charCodeAt(0) - 0xFEE0);
	});
	// 文字コードシフトで対応できない文字の変換
	return halfVal.replace(/”/g, "\"").replace(/’/g, "'").replace(/‘/g, "`").replace(/￥/g, "\\").replace(/　/g, " ").replace(/〜/g, "~");
}

/**
 * 半角英数字かチェック
 * @return true:半角英数字である(もしくは対象文字列がない), false:半角英数字でない
 */
function isHalfWidthAlphanumeric(value) {
	if (value===null) { return; }
	if (value.match(/[^A-Za-z0-9\s.-]+/)) {
		/* alert("半角英文字で入力してください"); */
		return false;
	}
	return true;
}

/**
 * 半角数字かチェック
 * @return true:半角数字である(もしくは対象文字列がない), false:半角数字でない
 */
function isNumeric(value) {
	if (value===null ) { return; }
	if (value.match(/[^0-9.,-]+/)) {
		/* alert("半角数字で入力して下さい。"); */
		return false;
	}
	return true;
}

/**
 * ひらがな・カタカナかチェック
 * @return true:ひらがな・カタカナである(もしくは対象文字列がない), false:ひらがな・カタカナでない
 */
function isKana(value) {
	if (value===null) { return; }
	if (value.match(/[^ぁ-んァ-ン　\s]+/)) {
		/* alert("ひらがなもしくはカタカナで入力して下さい。"); */
		return false;
	}
	return true;
}

/**
 *
 */
function fncTmpSubmit(setubi, sheetnm, parameter, tanname, savekbn) {

	var defer = $.Deferred();
	setTimeout(function() {
		var result=callTenkenListServlet(setubi, sheetnm, parameter, tanname, savekbn);
		result.done(function(response) {
			defer.resolve(); // 承認
		});
		result.fail(function() {
			defer.reject(); // 却下
		});
	},0)
	return defer.promise(); // プロミスを作って返す
}

/**
 *
 * @param date
 * @returns {String}
 */
function getShift(date) {
	var shift = date.hours() * 60 + date.minutes();
	if((6*60+30)<=shift && shift<14*60+30) {
		return '早';
	} else if((14*60+30)<=shift && shift<22*60+30) {
		return '遅';
	} else if((22*60+30)<=shift || shift<(6*60+30)) {
		return '夜';
	}
}

/**
 *
 */
$(function() {
	$(".inline").colorbox({
		inline : true,
		maxWidth : "90%",
		maxHeight : "90%",
		opacity : 0.7
	});
});
