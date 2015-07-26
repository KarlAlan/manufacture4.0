!function($){"use strict";var Image=function(options){this.init("image",options,Image.defaults),"on_error"in options.image&&(this.on_error=options.image.on_error,delete options.image.on_error),"on_success"in options.image&&(this.on_success=options.image.on_success,delete options.image.on_success),"max_size"in options.image&&(this.max_size=options.image.max_size,delete options.image.max_size),this.initImage(options,Image.defaults)};$.fn.editableutils.inherit(Image,$.fn.editabletypes.abstractinput),$.extend(Image.prototype,{initImage:function(options,defaults){this.options.image=$.extend({},defaults.image,options.image),this.name=this.options.image.name||"editable-image-input"},render:function(){var self=this;this.$input=this.$tpl.find("input[type=hidden]:eq(0)"),this.$file=this.$tpl.find("input[type=file]:eq(0)"),this.$file.attr({name:this.name}),this.$input.attr({name:this.name+"-hidden"}),this.options.image.allowExt=this.options.image.allowExt||["jpg","jpeg","png","gif"],this.options.image.allowMime=this.options.image.allowMime||["image/jpg","image/jpeg","image/png","image/gif"],this.options.image.maxSize=self.max_size||this.options.image.maxSize||!1,this.options.image.before_remove=this.options.image.before_remove||function(){return self.$input.val(null),!0},this.$file.ace_file_input(this.options.image).on("change",function(){var $rand=self.$file.val()||self.$file.data("ace_input_files")?Math.random()+""+(new Date).getTime():null;self.$input.val($rand)}).closest(".ace-file-input").css({width:"150px"}).closest(".editable-input").addClass("editable-image"),this.$file.off("file.error.ace").on("file.error.ace",function(e,info){self.on_error&&(info.error_count.ext>0||info.error_count.mime>0?self.on_error(1):info.error_count.size>0&&self.on_error(2))})}}),Image.defaults=$.extend({},$.fn.editabletypes.abstractinput.defaults,{tpl:'<span><input type="hidden" /></span><span><input type="file" /></span>',inputclass:"",image:{style:"well",btn_choose:"Change Image",btn_change:null,no_icon:"fa fa-picture-o",thumbnail:"large"}}),$.fn.editabletypes.image=Image}(window.jQuery),function($){"use strict";var Wysiwyg=function(options){this.init("wysiwyg",options,Wysiwyg.defaults),this.options.wysiwyg=$.extend({},Wysiwyg.defaults.wysiwyg,options.wysiwyg)};$.fn.editableutils.inherit(Wysiwyg,$.fn.editabletypes.abstractinput),$.extend(Wysiwyg.prototype,{render:function(){this.$editor=this.$input.nextAll(".wysiwyg-editor:eq(0)"),this.$tpl.parent().find(".wysiwyg-editor").show().ace_wysiwyg({toolbar:["bold","italic","strikethrough","underline",null,"foreColor",null,"insertImage"]}).prev().addClass("wysiwyg-style2").closest(".editable-input").addClass("editable-wysiwyg").closest(".editable-container").css({display:"block"}),this.options.wysiwyg&&this.options.wysiwyg.css&&this.$tpl.closest(".editable-wysiwyg").css(this.options.wysiwyg.css)},value2html:function(value,element){return $(element).html(value),!1},html2value:function(html){return html},value2input:function(value){this.$editor.html(value)},input2value:function(){return this.$editor.html()},activate:function(){}}),Wysiwyg.defaults=$.extend({},$.fn.editabletypes.abstractinput.defaults,{tpl:'<input type="hidden" /><div class="wysiwyg-editor"></div>',inputclass:"editable-wysiwyg",wysiwyg:{}}),$.fn.editabletypes.wysiwyg=Wysiwyg}(window.jQuery),function($){"use strict";var Spinner=function(options){this.init("spinner",options,Spinner.defaults),this.initSpinner(options,Spinner.defaults),this.nativeUI=!1;try{var tmp_inp=document.createElement("INPUT");tmp_inp.type="number",this.nativeUI="number"===tmp_inp.type&&this.options.spinner.nativeUI===!0}catch(e){}};$.fn.editableutils.inherit(Spinner,$.fn.editabletypes.abstractinput),$.extend(Spinner.prototype,{initSpinner:function(options,defaults){this.options.spinner=$.extend({},defaults.spinner,options.spinner)},render:function(){},activate:function(){if(this.$input.is(":visible"))if(this.$input.focus(),$.fn.editableutils.setCursorPosition(this.$input.get(0),this.$input.val().length),this.nativeUI){this.$input.get(0).type="number";for(var options=["min","max","step"],o=0;o<options.length;o++)options[o]in this.options.spinner&&this.$input.attr(options[o],this.options.spinner[options[o]])}else{var val=parseInt(this.$input.val()),options=$.extend({value:val},this.options.spinner);this.$input.ace_spinner(options)}},autosubmit:function(){this.$input.keydown(function(e){13===e.which&&$(this).closest("form").submit()})}}),Spinner.defaults=$.extend({},$.fn.editabletypes.abstractinput.defaults,{tpl:'<input type="text" />',inputclass:"",spinner:{min:0,max:100,step:1,icon_up:"fa fa-plus",icon_down:"fa fa-minus",btn_up_class:"btn-success",btn_down_class:"btn-danger"}}),$.fn.editabletypes.spinner=Spinner}(window.jQuery),function($){"use strict";var Slider=function(options){this.init("slider",options,Slider.defaults),this.initSlider(options,Slider.defaults),this.nativeUI=!1;try{var tmp_inp=document.createElement("INPUT");tmp_inp.type="range",this.nativeUI="range"===tmp_inp.type&&this.options.slider.nativeUI===!0}catch(e){}};$.fn.editableutils.inherit(Slider,$.fn.editabletypes.abstractinput),$.extend(Slider.prototype,{initSlider:function(options,defaults){this.options.slider=$.extend({},defaults.slider,options.slider)},render:function(){},activate:function(){if(this.$input.is(":visible"))if(this.$input.focus(),$.fn.editableutils.setCursorPosition(this.$input.get(0),this.$input.val().length),this.nativeUI){this.$input.get(0).type="range";for(var options=["min","max","step"],o=0;o<options.length;o++)options[o]in this.options.slider&&(this.$input[0][options[o]]=this.options.slider[options[o]]);var width=this.options.slider.width||200;this.$input.parent().addClass("editable-slider").css("width",width+"px")}else{var self=this,val=parseInt(this.$input.val()),width=this.options.slider.width||200,options=$.extend(this.options.slider,{value:val,slide:function(event,ui){var val=parseInt(ui.value);self.$input.val(val),null==ui.handle.firstChild&&$(ui.handle).prepend("<div class='tooltip top in' style='display:none; top:-38px; left:-5px;'><div class='tooltip-arrow'></div><div class='tooltip-inner'></div></div>"),$(ui.handle.firstChild).show().children().eq(1).text(val)}});this.$input.parent().addClass("editable-slider").css("width",width+"px").slider(options)}},value2html:function(){},autosubmit:function(){this.$input.keydown(function(e){13===e.which&&$(this).closest("form").submit()})}}),Slider.defaults=$.extend({},$.fn.editabletypes.abstractinput.defaults,{tpl:'<input type="text" /><span class="inline ui-slider-green"><span class="slider-display"></span></span>',inputclass:"",slider:{min:1,max:100,step:1,range:"min"}}),$.fn.editabletypes.slider=Slider}(window.jQuery),function($){"use strict";var ADate=function(options){this.init("adate",options,ADate.defaults),this.initDate(options,ADate.defaults),this.nativeUI=!1;try{var tmp_inp=document.createElement("INPUT");tmp_inp.type="date",this.nativeUI="date"===tmp_inp.type&&this.options.date.nativeUI===!0}catch(e){}};$.fn.editableutils.inherit(ADate,$.fn.editabletypes.abstractinput),$.extend(ADate.prototype,{initDate:function(options,defaults){this.options.date=$.extend({},defaults.date,options.date)},render:function(){this.$input=this.$tpl.find("input.date")},activate:function(){if(this.$input.is(":visible")&&this.$input.focus(),this.nativeUI)this.$input.get(0).type="date";else{var inp=this.$input;this.$input.datepicker(this.options.date);var picker=inp.data("datepicker");picker&&inp.on("click",function(){picker.show()}).siblings(".input-group-addon").on("click",function(){picker.show()})}},autosubmit:function(){this.$input.keydown(function(e){13===e.which&&$(this).closest("form").submit()})}}),ADate.defaults=$.extend({},$.fn.editabletypes.abstractinput.defaults,{tpl:'<div class="input-group input-group-compact"><input type="text" class="input-medium date" /><span class="input-group-addon"><i class="fa fa-calendar"></i></span></div>',date:{weekStart:0,startView:0,minViewMode:0}}),$.fn.editabletypes.adate=ADate}(window.jQuery);