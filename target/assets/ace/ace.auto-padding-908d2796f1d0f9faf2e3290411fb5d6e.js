!function($){var navbar=$(".navbar").eq(0),navbar_container=$(".navbar-container").eq(0),sidebar=$(".sidebar").eq(0),main_container=$(".main-container").get(0),breadcrumbs=$(".breadcrumbs").eq(0),page_content=$(".page-content").get(0),default_padding=8;navbar.length>0&&($(window).on("resize.auto_padding",function(){if("fixed"==navbar.css("position")){var padding1=ace.vars.nav_collapse?navbar_container.outerHeight():navbar.outerHeight();if(padding1=parseInt(padding1),main_container.style.paddingTop=padding1+"px",ace.vars.non_auto_fixed&&sidebar.length>0&&(sidebar.get(0).style.top="fixed"==sidebar.css("position")?padding1+"px":""),breadcrumbs.length>0)if("fixed"==breadcrumbs.css("position")){var padding2=default_padding+breadcrumbs.outerHeight()+parseInt(breadcrumbs.css("margin-top"));padding2=parseInt(padding2),page_content.style.paddingTop=padding2+"px",ace.vars.non_auto_fixed&&(breadcrumbs.get(0).style.top=padding1+"px")}else page_content.style.paddingTop="",ace.vars.non_auto_fixed&&(breadcrumbs.get(0).style.top="")}else main_container.style.paddingTop="",page_content.style.paddingTop="",ace.vars.non_auto_fixed&&(sidebar.length>0&&(sidebar.get(0).style.top=""),breadcrumbs.length>0&&(breadcrumbs.get(0).style.top=""))}).triggerHandler("resize.auto_padding"),$(document).on("settings.ace.auto_padding",function(ev,event_name){("navbar_fixed"==event_name||"breadcrumbs_fixed"==event_name)&&(ace.vars.webkit&&(navbar.get(0).offsetHeight,breadcrumbs.length>0&&breadcrumbs.get(0).offsetHeight),$(window).triggerHandler("resize.auto_padding"))}))}(window.jQuery);