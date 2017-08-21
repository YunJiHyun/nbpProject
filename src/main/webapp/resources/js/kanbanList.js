/**
 * 
 */
	var movingUrl = "/jihyunboard/kanban/update?kanbanNum=";
	var dialog;
	
	$(document).ready(function() {
		dialog = $("#dialog").dialog({
			autoOpen: false,
			title: "칸반보드 내용 수정",
			width: 700,
			height: 250,
			buttons: [
				{
					id: "Yes",
					text: "Yes",
					click: function () {
						var kanbanNum = $(this).data('kanbanNum');
						var kanbanContent = $("#dialogContent").val(); 
						$.ajax({
							type: "POST",
							url:  "/jihyunboard/kanban/updateKanbanContent",
							data : {
								kanbanNum : kanbanNum,
								kanbanContent : kanbanContent
							},
							success: function(){
								alert("내용이 수정되었습니다.");
								$("li[id="+kanbanNum+"]").children('div').html(kanbanContent+"<span class='glyphicon glyphicon-pencil'></span>");
								dialog.dialog('close');
							}
						});
					}
				},
				{
					id: "No",
					text: "cancel",
					click: function () {
						$(this).dialog('close');
					}
				}
			]
		});
		
		updateStateNum();
		//영역 못 벗어나게 draggable
		 $( "ul" ).sortable({
			connectWith: "ul",
			containment: "tbody", 
			scroll: false,
			revert : true,
			cursor: "move",
			update: function( event, ui ){
				var ulList = this.id;
				var data = $(this).sortable('toArray');
			
				$.ajax({
					type: "POST",
					url:  "/jihyunboard/kanban/sortList",
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify({
						"sortedList" : data,
						"sortState" : ulList
					}),
					success: function(){
					} 
				});			
			}
		}).disableSelection();
		
		$("#kanbanTodo").droppable({
			accept:".doingList, .doneList",
			drop: function( event, ui ) {
				if($(".todoList").length >= 10){
					alert("todo상태는 10개까지만 가능합니다.")
					return false;
				}
				updateTodo(ui.draggable, movingUrl);
			}
		});
		
		$("#kanbanDoing").droppable({
			accept: ".todoList, .doneList",
			drop: function( event, ui ) {
				if($(".doingList").length >= 6){
					alert("doing상태는 6개까지만 가능합니다.")
					return false;
				}
				updateDoing(ui.draggable, movingUrl);
			}
		});
		
		$("#kanbanDone").droppable({
			accept:".todoList, .doingList",
			drop: function( event, ui ) {
				if($(".doneList").length >= 8){
					alert("done상태는 8개까지만 가능합니다.");
					return false;
				}
				updateDone(ui.draggable, movingUrl);
			}
		});
	});
	
	// kanbanList() 호출 후 db갔다오지 말고 front-end단에서 삭제하기  + 다이얼로그 추가 
	$(document).on("click",".btnKanbanDelete",(function() {	
		var kanbanNum = this.id;
		$.ajax({
			type: "GET",
			url: movingUrl + kanbanNum + "&kanbanState=DELETE",
			success: function(){
				kanbanList();
			} 
		});
	}));
	
	$(document).on("click",".glyphicon-pencil",(function() {	
		var kanbanNum = $(this).closest('li').prop('id');
		var kanbanContent = $(this).parent('div').text();
		$("#dialogContent").val(kanbanContent.trim());
		dialog.data('kanbanNum',kanbanNum).dialog("open");
	}));
	
	function updateTodo(item , movingUrl){
		var kanbanNum = item.prop("id");
		var movingLiElement =$("li[id="+kanbanNum+"]");
			
		movingLiElement.removeClass().addClass('todoList ui-sortable-handle');
		movingLiElement.children('div').removeClass().addClass('todoContentDiv');

		var changeElement = movingLiElement.clone(); 
		movingLiElement.remove();
		$("#todo").append(changeElement);
			
		$($("li[id="+kanbanNum+"] button")).remove();
		$($("li[id="+kanbanNum+"] br")).remove();
			
		changeElement.removeAttr("style");
		var checkTodoNum = $(".todoList").length;
		$.ajax({
			type: "GET",
			url: movingUrl + kanbanNum + "&kanbanState=TODO&kanbanOrder="+checkTodoNum,
			success: function(){
			} 	
		});
	
	}
	
	function updateDoing(item , movingUrl){
		var kanbanNum = item.prop("id");
		var movingLiElement =$("li[id="+kanbanNum+"]");
		
		movingLiElement.removeClass().addClass('doingList ui-sortable-handle');
		movingLiElement.children('div').removeClass().addClass('doingContentDiv');

		var changeElement = movingLiElement.clone();

		movingLiElement.remove();
		$("#doing").append(changeElement);
			
		$($("li[id="+kanbanNum+"] button")).remove();
		$($("li[id="+kanbanNum+"] br")).remove();
			
		changeElement.removeAttr("style");
		var checkDoingNum = $(".doingList").length;
		$.ajax({
			type: "GET",
			url: movingUrl + kanbanNum + "&kanbanState=DOING&kanbanOrder=" + checkDoingNum,
			success: function(){
			} 	
		});
	}
	
	function updateDone(item , movingUrl){
		var kanbanNum = item.prop("id");
		var movingLiElement = $("li[id="+kanbanNum+"]");
			
		movingLiElement.removeClass().addClass('doneList ui-state-default ui-sortable-handle');
		movingLiElement.children('div').removeClass().addClass('doneContentDiv');

		var changeElement = movingLiElement.clone();
		
		movingLiElement.remove();
			
		$("#done").append(changeElement);
			
		btnHtml = "<button id='" + kanbanNum + "' class='btn btn-default navbar-btn btn-sm btnKanbanDelete'>";
		btnHtml += "<span class='glyphicon glyphicon-remove'></span></button><br/><br/>";
			
		$(btnHtml).prependTo($("li[id="+kanbanNum+"]"));
		changeElement.removeAttr("style");
		var checkDoneNum =  $(".doneList").length;
		$.ajax({
			type: "GET",
			url: movingUrl + kanbanNum + "&kanbanState=DONE&kanbanOrder=" + checkDoneNum,
			success: function(){
			} 	
		});
	}
	
	function updateStateNum(){
		var checkTodoNum = $(".todoList").length;
		$("#todoNum").text(" "+"["+checkTodoNum+"/10]");
		
		var checkDoingNum = $(".doingList").length;
		$("#doingNum").text(" "+"["+checkDoingNum+"/6]");
		
		var checkDoneNum =  $(".doneList").length;
		$("#doneNum").text(" "+"["+checkDoneNum+"/8]");
		
		
		console.log("todoNum" + checkTodoNum);
		console.log("doingNum" + checkDoingNum);
		console.log("doneNum" + checkDoneNum);
		
	}

	