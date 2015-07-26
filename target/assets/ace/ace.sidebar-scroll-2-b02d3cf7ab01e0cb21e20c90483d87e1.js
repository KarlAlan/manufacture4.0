!function($,undefined){function Sidebar_Scroll(sidebar,settings){var self=this,$window=$(window),$sidebar=$(sidebar),$nav=$sidebar.find(".nav-list"),$toggle=$sidebar.find(".sidebar-toggle").eq(0),$shortcuts=$sidebar.find(".sidebar-shortcuts").eq(0),nav=$nav.get(0);if(nav){var ace_sidebar=$sidebar.ace_sidebar("ref");$sidebar.attr("data-sidebar-scroll","true");var submenu_hover=function(){return"absolute"==$sidebar.first("li.hover > .submenu").css("position")},scroll_div=null,scroll_content=null,ace_scroll=null;this.is_scrolling=!1;var _initiated=!1;this.sidebar_fixed=is_element_pos(sidebar,"fixed");var $avail_height,$content_height,scroll_to_active=settings.scroll_to_active||ace.helper.boolAttr(sidebar,"data-scroll-to-active")||!1,include_shortcuts=settings.include_shortcuts||ace.helper.boolAttr(sidebar,"data-scroll-include-shortcuts")||!1,include_toggle=settings.include_toggle||ace.helper.boolAttr(sidebar,"data-scroll-include-toggle")||!1,scroll_style=settings.scroll_style||$sidebar.attr("data-scroll-style")||"";this.only_if_fixed=(settings.only_if_fixed||ace.helper.boolAttr(sidebar,"data-scroll-only-fixed"))&&!0;var lockAnyway=settings.mousewheel_lock||ace.helper.boolAttr(sidebar,"data-mousewheel-lock")||!1,available_height=function(){var offset=$nav.parent().offset();return self.sidebar_fixed&&(offset.top-=ace.helper.scrollTop()),$window.innerHeight()-offset.top-(include_toggle?0:$toggle.outerHeight())},content_height=function(){return nav.scrollHeight},initiate=function(on_page_load){if(!_initiated&&!(self.only_if_fixed&&!self.sidebar_fixed||submenu_hover())){if($nav.wrap('<div class="nav-wrap-up" />'),include_shortcuts&&0!=$shortcuts.length&&$nav.parent().prepend($shortcuts),include_toggle&&0!=$toggle.length&&$nav.parent().append($toggle),scroll_div=$nav.parent().ace_scroll({size:available_height(),reset:!0,mouseWheelLock:!0,lockAnyway:lockAnyway,styleClass:scroll_style,hoverReset:!1}).closest(".ace-scroll").addClass("nav-scroll"),ace_scroll=scroll_div.data("ace_scroll"),scroll_content=scroll_div.find(".scroll-content").eq(0),old_safari&&!include_toggle){var toggle=$toggle.get(0);toggle&&scroll_content.on("scroll.safari",function(){ace.helper.redraw(toggle)})}_initiated=!0,1==on_page_load&&(self.reset(),scroll_to_active&&self.scroll_to_active(),scroll_to_active=!1)}};this.scroll_to_active=function(){if(ace_scroll&&ace_scroll.is_active())try{var $active,vars=ace_sidebar.vars(),nav_list=$sidebar.find(".nav-list");vars.minimized&&!vars.collapsible?$active=nav_list.find("> .active"):($active=$nav.find("> .active.hover"),0==$active.length&&($active=$nav.find(".active:not(.open)")));var top=$active.outerHeight();nav_list=nav_list.get(0);for(var active=$active.get(0);active!=nav_list;)top+=active.offsetTop,active=active.parentNode;var scroll_amount=top-scroll_div.height();scroll_amount>0&&scroll_content.scrollTop(scroll_amount)}catch(e){}},this.reset=function(recalc){if(recalc===!0&&(this.sidebar_fixed=is_element_pos(sidebar,"fixed")),this.only_if_fixed&&!this.sidebar_fixed||submenu_hover())return void this.disable();_initiated||initiate(),$sidebar.addClass("sidebar-scroll");var vars=ace_sidebar.vars(),enable_scroll=!vars.minimized&&!vars.collapsible&&!vars.horizontal&&($avail_height=available_height())<($content_height=nav.parentNode.scrollHeight);this.is_scrolling=!0,enable_scroll&&ace_scroll&&(ace_scroll.update({size:$avail_height}),ace_scroll.enable(),ace_scroll.reset()),enable_scroll&&ace_scroll.is_active()||this.is_scrolling&&this.disable()},this.disable=function(){this.is_scrolling=!1,ace_scroll&&ace_scroll.disable(),$sidebar.removeClass("sidebar-scroll")},this.prehide=function(height_change){if(this.is_scrolling&&!ace_sidebar.get("minimized"))if(content_height()+height_change<available_height())this.disable();else if(0>height_change){var scroll_top=scroll_content.scrollTop()+height_change;if(0>scroll_top)return;scroll_content.scrollTop(scroll_top)}},this._reset=function(recalc){recalc===!0&&(this.sidebar_fixed=is_element_pos(sidebar,"fixed")),ace.vars.webkit?setTimeout(function(){self.reset()},0):this.reset()},this.get=function(name){return this.hasOwnProperty(name)?this[name]:void 0},this.set=function(name,value){this.hasOwnProperty(name)&&(this[name]=value)},this.ref=function(){return this},this.updateStyle=function(styleClass){null!=ace_scroll&&ace_scroll.update({styleClass:styleClass})},$sidebar.on("hidden.ace.submenu.sidebar_scroll shown.ace.submenu.sidebar_scroll",".submenu",function(e){e.stopPropagation(),ace_sidebar.get("minimized")||self._reset()}),initiate(!0)}}var old_safari=ace.vars.safari&&navigator.userAgent.match(/version\/[1-5]/i),is_element_pos="getComputedStyle"in window?function(el,pos){return el.offsetHeight,window.getComputedStyle(el).position==pos}:function(el,pos){return el.offsetHeight,$(el).css("position")==pos};$(document).on("settings.ace.sidebar_scroll",function(ev,event_name,event_val){$(".sidebar[data-sidebar-scroll=true]").each(function(){var $this=$(this),sidebar_scroll=$this.ace_sidebar_scroll("ref");if("sidebar_collapsed"==event_name)"true"==$this.attr("data-sidebar-hover")&&$this.ace_sidebar_hover("reset"),1==event_val?sidebar_scroll.disable():sidebar_scroll.reset();else if("sidebar_fixed"===event_name||"navbar_fixed"===event_name){var is_scrolling=sidebar_scroll.get("is_scrolling"),sidebar_fixed=is_element_pos(this,"fixed");sidebar_scroll.set("sidebar_fixed",sidebar_fixed),sidebar_fixed&&!is_scrolling?sidebar_scroll.reset():!sidebar_fixed&&sidebar_scroll.get("only_if_fixed")&&sidebar_scroll.disable()}})}),$(window).on("resize.ace.sidebar_scroll",function(){$(".sidebar[data-sidebar-scroll=true]").each(function(){var sidebar_scroll=$(this).ace_sidebar_scroll("ref"),sidebar_fixed=is_element_pos(this,"fixed");sidebar_scroll.set("sidebar_fixed",sidebar_fixed),sidebar_scroll.reset()})}),$.fn.ace_sidebar_scroll||($.fn.ace_sidebar_scroll=function(option,value){var method_call,$set=this.each(function(){var $this=$(this),data=$this.data("ace_sidebar_scroll"),options="object"==typeof option&&option;data||$this.data("ace_sidebar_scroll",data=new Sidebar_Scroll(this,options)),"string"==typeof option&&"function"==typeof data[option]&&(method_call=data[option](value))});return method_call===undefined?$set:method_call})}(window.jQuery);