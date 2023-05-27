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

jQuery.fn.center = function() {
	this.css("position", "absolute");
	this.css("top", Math.max(0, (($(window).height() - $(this)
			.outerHeight()) / 2)
			+ $(window).scrollTop())
			+ "px");
	this.css("left", Math.max(0,
			(($(window).width() - $(this).outerWidth()) / 2)
					+ $(window).scrollLeft())
			+ "px");
	return this;
}

$(document).ready(function(){

  var $window = $(window),
    $document = $(document),
    $html = $('html'),
    $body = $('body');

	//swiper : s
	/*var swiper = new Swiper('.swiper-container', {
		slidesPerView: 1,
		speed: 400,
		loop:true,
		autoplay: {
			delay: 4500,
			disableOnInteraction: false,
		},
		pagination: {
			el: '.swiper-pagination'
		}
	});*/
	//swiper : e

	//롤링영역의 링크 포커스 이동 scroll 컨텐츠
//	$(".slide-wrap").on("click", function(){
//		$("html, body").animate({scrollTop:625}, 'slow');
//	});

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

  $(document).on('click', '.js-modal__btn-open', function(e){
  /*$('.js-modal__btn-open').on('click', function(e) {*/
    e.preventDefault();
    var _$this = $(this),
      _$modal = $(_$this.attr('href'));
    if(_$modal.length > 0) _$modal.addClass('is-expanded').attr('tabindex', '0').focus();


	 /* .is-expanded 추가 후 sly 초기화  */
    var $frame = $('#slide-floor');
    var $wrap = $frame.parent();
    // Call Sly on frame
    $frame.sly({
      horizontal: 1,
      itemNav: 'forceCentered',
      smart: 1,
      activateMiddle: 1,
      activateOn: 'click',
      mouseDragging: 1,
      touchDragging: 1,
      releaseSwing: 1,
      startAt: 0,
      scrollBar: $wrap.find('.scrollbar'),
      scrollBy: 1,
      speed: 300,
      elasticBounds: 1,
      easing: 'easeOutExpo',
      dragHandle: 1,
      dynamicHandle: 1,
      clickBar: 1,

      // Buttons
      prev: $wrap.find('.prev'),
      next: $wrap.find('.next')
    });
  });
  $(document).on('click', '.js-modal__btn-close', function(e){
  /*$('.js-modal__btn-close').on('click', function(e) {*/
    e.preventDefault();
    var _$this = $(this),
        _$modal = _$this.closest('.js-modal'),
        _$btn = $(_$this.attr('href'));
    _$modal.removeClass('is-expanded').attr('tabindex', '-1');
    if(_$btn.length > 0) _$btn.focus();
  });
  // modal : e

  // magnet header : s
	var $containerTabs = $('.container-tabs');
	var $containerBody = $('#contents-inner');
	if($containerTabs.length){
		var containerTabsScroll = function(){
			var _windowTop = $window.scrollTop(),
			_containerBodyTop = $containerBody.offset().top,
			_containerBodyHeight = $containerBody.height();
			//console.log(_containerBodyTop , _containerBodyHeight , _windowTop);
			if((_containerBodyTop - 83) > _windowTop ){
				$containerTabs.removeClass('is-expanded');
				$containerBody.css("padding-top",0);
				return false;
			}
			if((_containerBodyTop - 83)<= _windowTop  && !$containerTabs.hasClass('is-expanded')){
				$containerTabs.addClass('is-expanded');
				$containerBody.css("padding-top",56);
			}
		}
	}
  // magnet header : e

// window scroll : s
//  $(window).on('scroll', function(){
//    containerTabsScroll();
//  });
  // window scroll : e

});