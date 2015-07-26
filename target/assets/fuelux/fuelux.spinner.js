!function(factory){"function"==typeof define&&define.amd?define(["jquery"],factory):factory(jQuery)}(function($,undefined){var old=$.fn.spinbox,Spinbox=function(element,options){this.$element=$(element),this.options=$.extend({},$.fn.spinbox.defaults,options),this.$input=this.$element.find(".spinbox-input"),this.$element.on("focusin.fu.spinbox",this.$input,$.proxy(this.changeFlag,this)),this.$element.on("focusout.fu.spinbox",this.$input,$.proxy(this.change,this)),this.$element.on("keydown.fu.spinbox",this.$input,$.proxy(this.keydown,this)),this.$element.on("keyup.fu.spinbox",this.$input,$.proxy(this.keyup,this)),this.bindMousewheelListeners(),this.mousewheelTimeout={},this.options.hold?(this.$element.on("mousedown.fu.spinbox",".spinbox-up",$.proxy(function(){this.startSpin(!0)},this)),this.$element.on("mouseup.fu.spinbox",".spinbox-up, .spinbox-down",$.proxy(this.stopSpin,this)),this.$element.on("mouseout.fu.spinbox",".spinbox-up, .spinbox-down",$.proxy(this.stopSpin,this)),this.$element.on("mousedown.fu.spinbox",".spinbox-down",$.proxy(function(){this.startSpin(!1)},this))):(this.$element.on("click.fu.spinbox",".spinbox-up",$.proxy(function(){this.step(!0)},this)),this.$element.on("click.fu.spinbox",".spinbox-down",$.proxy(function(){this.step(!1)},this))),this.switches={count:1,enabled:!0},this.switches.speed="medium"===this.options.speed?300:"fast"===this.options.speed?100:500,this.lastValue=this.options.value,this.render(),this.options.disabled&&this.disable()};Spinbox.prototype={constructor:Spinbox,destroy:function(){return this.$element.remove(),this.$element.find("input").each(function(){$(this).attr("value",$(this).val())}),this.$element[0].outerHTML},render:function(){var inputValue=this.parseInput(this.$input.val()),maxUnitLength="";""!==inputValue&&0===this.options.value?this.value(inputValue):this.output(this.options.value),this.options.units.length&&$.each(this.options.units,function(index,value){value.length>maxUnitLength.length&&(maxUnitLength=value)})},output:function(value,updateField){return value=(value+"").split(".").join(this.options.decimalMark),updateField=updateField||!0,updateField&&this.$input.val(value),value},parseInput:function(value){return value=(value+"").split(this.options.decimalMark).join(".")},change:function(){var newVal=this.parseInput(this.$input.val())||"";this.options.units.length||"."!==this.options.decimalMark?newVal=this.parseValueWithUnit(newVal):newVal/1?newVal=this.options.value=this.checkMaxMin(newVal/1):(newVal=this.checkMaxMin(newVal.replace(/[^0-9.-]/g,"")||""),this.options.value=newVal/1),this.output(newVal),this.changeFlag=!1,this.triggerChangedEvent()},changeFlag:function(){this.changeFlag=!0},stopSpin:function(){this.switches.timeout!==undefined&&(clearTimeout(this.switches.timeout),this.switches.count=1,this.triggerChangedEvent())},triggerChangedEvent:function(){var currentValue=this.value();currentValue!==this.lastValue&&(this.lastValue=currentValue,this.$element.trigger("changed.fu.spinbox",this.output(currentValue,!1)))},startSpin:function(type){if(!this.options.disabled){var divisor=this.switches.count;1===divisor?(this.step(type),divisor=1):divisor=3>divisor?1.5:8>divisor?2.5:4,this.switches.timeout=setTimeout($.proxy(function(){this.iterate(type)},this),this.switches.speed/divisor),this.switches.count++}},iterate:function(type){this.step(type),this.startSpin(type)},step:function(isIncrease){var digits,multiple,currentValue,limitValue;if(this.changeFlag&&this.change(),currentValue=this.options.value,limitValue=isIncrease?this.options.max:this.options.min,isIncrease?limitValue>currentValue:currentValue>limitValue){var newVal=currentValue+(isIncrease?1:-1)*this.options.step;this.options.step%1!==0&&(digits=(this.options.step+"").split(".")[1].length,multiple=Math.pow(10,digits),newVal=Math.round(newVal*multiple)/multiple),this.value((isIncrease?newVal>limitValue:limitValue>newVal)?limitValue:newVal)}else if(this.options.cycle){var cycleVal=isIncrease?this.options.min:this.options.max;this.value(cycleVal)}},value:function(value){return value||0===value?this.options.units.length||"."!==this.options.decimalMark?(this.output(this.parseValueWithUnit(value+(this.unit||""))),this):!isNaN(parseFloat(value))&&isFinite(value)?(this.options.value=value/1,this.output(value+(this.unit?this.unit:"")),this):void 0:(this.changeFlag&&this.change(),this.unit?this.options.value+this.unit:this.output(this.options.value,!1))},isUnitLegal:function(unit){var legalUnit;return $.each(this.options.units,function(index,value){return value.toLowerCase()===unit.toLowerCase()?(legalUnit=unit.toLowerCase(),!1):void 0}),legalUnit},parseValueWithUnit:function(value){var unit=value.replace(/[^a-zA-Z]/g,""),number=value.replace(/[^0-9.-]/g,"");return unit&&(unit=this.isUnitLegal(unit)),this.options.value=this.checkMaxMin(number/1),this.unit=unit||undefined,this.options.value+(unit||"")},checkMaxMin:function(value){return isNaN(parseFloat(value))?value:(value<=this.options.max&&value>=this.options.min||(value=value>=this.options.max?this.options.max:this.options.min),value)},disable:function(){this.options.disabled=!0,this.$element.addClass("disabled"),this.$input.attr("disabled",""),this.$element.find("button").addClass("disabled")},enable:function(){this.options.disabled=!1,this.$element.removeClass("disabled"),this.$input.removeAttr("disabled"),this.$element.find("button").removeClass("disabled")},keydown:function(event){var keyCode=event.keyCode;38===keyCode?this.step(!0):40===keyCode&&this.step(!1)},keyup:function(event){var keyCode=event.keyCode;(38===keyCode||40===keyCode)&&this.triggerChangedEvent()},bindMousewheelListeners:function(){var inputEl=this.$input.get(0);inputEl.addEventListener?(inputEl.addEventListener("mousewheel",$.proxy(this.mousewheelHandler,this),!1),inputEl.addEventListener("DOMMouseScroll",$.proxy(this.mousewheelHandler,this),!1)):inputEl.attachEvent("onmousewheel",$.proxy(this.mousewheelHandler,this))},mousewheelHandler:function(event){var e=window.event||event,delta=Math.max(-1,Math.min(1,e.wheelDelta||-e.detail)),self=this;return clearTimeout(this.mousewheelTimeout),this.mousewheelTimeout=setTimeout(function(){self.triggerChangedEvent()},300),this.step(delta>0?!0:!1),e.preventDefault?e.preventDefault():e.returnValue=!1,!1}},$.fn.spinbox=function(option){var methodReturn,args=Array.prototype.slice.call(arguments,1),$set=this.each(function(){var $this=$(this),data=$this.data("fu.spinbox"),options="object"==typeof option&&option;data||$this.data("fu.spinbox",data=new Spinbox(this,options)),"string"==typeof option&&(methodReturn=data[option].apply(data,args))});return methodReturn===undefined?$set:methodReturn},$.fn.spinbox.defaults={value:0,min:0,max:999,step:1,hold:!0,speed:"medium",disabled:!1,cycle:!1,units:[],decimalMark:"."},$.fn.spinbox.Constructor=Spinbox,$.fn.spinbox.noConflict=function(){return $.fn.spinbox=old,this},$(document).on("mousedown.fu.spinbox.data-api","[data-initialize=spinbox]",function(e){var $control=$(e.target).closest(".spinbox");$control.data("fu.spinbox")||$control.spinbox($control.data())}),$(function(){$("[data-initialize=spinbox]").each(function(){var $this=$(this);$this.data("fu.spinbox")||$this.spinbox($this.data())})})});