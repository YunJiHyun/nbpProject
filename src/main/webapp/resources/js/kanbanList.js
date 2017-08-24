/**
 * 
 */
	var movingUrl = "/jihyunboard/kanban/update?kanbanNum=";
	var modifyDialog;
	var deleteDialog;
	
	$(document).ready(function() {
		modifyDialog = $("#kanbanModifyDialog").dialog({
			autoOpen: false,
			title: "칸반보드 내용 수정",
			width: 700,
			height: 300,
			buttons: [
				{
					id: "Yes",
					text: "Yes",
					click: function () {
						var kanbanNum = $(this).data('kanbanNum');
						var deleteBoardClass = $(this).data('deleteBoardClass');
						var boardLink = $(this).data('boardLink');
						var kanbanContent = $("#dialogContent").val();
						var kanbanDeadline = $("#kanbanModifyDeadline").val()
						
						$.ajax({
							type: "POST",
							url:  "/jihyunboard/kanban/updateKanbanContent",
							data : {
								kanbanNum : kanbanNum,
								kanbanContent : kanbanContent,
								kanbanDeadline : kanbanDeadline
							},
							success: function(){
								
								if(deleteBoardClass != 0){ 
									tempContent = $("#dialogContent").val();
									kanbanContent = tempContent + "<br/><span class='deletedBoard' style='color:red'>[원글삭제됨]</span>";
								}
								if(boardLink != 0){
									kanbanContent = '<a href="javascript:viewDetailDialog(' + kanbanNum + ')">' + $("#dialogContent").val() + '</a>';
								} 
								alert("내용이 수정되었습니다.");
								$("li[id="+kanbanNum+"]").children('div').html(kanbanContent+"<span class='glyphicon glyphicon-pencil'></span>");
								$("li[id="+kanbanNum+"]").children('span').removeClass('label-danger').addClass('label-default').children('span').text(kanbanDeadline);
								modifyDialog.dialog('close');
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
			],
		});
		
		deleteDialog = $("#kanbanDeleteDialog").dialog({
			autoOpen: false,
			title: "칸반보드 삭제",
			width: 500,
			height: 200,
			buttons: [
				{
					id: "Yes",
					text: "Yes",
					click: function () {
						var kanbanNum = $(this).data('kanbanNum'); 
						$.ajax({
							type: "GET",
							url: movingUrl + kanbanNum + "&kanbanState=DELETE",
							success: function(){
								deleteDialog.dialog('close');
								$("li[id="+kanbanNum+"]").remove();
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
		
		displayStateNum();
		//영역 못 벗어나게 draggable
		 $( "#todo, #doing, #done" ).sortable({
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
				updateStateNum(ui.draggable, this.id);
				updateTodo(ui.draggable, movingUrl);
				//여기에 updateState를 썼더니 이미 class명이 바뀐상태라 생각한대로 안나옴
			}
		});
		
		$("#kanbanDoing").droppable({
			accept: ".todoList, .doneList",
			drop: function( event, ui ) {
				if($(".doingList").length >= 6){
					alert("doing상태는 6개까지만 가능합니다.")
					return false;
				}
				updateStateNum(ui.draggable, this.id);
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
				updateStateNum(ui.draggable, this.id);
				updateDone(ui.draggable, movingUrl);
			}
		});
	});
	
	$(document).on("click",".btnKanbanDelete",(function() {	
		var kanbanNum = this.id;
		var kanbanContent = $(this).siblings('div').text();
		$("#deleteKanbanContent").text(kanbanContent.trim());
		deleteDialog.data('kanbanNum',kanbanNum).dialog("open");
	}));
	
	$(document).on("click",".glyphicon-pencil",(function() {	
		var kanbanNum = $(this).closest('li').prop('id');
		var kanbanContent = $(this).parent('div').text().trim();
		var kanbanDeadline = $(this).parent('div').siblings('span').children('span').text();
		if($(this).siblings('.deletedBoard').length != 0){
			kanbanContent=kanbanContent.replace('[원글삭제됨]','');
		} 
		$("#dialogContent").val(kanbanContent);
		$("#kanbanModifyDeadline").val(kanbanDeadline);
		
		modifyDialog.data('boardLink',$(this).siblings('a').length).dialog("open");
		modifyDialog.data('kanbanNum',kanbanNum);
		modifyDialog.data('deleteBoardClass',$(this).siblings('.deletedBoard').length);
	}));
	
	function updateTodo(item , movingUrl){
		var kanbanNum = item.prop("id");
		var movingLiElement =$("li[id="+kanbanNum+"]");
		
		movingLiElement.removeClass().addClass('todoList ui-sortable-handle');
		movingLiElement.children('div').removeClass().addClass('todoContentDiv');

		var changeElement = movingLiElement.clone(); 
		movingLiElement.remove();
		$("#todo").append(changeElement);
			
		$("li[id="+kanbanNum+"] button").remove();
		$("li[id="+kanbanNum+"] br").remove();
			
		changeElement.removeAttr("style");
		var checkTodoNum = $(".todoList").length;
		$.ajax({
			type: "GET",
			url: movingUrl + kanbanNum + "&kanbanState=TODO&kanbanOrder="+checkTodoNum	
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
			
		$("li[id="+kanbanNum+"] button").remove();
		$("li[id="+kanbanNum+"] br").remove();
			
		changeElement.removeAttr("style");
		var checkDoingNum = $(".doingList").length;
		$.ajax({
			type: "GET",
			url: movingUrl + kanbanNum + "&kanbanState=DOING&kanbanOrder=" + checkDoingNum
		});
	}
	
	function updateDone(item , movingUrl){
		var kanbanNum = item.prop("id");
		var movingLiElement = $("li[id="+kanbanNum+"]");
			
		movingLiElement.removeClass().addClass('doneList ui-sortable-handle');
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
			success : function (){
			}
		
		});
	}
	
	function displayStateNum(){
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
	
	function updateStateNum(item, dropTd){
		var checkTodoNum = $(".todoList").length;
		var checkDoingNum = $(".doingList").length;
		var checkDoneNum =  $(".doneList").length;
	
		if(dropTd =="kanbanTodo"){
			checkTodoNum = checkTodoNum + 1;
		} else if(dropTd == "kanbanDoing"){
			checkDoingNum = checkDoingNum +1  ;
		} else if(dropTd == "kanbanDone"){
			checkDoneNum = checkDoneNum + 1 ;
		}
		
		if(item.hasClass('todoList')){
			checkTodoNum = checkTodoNum - 2;
		} else if(item.hasClass('doingList')){
			checkDoingNum = checkDoingNum  -2  ;
		} else if(item.hasClass('doneList')){
			checkDoneNum = checkDoneNum - 2 ;
		}
		
		$("#todoNum").text(" "+"["+checkTodoNum+"/10]");
		$("#doingNum").text(" "+"["+checkDoingNum+"/6]");
		$("#doneNum").text(" "+"["+checkDoneNum+"/8]");
	}

	