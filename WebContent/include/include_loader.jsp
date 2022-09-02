<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<script type="text/javascript">
		(function(load){
			try{
				window.addEventListener("DOMContentLoaded",load,false);
			}catch(e){
				(function(){
					try{
						document.documentElement.doScroll("left");
					}catch(e){
						setTimeout(arguments.callee,0);
						return;
					}
					load();
				})();
			}
		})(function(){
			var h = $(window).height();
			$('#wrap').css('display', 'none');
			$('#loader-bg ,#loader').height(h).css('display', 'block');
		});

		$(window).load(function() { //全ての読み込みが完了したら実行
			$('#loader-bg').delay(900).fadeOut(800);
			$('#loader').delay(600).fadeOut(300);
			$('#wrap').css('display', 'block');
		});
		function stopload() {
			$('#wrap').css('display', 'block');
			$('#loader-bg').delay(900).fadeOut(800);
			$('#loader').delay(600).fadeOut(300);
		}
	</script>
