!function($){$("#ace-settings-rtl").removeAttr("checked").on("click",function(){switch_direction()});var switch_direction=function(){function applyChanges(){function swap_classes(class1,class2){$body.find("."+class1).removeClass(class1).addClass("tmp-rtl-"+class1).end().find("."+class2).removeClass(class2).addClass(class1).end().find(".tmp-rtl-"+class1).removeClass("tmp-rtl-"+class1).addClass(class2)}var $body=$(document.body);$body.toggleClass("rtl").find(".dropdown-menu:not(.datepicker-dropdown,.colorpicker)").toggleClass("dropdown-menu-right").end().find(".pull-right:not(.dropdown-menu,blockquote,.profile-skills .pull-right)").removeClass("pull-right").addClass("tmp-rtl-pull-right").end().find(".pull-left:not(.dropdown-submenu,.profile-skills .pull-left)").removeClass("pull-left").addClass("pull-right").end().find(".tmp-rtl-pull-right").removeClass("tmp-rtl-pull-right").addClass("pull-left").end().find(".chosen-select").toggleClass("chosen-rtl").next().toggleClass("chosen-rtl"),swap_classes("align-left","align-right"),swap_classes("no-padding-left","no-padding-right"),swap_classes("arrowed","arrowed-right"),swap_classes("arrowed-in","arrowed-in-right"),swap_classes("tabs-left","tabs-right"),swap_classes("messagebar-item-left","messagebar-item-right"),$(".modal.aside-vc").ace_aside("flip").ace_aside("insideContainer"),$(".fa").each(function(){if(!(this.className.match(/ui-icon/)||$(this).closest(".fc-button").length>0))for(var l=this.attributes.length,i=0;l>i;i++){var val=this.attributes[i].value;val.match(/fa\-(?:[\w\-]+)\-left/)?this.attributes[i].value=val.replace(/fa\-([\w\-]+)\-(left)/i,"fa-$1-right"):val.match(/fa\-(?:[\w\-]+)\-right/)&&(this.attributes[i].value=val.replace(/fa\-([\w\-]+)\-(right)/i,"fa-$1-left"))}});var rtl=$body.hasClass("rtl");rtl?($(".scroll-hz").addClass("make-ltr").find(".scroll-content").wrapInner('<div class="make-rtl" />'),$(".sidebar[data-sidebar-hover=true]").ace_sidebar_hover("changeDir","right")):($(".scroll-hz").removeClass("make-ltr").find(".make-rtl").children().unwrap(),$(".sidebar[data-sidebar-hover=true]").ace_sidebar_hover("changeDir","left")),$.fn.ace_scroll&&$(".scroll-hz").ace_scroll("reset");try{var placeholder=$("#piechart-placeholder");if(placeholder.length>0){var pos=$(document.body).hasClass("rtl")?"nw":"ne";placeholder.data("draw").call(placeholder.get(0),placeholder,placeholder.data("chart"),pos)}}catch(e){}ace.helper.redraw(document.body,!0)}if(0==$("#ace-rtl-stylesheet").length){var ace_style=$("head").find("link.ace-main-stylesheet");0==ace_style.length&&(ace_style=$("head").find('link[href*="/ace.min.css"],link[href*="/ace-part2.min.css"]'),0==ace_style.length&&(ace_style=$("head").find('link[href*="/ace.css"],link[href*="/ace-part2.css"]')));var ace_skins=$("head").find("link#ace-skins-stylesheet"),stylesheet_url=ace_style.first().attr("href").replace(/(\.min)?\.css$/i,"-rtl$1.css");$.ajax({url:stylesheet_url}).done(function(){var new_link=jQuery("<link />",{type:"text/css",rel:"stylesheet",id:"ace-rtl-stylesheet"});ace_skins.length>0?new_link.insertAfter(ace_skins):ace_style.length>0?new_link.insertAfter(ace_style.last()):new_link.appendTo("head"),new_link.attr("href",stylesheet_url),applyChanges()})}else applyChanges()}}(jQuery);