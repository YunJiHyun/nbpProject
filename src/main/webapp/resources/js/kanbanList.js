/**
 * 
 */
	$(document).ready(function() {
		var movingUrl = "/jihyunboard/kanban/update?kanbanNum=";
		todoList = $(".todoList");
		doingList = $(".doingList"); 
		doneList = $(".doneList");
		var checkTodoNum = todoList.length;
		$("#todoNum").text(" "+"["+checkTodoNum+"/10]");
		
		var checkDoingNum = doingList.length;
		$("#doingNum").text(" "+"["+checkDoingNum+"/6]");
		
		var checkDoneNum = doneList.length;
		$("#doneNum").text(" "+"["+checkDoneNum+"/8]");
				
		//영역 못 벗어나게 draggable
		 $( "#todo, #doing, #done" ).sortable({
			connectWith: "ul",
			containment: "tbody", 
			scroll: false,
			revert : "invalid",
			cursor: "move"
		});
		
		$( "#todo, #doing, #done").disableSelection();
		
		
		$("#kanbanTodo").droppable({
			accept:".doingList, .doneList",
			drop: function( event, ui ) {
				updateTodo(ui.draggable, movingUrl);
			}
		});
		
		$("#kanbanDoing").droppable({
			accept: ".todoList, .doneList",
			drop: function( event, ui ) {
				updateDoing(ui.draggable, movingUrl);
			}
		});
		
		$("#kanbanDone").droppable({
			accept:".todoList, .doingList",
			drop: function( event, ui ) {
				updateDone(ui.draggable, movingUrl);
			}
		});
		
		$(".btnKanbanDelete").click(function() {	
			var kanbanNum = this.id;
			$.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=DELETE",
				success: function(){
					kanbanList();
				} 
			});
		}); 
	});
	
	function updateTodo(item , movingUrl){
		item.fadeOut('fast',function(){
			var kanbanNum = item.prop("id");
			 $.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=TODO",
				success: function(todoNum){
					if(todoNum >= 10){
						alert("TODO은 10개까지만 가능합니다");
					}
					
				} 	
			});
		});
	}
	
	function updateDoing(item , movingUrl){
		item.fadeOut('fast',function(){
			var kanbanNum = item.prop("id");
			 $.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=DOING",
				success: function(doingNum){
					if(doingNum >= 6){
						alert("DOING은 6개까지만 가능합니다");
					}
					kanbanList();
				} 	
			});
		}); 
	}
	
	function updateDone(item , movingUrl){
		item.fadeOut('fast',function(){
			var kanbanNum = item.prop("id");
			 $.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=DONE",
				success: function(doneNum){
					if(doneNum >= 8){
						alert("DONE은 8개까지만 가능합니다");
					}
					kanbanList();
				} 	
			});
		});
	}
	
	function kanbanThisList(partition){
		$.ajax({
			type: "GET",
			url: "/jihyunboard/kanban/kanbanPartList?partition=" + partition,
			success: function(result){
				if(partition == "TODO"){
					alert("성공");
					//$("#kanbanBoard").html(result);
				}
			}
		});
	}
	