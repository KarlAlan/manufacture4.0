!function($,document,window){function $tag(tag,id,css){var element=document.createElement(tag);return id&&(element.id=prefix+id),css&&(element.style.cssText=css),$(element)}function winheight(){return window.innerHeight?window.innerHeight:$(window).height()}function Settings(element,options){options!==Object(options)&&(options={}),this.cache={},this.el=element,this.value=function(key){var dataAttr;return void 0===this.cache[key]&&(dataAttr=$(this.el).attr("data-cbox-"+key),void 0!==dataAttr?this.cache[key]=dataAttr:void 0!==options[key]?this.cache[key]=options[key]:void 0!==defaults[key]&&(this.cache[key]=defaults[key])),this.cache[key]},this.get=function(key){var value=this.value(key);return $.isFunction(value)?value.call(this.el,this):value}}function getIndex(increment){var max=$related.length,newIndex=(index+increment)%max;return 0>newIndex?max+newIndex:newIndex}function setSize(size,dimension){return Math.round((/%/.test(size)?("x"===dimension?$window.width():winheight())/100:1)*parseInt(size,10))}function isImage(settings,url){return settings.get("photo")||settings.get("photoRegex").test(url)}function retinaUrl(settings,url){return settings.get("retinaUrl")&&window.devicePixelRatio>1?url.replace(settings.get("photoRegex"),settings.get("retinaSuffix")):url}function trapFocus(e){"contains"in $box[0]&&!$box[0].contains(e.target)&&e.target!==$overlay[0]&&(e.stopPropagation(),$box.focus())}function setClass(str){setClass.str!==str&&($box.add($overlay).removeClass(setClass.str).addClass(str),setClass.str=str)}function getRelated(rel){index=0,rel&&rel!==!1&&"nofollow"!==rel?($related=$("."+boxElement).filter(function(){var options=$.data(this,colorbox),settings=new Settings(this,options);return settings.get("rel")===rel}),index=$related.index(settings.el),-1===index&&($related=$related.add(settings.el),index=$related.length-1)):$related=$(settings.el)}function trigger(event){$(document).trigger(event),$events.triggerHandler(event)}function launch(element){var options;if(!closing){if(options=$(element).data(colorbox),settings=new Settings(element,options),getRelated(settings.get("rel")),!open){open=active=!0,setClass(settings.get("className")),$box.css({visibility:"hidden",display:"block",opacity:""}),$loaded=$tag(div,"LoadedContent","width:0; height:0; overflow:hidden; visibility:hidden"),$content.css({width:"",height:""}).append($loaded),interfaceHeight=$topBorder.height()+$bottomBorder.height()+$content.outerHeight(!0)-$content.height(),interfaceWidth=$leftBorder.width()+$rightBorder.width()+$content.outerWidth(!0)-$content.width(),loadedHeight=$loaded.outerHeight(!0),loadedWidth=$loaded.outerWidth(!0);var initialWidth=setSize(settings.get("initialWidth"),"x"),initialHeight=setSize(settings.get("initialHeight"),"y"),maxWidth=settings.get("maxWidth"),maxHeight=settings.get("maxHeight");settings.w=(maxWidth!==!1?Math.min(initialWidth,setSize(maxWidth,"x")):initialWidth)-loadedWidth-interfaceWidth,settings.h=(maxHeight!==!1?Math.min(initialHeight,setSize(maxHeight,"y")):initialHeight)-loadedHeight-interfaceHeight,$loaded.css({width:"",height:settings.h}),publicMethod.position(),trigger(event_open),settings.get("onOpen"),$groupControls.add($title).hide(),$box.focus(),settings.get("trapFocus")&&document.addEventListener&&(document.addEventListener("focus",trapFocus,!0),$events.one(event_closed,function(){document.removeEventListener("focus",trapFocus,!0)})),settings.get("returnFocus")&&$events.one(event_closed,function(){$(settings.el).focus()})}var opacity=parseFloat(settings.get("opacity"));$overlay.css({opacity:opacity===opacity?opacity:"",cursor:settings.get("overlayClose")?"pointer":"",visibility:"visible"}).show(),settings.get("closeButton")?$close.html(settings.get("close")).appendTo($content):$close.appendTo("<div/>"),load()}}function appendHTML(){$box||(init=!1,$window=$(window),$box=$tag(div).attr({id:colorbox,"class":$.support.opacity===!1?prefix+"IE":"",role:"dialog",tabindex:"-1"}).hide(),$overlay=$tag(div,"Overlay").hide(),$loadingOverlay=$([$tag(div,"LoadingOverlay")[0],$tag(div,"LoadingGraphic")[0]]),$wrap=$tag(div,"Wrapper"),$content=$tag(div,"Content").append($title=$tag(div,"Title"),$current=$tag(div,"Current"),$prev=$('<button type="button"/>').attr({id:prefix+"Previous"}),$next=$('<button type="button"/>').attr({id:prefix+"Next"}),$slideshow=$tag("button","Slideshow"),$loadingOverlay),$close=$('<button type="button"/>').attr({id:prefix+"Close"}),$wrap.append($tag(div).append($tag(div,"TopLeft"),$topBorder=$tag(div,"TopCenter"),$tag(div,"TopRight")),$tag(div,!1,"clear:left").append($leftBorder=$tag(div,"MiddleLeft"),$content,$rightBorder=$tag(div,"MiddleRight")),$tag(div,!1,"clear:left").append($tag(div,"BottomLeft"),$bottomBorder=$tag(div,"BottomCenter"),$tag(div,"BottomRight"))).find("div div").css({"float":"left"}),$loadingBay=$tag(div,!1,"position:absolute; width:9999px; visibility:hidden; display:none; max-width:none;"),$groupControls=$next.add($prev).add($current).add($slideshow)),document.body&&!$box.parent().length&&$(document.body).append($overlay,$box.append($wrap,$loadingBay))}function addBindings(){function clickHandler(e){e.which>1||e.shiftKey||e.altKey||e.metaKey||e.ctrlKey||(e.preventDefault(),launch(this))}return $box?(init||(init=!0,$next.click(function(){publicMethod.next()}),$prev.click(function(){publicMethod.prev()}),$close.click(function(){publicMethod.close()}),$overlay.click(function(){settings.get("overlayClose")&&publicMethod.close()}),$(document).bind("keydown."+prefix,function(e){var key=e.keyCode;open&&settings.get("escKey")&&27===key&&(e.preventDefault(),publicMethod.close()),open&&settings.get("arrowKey")&&$related[1]&&!e.altKey&&(37===key?(e.preventDefault(),$prev.click()):39===key&&(e.preventDefault(),$next.click()))}),$.isFunction($.fn.on)?$(document).on("click."+prefix,"."+boxElement,clickHandler):$("."+boxElement).live("click."+prefix,clickHandler)),!0):!1}function load(){var href,setResize,$inline,prep=publicMethod.prep,request=++requests;if(active=!0,photo=!1,trigger(event_purge),trigger(event_load),settings.get("onLoad"),settings.h=settings.get("height")?setSize(settings.get("height"),"y")-loadedHeight-interfaceHeight:settings.get("innerHeight")&&setSize(settings.get("innerHeight"),"y"),settings.w=settings.get("width")?setSize(settings.get("width"),"x")-loadedWidth-interfaceWidth:settings.get("innerWidth")&&setSize(settings.get("innerWidth"),"x"),settings.mw=settings.w,settings.mh=settings.h,settings.get("maxWidth")&&(settings.mw=setSize(settings.get("maxWidth"),"x")-loadedWidth-interfaceWidth,settings.mw=settings.w&&settings.w<settings.mw?settings.w:settings.mw),settings.get("maxHeight")&&(settings.mh=setSize(settings.get("maxHeight"),"y")-loadedHeight-interfaceHeight,settings.mh=settings.h&&settings.h<settings.mh?settings.h:settings.mh),href=settings.get("href"),loadingTimer=setTimeout(function(){$loadingOverlay.show()},100),settings.get("inline")){var $target=$(href);$inline=$("<div>").hide().insertBefore($target),$events.one(event_purge,function(){$inline.replaceWith($target)}),prep($target)}else settings.get("iframe")?prep(" "):settings.get("html")?prep(settings.get("html")):isImage(settings,href)?(href=retinaUrl(settings,href),photo=new Image,$(photo).addClass(prefix+"Photo").bind("error",function(){prep($tag(div,"Error").html(settings.get("imgError")))}).one("load",function(){request===requests&&setTimeout(function(){var percent;$.each(["alt","longdesc","aria-describedby"],function(i,val){var attr=$(settings.el).attr(val)||$(settings.el).attr("data-"+val);attr&&photo.setAttribute(val,attr)}),settings.get("retinaImage")&&window.devicePixelRatio>1&&(photo.height=photo.height/window.devicePixelRatio,photo.width=photo.width/window.devicePixelRatio),settings.get("scalePhotos")&&(setResize=function(){photo.height-=photo.height*percent,photo.width-=photo.width*percent},settings.mw&&photo.width>settings.mw&&(percent=(photo.width-settings.mw)/photo.width,setResize()),settings.mh&&photo.height>settings.mh&&(percent=(photo.height-settings.mh)/photo.height,setResize())),settings.h&&(photo.style.marginTop=Math.max(settings.mh-photo.height,0)/2+"px"),$related[1]&&(settings.get("loop")||$related[index+1])&&(photo.style.cursor="pointer",photo.onclick=function(){publicMethod.next()}),photo.style.width=photo.width+"px",photo.style.height=photo.height+"px",prep(photo)},1)}),photo.src=href):href&&$loadingBay.load(href,settings.get("data"),function(data,status){request===requests&&prep("error"===status?$tag(div,"Error").html(settings.get("xhrError")):$(this).contents())})}var $overlay,$box,$wrap,$content,$topBorder,$leftBorder,$rightBorder,$bottomBorder,$related,$window,$loaded,$loadingBay,$loadingOverlay,$title,$current,$slideshow,$next,$prev,$close,$groupControls,settings,interfaceHeight,interfaceWidth,loadedHeight,loadedWidth,index,photo,open,active,closing,loadingTimer,publicMethod,init,defaults={html:!1,photo:!1,iframe:!1,inline:!1,transition:"elastic",speed:300,fadeOut:300,width:!1,initialWidth:"600",innerWidth:!1,maxWidth:!1,height:!1,initialHeight:"450",innerHeight:!1,maxHeight:!1,scalePhotos:!0,scrolling:!0,opacity:.9,preloading:!0,className:!1,overlayClose:!0,escKey:!0,arrowKey:!0,top:!1,bottom:!1,left:!1,right:!1,fixed:!1,data:void 0,closeButton:!0,fastIframe:!0,open:!1,reposition:!0,loop:!0,slideshow:!1,slideshowAuto:!0,slideshowSpeed:2500,slideshowStart:"start slideshow",slideshowStop:"stop slideshow",photoRegex:/\.(gif|png|jp(e|g|eg)|bmp|ico|webp|jxr|svg)((#|\?).*)?$/i,retinaImage:!1,retinaUrl:!1,retinaSuffix:"@2x.$1",current:"image {current} of {total}",previous:"previous",next:"next",close:"close",xhrError:"This content failed to load.",imgError:"This image failed to load.",returnFocus:!0,trapFocus:!0,onOpen:!1,onLoad:!1,onComplete:!1,onCleanup:!1,onClosed:!1,rel:function(){return this.rel},href:function(){return $(this).attr("href")},title:function(){return this.title}},colorbox="colorbox",prefix="cbox",boxElement=prefix+"Element",event_open=prefix+"_open",event_load=prefix+"_load",event_complete=prefix+"_complete",event_cleanup=prefix+"_cleanup",event_closed=prefix+"_closed",event_purge=prefix+"_purge",$events=$("<a/>"),div="div",requests=0,previousCSS={},slideshow=function(){function clear(){clearTimeout(timeOut)}function set(){(settings.get("loop")||$related[index+1])&&(clear(),timeOut=setTimeout(publicMethod.next,settings.get("slideshowSpeed")))}function start(){$slideshow.html(settings.get("slideshowStop")).unbind(click).one(click,stop),$events.bind(event_complete,set).bind(event_load,clear),$box.removeClass(className+"off").addClass(className+"on")}function stop(){clear(),$events.unbind(event_complete,set).unbind(event_load,clear),$slideshow.html(settings.get("slideshowStart")).unbind(click).one(click,function(){publicMethod.next(),start()}),$box.removeClass(className+"on").addClass(className+"off")}function reset(){active=!1,$slideshow.hide(),clear(),$events.unbind(event_complete,set).unbind(event_load,clear),$box.removeClass(className+"off "+className+"on")}var active,timeOut,className=prefix+"Slideshow_",click="click."+prefix;return function(){active?settings.get("slideshow")||($events.unbind(event_cleanup,reset),reset()):settings.get("slideshow")&&$related[1]&&(active=!0,$events.one(event_cleanup,reset),settings.get("slideshowAuto")?start():stop(),$slideshow.show())}}();$[colorbox]||($(appendHTML),publicMethod=$.fn[colorbox]=$[colorbox]=function(options,callback){var settings,$obj=this;if(options=options||{},$.isFunction($obj))$obj=$("<a/>"),options.open=!0;else if(!$obj[0])return $obj;return $obj[0]?(appendHTML(),addBindings()&&(callback&&(options.onComplete=callback),$obj.each(function(){var old=$.data(this,colorbox)||{};$.data(this,colorbox,$.extend(old,options))}).addClass(boxElement),settings=new Settings($obj[0],options),settings.get("open")&&launch($obj[0])),$obj):$obj},publicMethod.position=function(speed,loadedCallback){function modalDimensions(){$topBorder[0].style.width=$bottomBorder[0].style.width=$content[0].style.width=parseInt($box[0].style.width,10)-interfaceWidth+"px",$content[0].style.height=$leftBorder[0].style.height=$rightBorder[0].style.height=parseInt($box[0].style.height,10)-interfaceHeight+"px"}var css,scrollTop,scrollLeft,top=0,left=0,offset=$box.offset();if($window.unbind("resize."+prefix),$box.css({top:-9e4,left:-9e4}),scrollTop=$window.scrollTop(),scrollLeft=$window.scrollLeft(),settings.get("fixed")?(offset.top-=scrollTop,offset.left-=scrollLeft,$box.css({position:"fixed"})):(top=scrollTop,left=scrollLeft,$box.css({position:"absolute"})),left+=settings.get("right")!==!1?Math.max($window.width()-settings.w-loadedWidth-interfaceWidth-setSize(settings.get("right"),"x"),0):settings.get("left")!==!1?setSize(settings.get("left"),"x"):Math.round(Math.max($window.width()-settings.w-loadedWidth-interfaceWidth,0)/2),top+=settings.get("bottom")!==!1?Math.max(winheight()-settings.h-loadedHeight-interfaceHeight-setSize(settings.get("bottom"),"y"),0):settings.get("top")!==!1?setSize(settings.get("top"),"y"):Math.round(Math.max(winheight()-settings.h-loadedHeight-interfaceHeight,0)/2),$box.css({top:offset.top,left:offset.left,visibility:"visible"}),$wrap[0].style.width=$wrap[0].style.height="9999px",css={width:settings.w+loadedWidth+interfaceWidth,height:settings.h+loadedHeight+interfaceHeight,top:top,left:left},speed){var tempSpeed=0;$.each(css,function(i){return css[i]!==previousCSS[i]?void(tempSpeed=speed):void 0}),speed=tempSpeed}previousCSS=css,speed||$box.css(css),$box.dequeue().animate(css,{duration:speed||0,complete:function(){modalDimensions(),active=!1,$wrap[0].style.width=settings.w+loadedWidth+interfaceWidth+"px",$wrap[0].style.height=settings.h+loadedHeight+interfaceHeight+"px",settings.get("reposition")&&setTimeout(function(){$window.bind("resize."+prefix,publicMethod.position)},1),$.isFunction(loadedCallback)&&loadedCallback()},step:modalDimensions})},publicMethod.resize=function(options){var scrolltop;open&&(options=options||{},options.width&&(settings.w=setSize(options.width,"x")-loadedWidth-interfaceWidth),options.innerWidth&&(settings.w=setSize(options.innerWidth,"x")),$loaded.css({width:settings.w}),options.height&&(settings.h=setSize(options.height,"y")-loadedHeight-interfaceHeight),options.innerHeight&&(settings.h=setSize(options.innerHeight,"y")),options.innerHeight||options.height||(scrolltop=$loaded.scrollTop(),$loaded.css({height:"auto"}),settings.h=$loaded.height()),$loaded.css({height:settings.h}),scrolltop&&$loaded.scrollTop(scrolltop),publicMethod.position("none"===settings.get("transition")?0:settings.get("speed")))},publicMethod.prep=function(object){function getWidth(){return settings.w=settings.w||$loaded.width(),settings.w=settings.mw&&settings.mw<settings.w?settings.mw:settings.w,settings.w}function getHeight(){return settings.h=settings.h||$loaded.height(),settings.h=settings.mh&&settings.mh<settings.h?settings.mh:settings.h,settings.h}if(open){var callback,speed="none"===settings.get("transition")?0:settings.get("speed");$loaded.remove(),$loaded=$tag(div,"LoadedContent").append(object),$loaded.hide().appendTo($loadingBay.show()).css({width:getWidth(),overflow:settings.get("scrolling")?"auto":"hidden"}).css({height:getHeight()}).prependTo($content),$loadingBay.hide(),$(photo).css({"float":"none"}),setClass(settings.get("className")),callback=function(){function removeFilter(){$.support.opacity===!1&&$box[0].style.removeAttribute("filter")}var iframe,complete,total=$related.length;open&&(complete=function(){clearTimeout(loadingTimer),$loadingOverlay.hide(),trigger(event_complete),settings.get("onComplete")},$title.html(settings.get("title")).show(),$loaded.show(),total>1?("string"==typeof settings.get("current")&&$current.html(settings.get("current").replace("{current}",index+1).replace("{total}",total)).show(),$next[settings.get("loop")||total-1>index?"show":"hide"]().html(settings.get("next")),$prev[settings.get("loop")||index?"show":"hide"]().html(settings.get("previous")),slideshow(),settings.get("preloading")&&$.each([getIndex(-1),getIndex(1)],function(){var img,i=$related[this],settings=new Settings(i,$.data(i,colorbox)),src=settings.get("href");src&&isImage(settings,src)&&(src=retinaUrl(settings,src),img=document.createElement("img"),img.src=src)})):$groupControls.hide(),settings.get("iframe")?(iframe=document.createElement("iframe"),"frameBorder"in iframe&&(iframe.frameBorder=0),"allowTransparency"in iframe&&(iframe.allowTransparency="true"),settings.get("scrolling")||(iframe.scrolling="no"),$(iframe).attr({src:settings.get("href"),name:(new Date).getTime(),"class":prefix+"Iframe",allowFullScreen:!0}).one("load",complete).appendTo($loaded),$events.one(event_purge,function(){iframe.src="//about:blank"}),settings.get("fastIframe")&&$(iframe).trigger("load")):complete(),"fade"===settings.get("transition")?$box.fadeTo(speed,1,removeFilter):removeFilter())},"fade"===settings.get("transition")?$box.fadeTo(speed,0,function(){publicMethod.position(0,callback)}):publicMethod.position(speed,callback)}},publicMethod.next=function(){!active&&$related[1]&&(settings.get("loop")||$related[index+1])&&(index=getIndex(1),launch($related[index]))},publicMethod.prev=function(){!active&&$related[1]&&(settings.get("loop")||index)&&(index=getIndex(-1),launch($related[index]))},publicMethod.close=function(){open&&!closing&&(closing=!0,open=!1,trigger(event_cleanup),settings.get("onCleanup"),$window.unbind("."+prefix),$overlay.fadeTo(settings.get("fadeOut")||0,0),$box.stop().fadeTo(settings.get("fadeOut")||0,0,function(){$box.hide(),$overlay.hide(),trigger(event_purge),$loaded.remove(),setTimeout(function(){closing=!1,trigger(event_closed),settings.get("onClosed")},1)}))},publicMethod.remove=function(){$box&&($box.stop(),$[colorbox].close(),$box.stop(!1,!0).remove(),$overlay.remove(),closing=!1,$box=null,$("."+boxElement).removeData(colorbox).removeClass(boxElement),$(document).unbind("click."+prefix).unbind("keydown."+prefix))},publicMethod.element=function(){return $(settings.el)},publicMethod.settings=defaults)}(jQuery,document,window);