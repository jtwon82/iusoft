function tabDetector() {
  $("body").find(".tab-menu").each(function(){
    var targetLink = $(this).children(".tab-menu__box").hasClass("is-unlink");
    if(!targetLink) {
      var tabCurrent = $(this).children(".tab-menu__box").children(".is-selected").children(".tab-menu__btn").attr("href");
      $(tabCurrent).css({display:"block"});
    } else {
      $(this).siblings(".tab-contents").css({display:"block"});
    }
  });
};

function tabOpener(e) {
  var targetLink = $(this).parent(".tab-menu__list").parent(".tab-menu__box").hasClass("is-unlink");
  if(!targetLink) {
    var a = $(this).parent();
    a.siblings().removeClass("is-selected");
    b = a.attr("class");
    a.addClass("is-selected");
    c = a.children(".tab-menu__btn").attr("href");
    a.parent(".tab-menu__box").parent(".tab-menu").siblings(".tab-contents").css({display:"none"});
    $(c).css({display:"block"});
    e.preventDefault();
  }
};


$(document).ready(function(){

  var $window = $(window),
    $document = $(document),
    $html = $('html'),
    $body = $('body');


  // selecbox : s
  $('.selectbox--type1 select').niceSelect();
  // selectbox : e

  // tab-menu : s
  tabDetector();
  $(".tab-menu .tab-menu__btn").bind("click", tabOpener);
  // tab-menu : e

  // placeholder : s
  var input = document.createElement("input");
  if(('placeholder' in input)==false) {
    $('[placeholder]').focus(function() {
      var i = $(this);
      if(i.val() == i.attr('placeholder')) {
        i.val('').removeClass('placeholder');
        if(i.hasClass('password')) {
          i.removeClass('password');
          this.type='password';
        }
      }
    }).blur(function() {
      var i = $(this);
      if(i.val() == '' || i.val() == i.attr('placeholder')) {
        if(this.type=='password') {
          i.addClass('password');
          this.type='text';
        }
        i.addClass('placeholder').val(i.attr('placeholder'));
      }
    }).blur().parents('form').submit(function() {
      $(this).find('[placeholder]').each(function() {
        var i = $(this);
        if(i.val() == i.attr('placeholder'))
          i.val('');
      })
    });
  }
  // placeholder : e

  // modal : s
  $('.js-modal__btn-open').on('click', function(e) {
    e.preventDefault();
    var _$this = $(this),
      _$modal = $(_$this.attr('href'));
    if(_$modal.length > 0) _$modal.addClass('is-expanded').attr('tabindex', '0').focus();
  });
  $('.js-modal__btn-close').on('click', function(e) {
    e.preventDefault();
    var _$this = $(this),
        _$modal = _$this.closest('.js-modal'),
        _$btn = $(_$this.attr('href'));
    _$modal.removeClass('is-expanded').attr('tabindex', '-1');
    if(_$btn.length > 0) _$btn.focus();
  });
  // modal : e

	$(".switch-inner .switch").on("click", function(){
		if($(this).hasClass("is-on")){
			$(this).parent().parent().find(".switch-txt").text("off");
			$(this).removeClass("is-on");
			$(this).addClass("is-off");
		}else{
			$(this).parent().parent().find(".switch-txt").text("on");
			$(this).removeClass("is-off");
			$(this).addClass("is-on");
		}
	})
//    $( ".date-day" ).datepicker({
//		buttonImageOnly: true,
//		prevText: '이전달',
//		nextText: '다음달',
//		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
//		dayNamesMin:["일","월","화","수","목","금","토"],
//		dateFormat:"mm/dd/yy",
//		changeMonth: true,
//		changeYear: true
//		//showOn: "both",
//		//buttonImage: "../assets/img/btn_date.gif"
//	});

});