jQuery(function($){function startHelp(){if(null===help){help=new Onpage_Help({include_all:!1,base:ace.vars.base||"../..",file_url:get_file_url,section_url:get_section_url,img_url:get_img_url,before_enable:before_enable_help,after_disable:after_disable_help});var help_container=$("#onpage-help-container");help_container.append('<div class="ace-settings-container onpage-help-toggle-container">			<div id="onpage-help-toggle-btn" class="btn btn-app btn-xs btn-info ace-settings-btn onpage-help-toggle-btn">				<i class="onpage-help-toggle-text ace-icon fa fa-question bigger-150"></i>			</div>		</div>'),$("#onpage-help-toggle-btn").on("click",function(e){e.preventDefault(),toggleHelp()}),$(document).on("settings.ace.help",function(ev,event_name,fixed){"main_container_fixed"==event_name&&(fixed?help_container.addClass("container"):help_container.removeClass("container"))}).triggerHandler("settings.ace.help",["main_container_fixed",$(".main-container").hasClass("container")]),$(document).on("ajaxloadcomplete.ace.help",function(){help.update_sections()})}}function toggleHelp(){help.toggle();var toggle_btn=$("#onpage-help-toggle-btn");toggle_btn.find(".onpage-help-toggle-text").removeClass("onpage-help-toggle-text"),toggle_btn.toggleClass("btn-grey btn-info").parent().toggleClass("active")}var help=null,page_settings={},before_enable_help=function(){$("#btn-scroll-up").css("z-index",1e6),page_settings.navbar=ace.settings.is("navbar","fixed"),page_settings.sidebar=ace.settings.is("sidebar","fixed"),page_settings.breadcrumbs=ace.settings.is("breadcrumbs","fixed"),ace.settings.navbar_fixed(null,!1,!1)},after_disable_help=function(){$("#btn-scroll-up").css("z-index",""),page_settings.breadcrumbs&&ace.settings.breadcrumbs_fixed(null,!0,!1),page_settings.sidebar&&ace.settings.sidebar_fixed(null,!0,!1),page_settings.navbar&&ace.settings.navbar_fixed(null,!0,!1)},get_file_url=function(url){return this.settings.base+"/"+url},get_section_url=function(section_name){section_name=section_name||"";var url=section_name.replace(/\..*$/g,""),parts=url.split("/");return 1==parts.length?(0==url.length&&(url="intro"),url+="/index.html"):parts.length>1&&(url+=".html"),this.settings.base+"/docs/sections/"+url},get_img_url=function(src){return this.settings.base+"/docs/"+src};$(window).on("hashchange.start_help",function(){null==help&&"#help"==window.location.hash&&(startHelp(),$(document).on("click.start_help",".sidebar .nav-list a",function(){var href=$(this).attr("href");href.match(/\#help$/)||$(this).attr("href",href+"#help")}))}).triggerHandler("hashchange.start_help"),$(document).on("click",".btn-display-help",function(e){e.preventDefault(),startHelp(),help.is_active()||toggleHelp();var section=$(this).attr("href");help.show_section_help(section)})});