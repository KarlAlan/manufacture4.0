!function($){$(document).on("reload.ace.widget",".widget-box",function(){var $box=$(this);setTimeout(function(){$box.trigger("reloaded.ace.widget")},parseInt(1e3*Math.random()+1e3))})}(window.jQuery);