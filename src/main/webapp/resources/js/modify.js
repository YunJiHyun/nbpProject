/**
 * 
 */
	function createFile(fileName, fileSize, data) {
		var file = {
			name : fileName,
			size : fileSize,
			format : function() {
				var sizeKB = this.size / 1024;
				if (parseInt(sizeKB) > 1024) {
					var sizeMB = sizeKB / 1024;
					this.size = sizeMB.toFixed(2) + " MB";
				} else {
					this.size = sizeKB.toFixed(2) + " KB";
				}
				//파일이름이 너무 길면 화면에 표시해주는 이름을 변경해준다.
				if (name.length > 70) {
					this.name = this.name.substr(0, 68) + "...";
				}
				return this;
			},
			tag : function() {
				var tag = new StringBuffer();

				tag.append("<tr id='"+data+"'>");
				tag.append('<td>' + this.name + '</td>');
				tag.append('<td>' + this.size + '</td>');
				tag
						.append("<td><input type='button' value='삭제' onclick='deleteFile(this)' id='"
								+ this.name + "'></input></td>");
				tag.append('</tr>');
				return tag.toString();
			}
		}
		return file.format().tag();
	}

	function deleteFile(event) {
		dataSource = $(event).parents('tr').attr("id");

		$("input[type='hidden']").each(function() {
			if (this.value == dataSource) {
				$(this).remove();
			}
		});

		$(event).parents('tr').remove(); //upload한 리스트에서 제거

	}