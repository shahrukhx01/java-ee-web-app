/**
 * Created by amaar on 7/2/2015.
 */
$(window).load(function () {
	
    $('#login , #signup').click(function(){
        var s_container=$('#signup_container');
        var classList =s_container.attr('class').split(/\s+/);
        $.each( classList, function(index, item){
            if (item === 'hidden_container') {
                $('#signup_container').removeClass(item);
            }
        });

        s_container.toggleClass('hiden visible');
        $('#login_container').toggleClass('hiden visible');
        $('.hiden').slideUp(1000);
        $('.visible').fadeIn(3000);

    });
});

//$("#notifications_menu").mCustomScrollbar();



$(document).ready(function () {
	$('#search_results , #myModal , #myModal1, #missing_result').on('shown.bs.modal', function() {
	       $("body.modal-open").removeAttr("style");
	      
	});
	});
$(document).ready(function () {
	$('#search_results , #myModal , #myModal1, #missing_result').on('hidden.bs.modal', function() {
		
	       $("body").removeAttr("style");
	      
	 });
	});
function showSignup(){
	$('#msgAlert').show();
	$('#signup_container').toggleClass('hiden visible');
    $('#login_container').toggleClass('hiden visible');
    $('.hiden').hide();
	$('#signup_container').removeClass('hidden_container');
}
function validateText(id)
{
	if($("#"+id).val()==null || $("#"+id).val()==""){
		var div=$("#"+id).closest("div");
		$("#glypcn"+id).remove();
		div.addClass("has-error has-feedback");
		div.append('<span id="glypcn'+id+'" class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
		return false;
	}
	else{
		var div=$("#"+id).closest("div");
		$("#glypcn"+id).remove();
		div.removeClass("has-error");
		div.addClass("has-success has-feedback");
		div.append(' <span id="glypcn'+id+'" class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
		return true;

	}


}


$(document).ready(
	function(){
		
		$('#registerbtn').click(function(){
			
			if(!validateText('registerfname')){
				return false;
			}
			if(!validateText('registerlname')){
				return false;
			}
			if(!validateText('registercnic')){
				return false;
			}
			if(!validateText('registermob')){
				return false;
			}
			if(!validateText('registeraddr')){
				return false;
			}
			if(!validateText('registeremail')){
				return false;
			}
			if(!validateText('registerpass')){
				return false;
			}
			if(!validateText('registerpassrepeat')){
				return false;
			}
			$("form#registerform").submit();
		});
	});

$(document).ready(function(){
	
	$('#complaint_btn').click(function(){
		
		
		if(!validateText('fname')){
			return false;
		}
		if(!validateText('lname')){
			return false;
		}
		if(!validateText('mobile')){
			return false;
		}
		if(!validateText('address')){
			return false;
		}
		if(!validateText('ftname')){
			return false;
		}
		if(!validateText('cnic')){
			return false;
		}
		if($("#district option:selected").val()==null || $("#district option:selected").val()==""){
			return false;
		}
		if($("#home_station option:selected").val()==null || $("#home_station option:selected").val()==""){
			return false;
		}
		if(!validateText('idate')){
			return false;
		}
		if(!validateText('iplace')){
			return false;
		}
		if(!validateText('itime')){
			return false;
		}
		
		if($("#idistrict option:selected").val()==null || $("#idistrict option:selected").val()==""){
			return false;
		}
		if($("#istation option:selected").val()==null || $("#istation option:selected").val()==""){
			return false;
		}
		if(!validateText('idescrp')){
			return false;
		}
		

        $("form#comp_form").submit();
		
		
	});
});

$(document).ready(function(){
	
	$('#contact_btn').click(function(){
		
		
		if(!validateText('sub')){
			return false;
		}
		if(!validateText('message')){
			return false;
		}
		
        $("form#cont_form").submit();
		
		
	});
});



$(document).ready(function(){
	
	$('.msg_link').click(function(){
		
		
		sub=event.target.id;
		
		
		$('#myModal1').modal('toggle');
		
		
		$.post('select_coversation.jsp',{search_item:sub},function(msg){
		    msg=msg.trim();   
		    
			$('#conversation').html(msg);
			
		    });
		
		
		
		
	});
});


$(document).ready(function(){
	
	$('.cat_link').click(function(){
		
		//alert("asas");
		id=event.target.id;
		
		$('#hidden_id').val(id);
		
		
		
	});
});

$(document).ready(function(){
	
	$('.img_link').click(function(){
		
		//alert("asas");
		id=event.target.id;
		ids=id.split('_');
		ids[0]=ids[0].trim();
		ids[1]=ids[1].trim();
		$('#img_id').val(ids[0]);
		$('#c_hidden_id').val(ids[1]);
		
		
		
	});
});

$(document).ready(function(){
	
	$('#send_btn').click(function(){
		var msg=$('#msg').val();
		
		if( msg!= null && msg!=""){
		
			$('#msg').val("");
		
		sub=$('#subject').val();
		$.post('/E_Crime_File_Management_System/AdminMessages',{subject:sub,c_message:msg,status:"s"},function(msg1){
		  
			
			refresh_messages();
		    });
		
		}
		
		
	});
});

$(document).ready(function(){
	
	$('#main_search').keyup(function(){
		search=$('#main_search').val();
		
		//alert(search);
		if(search!="" && search!=null){
		$.post('instant_search.jsp',{search_item:search},function(msg){
		    msg=msg.trim();   
		 //  alert(msg);
			$('#result_list').html(msg);
			
		    });
		}
		else{
			$('#result_list').html("");
			
		}
		
	});
});
$(document).ready(function(){
	
	$('#search_btn').click(function(){
		search=$('#main_search').val();
		
		
		 //alert('aaa');
		if(search!="" && search!=null){
		$.post('search_results.jsp',{search_item:search},function(msg){
		    msg=msg.trim();   
			$('#result_list').html("");
			$('#main_search').val("");
			$('#search_content').html(msg);
			
		    });
		}
		else{
			$('#search_content').html("<h2>No results....</h2>");
			
		}
		
	});
});

	
	function show_missing(element){
		
		
		id=element.getAttribute("id");
		// alert(id);
		
		$.post('missing_person_result.jsp',{search_item:id},function(msg){
		    msg=msg.trim();   
			
			$('#missing_content').html(msg);
			$('#result_list').html("");
			$('#main_search').val("");
		    });
		
	}

$(document).ready(function(){
	
	$('#user_send_btn').click(function(){
var msg=$('#msg').val();
		
		if( msg!= null && msg!=""){
		user_id=$('#user_id').val();
			$('#msg').val("");
		
		sub=$('#subject').val();
		
		//alert(msg+sub+user_id);
		$.post('/E_Crime_File_Management_System/PoliceMessages',{id:user_id,complain_id:sub,c_message:msg,status:"s"},function(msg1){
		  
			
			
			sub=$('#subject').val();
			$.post('police_chat_select.jsp',{},function(msg){
			    msg=msg.trim();   
			    
				$('#conversation').html(msg);
				
			    });
			

		});
		
		}
		
		
		
		
	});
});

$(document).ready(function(){
	
	$('#police_send_btn').click(function(){
var msg=$('#msg').val();
		
		if( msg!= null && msg!=""){
		user_id=$('#user_id').val();
			$('#msg').val("");
		
		sub=$('#subject').val();
		
		//alert(msg+sub+user_id);
		$.post('/E_Crime_File_Management_System/PoliceMessages',{id:user_id,complain_id:sub,c_message:msg,status:"r"},function(msg1){
		  
			
			
			sub=$('#subject').val();
			$.post('police_chat_select.jsp',{},function(msg){
			    msg=msg.trim();   
			    
				$('#conversation').html(msg);
				
			    });
			

		});
		
		}
		
		
		
		
	});
});


$(document).ready(function(){
	
	$('#admin_send_btn').click(function(){
		var msg=$('#msg').val();
		
		if( msg!= null && msg!=""){
		user_id=$('#user_id').val();
			$('#msg').val("");
		
		sub=$('#subject').val();
		$.post('/E_Crime_File_Management_System/AdminMessages',{id:user_id,subject:sub,c_message:msg,status:"r"},function(msg1){
		  
			
			
			sub=$('#subject').val();
			$.post('admin_select_conversation.jsp',{search_item:sub},function(msg){
			    msg=msg.trim();   
			    
				$('#conversation').html(msg);
				
			    });
			

		});
		
		}
		
		
	});
});

function refresh_messages(){
	sub=$('#subject').val();
	$.post('select_coversation.jsp',{search_item:sub},function(msg){
	    msg=msg.trim();   
	    
		$('#conversation').html(msg);
		
	    });
	
}




$(document).ready(
		function() {

			var navListItems = $('ul.setup-panel li a'), allWells = $('.setup-content');

			allWells.hide();

			navListItems.click(function(e) {
				e.preventDefault();
				var $target = $($(this).attr('href')), $item = $(
						this).closest('li');

				if (!$item.hasClass('disabled')) {
					navListItems.closest('li')
							.removeClass('active');
					$item.addClass('active');
					allWells.hide();
					$target.show();
				}
			});

			$('ul.setup-panel li.active a').trigger('click');

			$('#activate-step-2').on(
					'click',
					function(e) {
						if(!validateText('fname')){
							return false;
						}
						if(!validateText('lname')){
							return false;
						}
						if(!validateText('age')){
							return false;
						}
						if(!validateText('sex')){
							return false;
						}
						if(!validateText('address')){
							return false;
						}
						if(!validateText('inches')){
							return false;
						}
						if(!validateText('feet')){
							return false;
						}


						
						$('ul.setup-panel li:eq(1)').removeClass(
								'disabled');
						$('ul.setup-panel li a[href="#step-2"]')
								.trigger('click');
						$(this).remove();
					})

					$('#a-step-2').on(
					'click',
					function(e) {
						if(!validateText('fname')){
							return false;
						}
						if(!validateText('lname')){
							return false;
						}
						if(!validateText('age')){
							return false;
						}
						if($('#sex').val()==null || $('#sex').val()==""){
							return false;
						}
					
						if(!validateText('address')){
							return false;
						}
						if($('#psycho').val()==null || $('#psycho').val()==""){
							return false;
						}
						if($('#marital').val()==null || $('#marital').val()==""){
							return false;
						}
						if(!validateText('last_seen')){
							return false;
						}
						$('ul.setup-panel li:eq(1)').removeClass(
								'disabled');
						$('ul.setup-panel li a[href="#step-2"]')
								.trigger('click');
						$(this).remove();
					});

					
			$('#act-step-2').on(
					'click',
					function(e) {
						if(!validateText('date')){
							return false;
						}
						//alert($('#date').val());
						
						if(!validateText('homocide')){
							return false;
						}
						if(!validateText('rape')){
							return false;
						}
						if(!validateText('robbery')){
							return false;
						}
						if(!validateText('theft')){
							return false;
						}
						if(!validateText('assault')){
							return false;
						}
						
						
						$('ul.setup-panel li:eq(1)').removeClass(
								'disabled');
						$('ul.setup-panel li a[href="#step-2"]')
								.trigger('click');
						$(this).remove();
					});

					
					
					$('#activate-step-3').on(
					'click',
					function(e) {
						if(!validateText('arrested')){
							return false;
						}
						if(!validateText('bounty')){
							return false;
						}
						if(!validateText('descrp')){
							return false;
						}
						
						
						$('ul.setup-panel li:eq(2)').removeClass(
								'disabled');
						$('ul.setup-panel li a[href="#step-3"]')
								.trigger('click');
						$(this).remove();
					})

		});

