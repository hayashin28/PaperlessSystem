
$(document).ready(function(){
  
/*
 * シャッフル
 */
  Array.prototype.shuffle = function() {
      var i = this.length;
      while (i) {
          var j = Math.floor(Math.random() * i);
          var t = this[--i];
          this[i] = this[j];
          this[j] = t;
      }
      return this;
  };
  
      
/*
 * フォームをクリックしたとき
 */
    $(document).on('click','.numerickeybord',function(){
      var offset = $( this ).offset();
      var top  = Math.ceil(offset.top)+35;
      var left = Math.ceil(offset.left);
      $(".numkey").remove(); //全部削除
      $(this).blur(); //フォーカスを外す
      
    //数値とアルファベットの配列
       arr_numeric = ['0','1','2','3','4','5','6','7','8','9'];
       arr_alpha   = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    //シャッフル
      arr_numeric.shuffle();
      arr_alpha.shuffle();

        var html = '';
        html +='  <div class="numkey">';
        html +='    <ul>';
          for(var i=0; i<arr_numeric.length; i++){
            html +='      <li id="numerickey'+arr_numeric[i]+'" class="numerickey" unselectable="on">'+arr_numeric[i]+'<span>/'+arr_alpha[i]+'</span></li>';
          }
        html +='    </ul>';
        html +='    <div id="btwrap"><a href="#" id="numkeyclear" class="numerickey_button">クリア</a> <a href="#" id="numkeyclose" class="numerickey_button">閉じる</a></div>';
        html +='  </div>';

        $("body").append(html);
        $(".numkey").css({"top":top,"left":left});
         div_id= "#"+$(this).attr("id");
    });

  
  //マウスで押したときの処理
    $(document).on('click','.numerickey',function(){
      var id= $(this).attr("id");
      id = id.match(/numerickey(\d+)/)[1];
      var val = $(div_id).val();
      $(div_id).val(val+id);
    });

  //キーボードを押したとき
    $(document).keydown(function (e) {
      if( $(".numkey").html() !== undefined){
        var keyname = String.fromCharCode(e.which); //押したキーが何か A,B,C....
        var inArr   = $.inArray(keyname, arr_alpha);    //押したキーが何番目の要素か
        var num     = arr_numeric[inArr];
        var val = $(div_id).val();
        if( num < 10 ){
          $(div_id).val(val+num);
        }
      }
    });

  //閉じる・クリアボタンを押したとき
    $(document).on('click','.numerickey_button',function(e){
      var id= $(this).attr("id");
      if(id === 'numkeyclear'){
        $(div_id).val('');
      }else if(id === 'numkeyclose'){
        $(".numkey").remove(); //全部削除
      }
      e.preventDefault();
    });

});


