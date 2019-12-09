<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<script type="text/javascript">
		$(document).ready(function() {
			var topBtn = $('#page-top');
			topBtn.hide();
			//スクロールが100に達したらボタン表示
			$(window).scroll(function() {
				if ($(this).scrollTop() < 1) {
					topBtn.fadeIn();
				} else {
					topBtn.fadeOut();
				}
			});
			//スクロールしてトップ
			topBtn.click(function() {
				$('body,html').animate({
					scrollTop : 0
				}, 1500);
				return false;
			});
		});
	</script>
	<p id="page-top"><a href="#">下へ移動</a></p>
</html>