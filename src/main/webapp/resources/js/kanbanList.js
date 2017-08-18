/**
 * 
 */
	$(document).ready(function() {
		var movingUrl = "/jihyunboard/kanban/update?kanbanNum=";
		updateStateNum();
		
		//영역 못 벗어나게 draggable
		 $( "#todo, #doing, #done" ).sortable({
			connectWith: "ul",
			containment: "tbody", 
			scroll: false,
			revert : true,
			cursor: "move",
		}).disableSelection();
		
		$("#kanbanTodo").droppable({
			accept:".doingList, .doneList",
			drop: function( event, ui ) {
				updateTodo(ui.draggable, movingUrl);
				removePlaceHolder();
			}
		});
		
		$("#kanbanDoing").droppable({
			accept: ".todoList, .doneList",
			drop: function( event, ui ) {
				if($(".doingList").length >=6){
					return false;
				}
				updateDoing(ui.draggable, movingUrl);
				removePlaceHolder();
			}
		});
		
		$("#kanbanDone").droppable({
			accept:".todoList, .doingList",
			drop: function( event, ui ) {
				updateDone(ui.draggable, movingUrl);
				removePlaceHolder();
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
			
			
			$.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=TODO",
				success: function(todoNum){
					if(todoNum >= 10){
						alert("TODO은 10개까지만 가능합니다");
					}
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
			
			 $.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=DOING",
				success: function(doingNum){
					if(doingNum >= 6){
						alert("DOING은 6개까지만 가능합니다");
					}
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
			 $.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=DONE",
				success: function(doneNum){
					if(doneNum >= 8){
						alert("DONE은 8개까지만 가능합니다");
					}
				} 	
			});
	}
	function removePlaceHolder(){
		$("li").remove(".ui-sortable-placeholder");
		updateStateNum();
	}
	function updateStateNum(){
		var checkTodoNum = $(".todoList").length;
		$("#todoNum").text(" "+"["+checkTodoNum+"/10]");
		
		var checkDoingNum = $(".doingList").length;
		$("#doingNum").text(" "+"["+checkDoingNum+"/6]");
		
		var checkDoneNum =  $(".doneList").length;
		$("#doneNum").text(" "+"["+checkDoneNum+"/8]");
	
	}

	