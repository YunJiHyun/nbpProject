/**
 * 
 */

//ckeditor 적용부분 
	$(function() {

		CKEDITOR.replace('boardContent', { //textarea name
			width : '100%',
			height : '400px',
			filebrowserImageUploadUrl : '/community/imageUpload' //여기 경로로 파일을 전달하여 업로드 시킨다.
		});

		CKEDITOR.on('dialogDefinition', function(event) {
			var dialogName = event.data.name;
			var dialogDefinition = event.data.definition;

			switch (dialogName) {
			case 'image':
				//dialogDefinition.removeContents('info');
				dialogDefinition.removeContents('Link');
				dialogDefinition.removeContents('advanced');
				break;
			}
		});

	});