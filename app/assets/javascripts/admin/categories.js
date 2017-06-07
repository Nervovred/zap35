var fixHelper = function(e, ui) {
	ui.children().each(function() {
		$(this).width($(this).width());
	});
	return ui;
};

$(function(){
	$('#categories tbody').sortable({
		helper: fixHelper,
		axis: 'y',
		update: function(){
			$.post($(this).data('update-url'), $(this).sortable('serialize'));
		}
	})
});
