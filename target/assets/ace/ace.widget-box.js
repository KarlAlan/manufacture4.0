!function($,undefined){function applyScrollbars($widget,enable){var $main=$widget.find(".widget-main");$(window).off("resize.widget.scroll");var nativeScrollbars=ace.vars.old_ie||ace.vars.touch;if(enable){var ace_scroll=$main.data("ace_scroll");ace_scroll&&$main.data("save_scroll",{size:ace_scroll.size,lock:ace_scroll.lock,lock_anyway:ace_scroll.lock_anyway});var size=$widget.height()-$widget.find(".widget-header").height()-10;size=parseInt(size),$main.css("min-height",size),nativeScrollbars?(ace_scroll&&$main.ace_scroll("disable"),$main.css("max-height",size).addClass("overflow-scroll")):(ace_scroll?$main.ace_scroll("update",{size:size,mouseWheelLock:!0,lockAnyway:!0}):$main.ace_scroll({size:size,mouseWheelLock:!0,lockAnyway:!0}),$main.ace_scroll("enable").ace_scroll("reset")),$(window).on("resize.widget.scroll",function(){var size=$widget.height()-$widget.find(".widget-header").height()-10;size=parseInt(size),$main.css("min-height",size),nativeScrollbars?$main.css("max-height",size).addClass("overflow-scroll"):$main.ace_scroll("update",{size:size}).ace_scroll("reset")})}else{$main.css("min-height","");var saved_scroll=$main.data("save_scroll");saved_scroll&&$main.ace_scroll("update",{size:saved_scroll.size,mouseWheelLock:saved_scroll.lock,lockAnyway:saved_scroll.lock_anyway}).ace_scroll("enable").ace_scroll("reset"),nativeScrollbars?$main.css("max-height","").removeClass("overflow-scroll"):saved_scroll||$main.ace_scroll("disable")}}var Widget_Box=function(box){this.$box=$(box);this.reload=function(){var $box=this.$box,$remove_position=!1;"static"==$box.css("position")&&($remove_position=!0,$box.addClass("position-relative")),$box.append('<div class="widget-box-overlay"><i class="'+ace.vars.icon+'loading-icon fa fa-spinner fa-spin fa-2x white"></i></div>'),$box.one("reloaded.ace.widget",function(){$box.find(".widget-box-overlay").remove(),$remove_position&&$box.removeClass("position-relative")})},this.close=function(){var $box=this.$box,closeSpeed=300;$box.fadeOut(closeSpeed,function(){$box.trigger("closed.ace.widget"),$box.remove()})},this.toggle=function(type,button){var $box=this.$box,$body=$box.find(".widget-body"),$icon=null,event_name="undefined"!=typeof type?type:$box.hasClass("collapsed")?"show":"hide",event_complete_name="show"==event_name?"shown":"hidden";if("undefined"==typeof button&&(button=$box.find("> .widget-header a[data-action=collapse]").eq(0),0==button.length&&(button=null)),button){$icon=button.find(ace.vars[".icon"]).eq(0);var $match,$icon_down=null,$icon_up=null;($icon_down=$icon.attr("data-icon-show"))?$icon_up=$icon.attr("data-icon-hide"):($match=$icon.attr("class").match(/fa\-(.*)\-(up|down)/))&&($icon_down="fa-"+$match[1]+"-down",$icon_up="fa-"+$match[1]+"-up")}var expandSpeed=250,collapseSpeed=200;"show"==event_name?($icon&&$icon.removeClass($icon_down).addClass($icon_up),$body.hide(),$box.removeClass("collapsed"),$body.slideDown(expandSpeed,function(){$box.trigger(event_complete_name+".ace.widget")})):($icon&&$icon.removeClass($icon_up).addClass($icon_down),$body.slideUp(collapseSpeed,function(){$box.addClass("collapsed"),$box.trigger(event_complete_name+".ace.widget")}))},this.hide=function(){this.toggle("hide")},this.show=function(){this.toggle("show")},this.fullscreen=function(){var $icon=this.$box.find("> .widget-header a[data-action=fullscreen]").find(ace.vars[".icon"]).eq(0),$icon_expand=null,$icon_compress=null;($icon_expand=$icon.attr("data-icon1"))?$icon_compress=$icon.attr("data-icon2"):($icon_expand="fa-expand",$icon_compress="fa-compress"),this.$box.hasClass("fullscreen")?($icon.addClass($icon_expand).removeClass($icon_compress),this.$box.removeClass("fullscreen"),applyScrollbars(this.$box,!1)):($icon.removeClass($icon_expand).addClass($icon_compress),this.$box.addClass("fullscreen"),applyScrollbars(this.$box,!0)),this.$box.trigger("fullscreened.ace.widget")}};$.fn.widget_box=function(option,value){var method_call,$set=this.each(function(){var $this=$(this),data=$this.data("widget_box"),options="object"==typeof option&&option;data||$this.data("widget_box",data=new Widget_Box(this,options)),"string"==typeof option&&(method_call=data[option](value))});return method_call===undefined?$set:method_call},$(document).on("click.ace.widget",".widget-header a[data-action]",function(ev){ev.preventDefault();var $this=$(this),$box=$this.closest(".widget-box");if(0!=$box.length&&!$box.hasClass("ui-sortable-helper")){var $widget_box=$box.data("widget_box");$widget_box||$box.data("widget_box",$widget_box=new Widget_Box($box.get(0)));var $action=$this.data("action");if("collapse"==$action){var event,event_name=$box.hasClass("collapsed")?"show":"hide";if($box.trigger(event=$.Event(event_name+".ace.widget")),event.isDefaultPrevented())return;$widget_box.toggle(event_name,$this)}else if("close"==$action){var event;if($box.trigger(event=$.Event("close.ace.widget")),event.isDefaultPrevented())return;$widget_box.close()}else if("reload"==$action){$this.blur();var event;if($box.trigger(event=$.Event("reload.ace.widget")),event.isDefaultPrevented())return;$widget_box.reload()}else if("fullscreen"==$action){var event;if($box.trigger(event=$.Event("fullscreen.ace.widget")),event.isDefaultPrevented())return;$widget_box.fullscreen()}else"settings"==$action&&$box.trigger("setting.ace.widget")}})}(window.jQuery);