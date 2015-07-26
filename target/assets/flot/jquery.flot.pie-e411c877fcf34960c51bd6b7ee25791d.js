!function($){function init(plot){function processDatapoints(plot){processed||(processed=!0,canvas=plot.getCanvas(),target=$(canvas).parent(),options=plot.getOptions(),plot.setData(combine(plot.getData())))}function combine(data){for(var total=0,combined=0,numCombined=0,color=options.series.pie.combine.color,newdata=[],i=0;i<data.length;++i){var value=data[i].data;$.isArray(value)&&1==value.length&&(value=value[0]),$.isArray(value)?value[1]=!isNaN(parseFloat(value[1]))&&isFinite(value[1])?+value[1]:0:value=!isNaN(parseFloat(value))&&isFinite(value)?[1,+value]:[1,0],data[i].data=[value]}for(var i=0;i<data.length;++i)total+=data[i].data[0][1];for(var i=0;i<data.length;++i){var value=data[i].data[0][1];value/total<=options.series.pie.combine.threshold&&(combined+=value,numCombined++,color||(color=data[i].color))}for(var i=0;i<data.length;++i){var value=data[i].data[0][1];(2>numCombined||value/total>options.series.pie.combine.threshold)&&newdata.push($.extend(data[i],{data:[[1,value]],color:data[i].color,label:data[i].label,angle:value*Math.PI*2/total,percent:value/(total/100)}))}return numCombined>1&&newdata.push({data:[[1,combined]],color:color,label:options.series.pie.combine.label,angle:combined*Math.PI*2/total,percent:combined/(total/100)}),newdata}function draw(plot,newCtx){function clear(){ctx.clearRect(0,0,canvasWidth,canvasHeight),target.children().filter(".pieLabel, .pieLabelBackground").remove()}function drawShadow(){var shadowLeft=options.series.pie.shadow.left,shadowTop=options.series.pie.shadow.top,edge=10,alpha=options.series.pie.shadow.alpha,radius=options.series.pie.radius>1?options.series.pie.radius:maxRadius*options.series.pie.radius;if(!(radius>=canvasWidth/2-shadowLeft||radius*options.series.pie.tilt>=canvasHeight/2-shadowTop||edge>=radius)){ctx.save(),ctx.translate(shadowLeft,shadowTop),ctx.globalAlpha=alpha,ctx.fillStyle="#000",ctx.translate(centerLeft,centerTop),ctx.scale(1,options.series.pie.tilt);for(var i=1;edge>=i;i++)ctx.beginPath(),ctx.arc(0,0,radius,0,2*Math.PI,!1),ctx.fill(),radius-=i;ctx.restore()}}function drawPie(){function drawSlice(angle,color,fill){0>=angle||isNaN(angle)||(fill?ctx.fillStyle=color:(ctx.strokeStyle=color,ctx.lineJoin="round"),ctx.beginPath(),Math.abs(angle-2*Math.PI)>1e-9&&ctx.moveTo(0,0),ctx.arc(0,0,radius,currentAngle,currentAngle+angle/2,!1),ctx.arc(0,0,radius,currentAngle+angle/2,currentAngle+angle,!1),ctx.closePath(),currentAngle+=angle,fill?ctx.fill():ctx.stroke())}function drawLabels(){function drawLabel(slice,startAngle,index){if(0==slice.data[0][1])return!0;var text,lf=options.legend.labelFormatter,plf=options.series.pie.label.formatter;text=lf?lf(slice.label,slice):slice.label,plf&&(text=plf(text,slice));var halfAngle=(startAngle+slice.angle+startAngle)/2,x=centerLeft+Math.round(Math.cos(halfAngle)*radius),y=centerTop+Math.round(Math.sin(halfAngle)*radius)*options.series.pie.tilt,html="<span class='pieLabel' id='pieLabel"+index+"' style='position:absolute;top:"+y+"px;left:"+x+"px;'>"+text+"</span>";target.append(html);var label=target.children("#pieLabel"+index),labelTop=y-label.height()/2,labelLeft=x-label.width()/2;if(label.css("top",labelTop),label.css("left",labelLeft),0-labelTop>0||0-labelLeft>0||canvasHeight-(labelTop+label.height())<0||canvasWidth-(labelLeft+label.width())<0)return!1;if(0!=options.series.pie.label.background.opacity){var c=options.series.pie.label.background.color;null==c&&(c=slice.color);var pos="top:"+labelTop+"px;left:"+labelLeft+"px;";$("<div class='pieLabelBackground' style='position:absolute;width:"+label.width()+"px;height:"+label.height()+"px;"+pos+"background-color:"+c+";'></div>").css("opacity",options.series.pie.label.background.opacity).insertBefore(label)}return!0}for(var currentAngle=startAngle,radius=options.series.pie.label.radius>1?options.series.pie.label.radius:maxRadius*options.series.pie.label.radius,i=0;i<slices.length;++i){if(slices[i].percent>=100*options.series.pie.label.threshold&&!drawLabel(slices[i],currentAngle,i))return!1;currentAngle+=slices[i].angle}return!0}var startAngle=Math.PI*options.series.pie.startAngle,radius=options.series.pie.radius>1?options.series.pie.radius:maxRadius*options.series.pie.radius;ctx.save(),ctx.translate(centerLeft,centerTop),ctx.scale(1,options.series.pie.tilt),ctx.save();for(var currentAngle=startAngle,i=0;i<slices.length;++i)slices[i].startAngle=currentAngle,drawSlice(slices[i].angle,slices[i].color,!0);if(ctx.restore(),options.series.pie.stroke.width>0){ctx.save(),ctx.lineWidth=options.series.pie.stroke.width,currentAngle=startAngle;for(var i=0;i<slices.length;++i)drawSlice(slices[i].angle,options.series.pie.stroke.color,!1);ctx.restore()}return drawDonutHole(ctx),ctx.restore(),options.series.pie.label.show?drawLabels():!0}if(target){var canvasWidth=plot.getPlaceholder().width(),canvasHeight=plot.getPlaceholder().height(),legendWidth=target.children().filter(".legend").children().width()||0;ctx=newCtx,processed=!1,maxRadius=Math.min(canvasWidth,canvasHeight/options.series.pie.tilt)/2,centerTop=canvasHeight/2+options.series.pie.offset.top,centerLeft=canvasWidth/2,"auto"==options.series.pie.offset.left?(options.legend.position.match("w")?centerLeft+=legendWidth/2:centerLeft-=legendWidth/2,maxRadius>centerLeft?centerLeft=maxRadius:centerLeft>canvasWidth-maxRadius&&(centerLeft=canvasWidth-maxRadius)):centerLeft+=options.series.pie.offset.left;var slices=plot.getData(),attempts=0;do attempts>0&&(maxRadius*=REDRAW_SHRINK),attempts+=1,clear(),options.series.pie.tilt<=.8&&drawShadow();while(!drawPie()&&REDRAW_ATTEMPTS>attempts);attempts>=REDRAW_ATTEMPTS&&(clear(),target.prepend("<div class='error'>Could not draw pie with labels contained inside canvas</div>")),plot.setSeries&&plot.insertLegend&&(plot.setSeries(slices),plot.insertLegend())}}function drawDonutHole(layer){if(options.series.pie.innerRadius>0){layer.save();var innerRadius=options.series.pie.innerRadius>1?options.series.pie.innerRadius:maxRadius*options.series.pie.innerRadius;layer.globalCompositeOperation="destination-out",layer.beginPath(),layer.fillStyle=options.series.pie.stroke.color,layer.arc(0,0,innerRadius,0,2*Math.PI,!1),layer.fill(),layer.closePath(),layer.restore(),layer.save(),layer.beginPath(),layer.strokeStyle=options.series.pie.stroke.color,layer.arc(0,0,innerRadius,0,2*Math.PI,!1),layer.stroke(),layer.closePath(),layer.restore()}}function isPointInPoly(poly,pt){for(var c=!1,i=-1,l=poly.length,j=l-1;++i<l;j=i)(poly[i][1]<=pt[1]&&pt[1]<poly[j][1]||poly[j][1]<=pt[1]&&pt[1]<poly[i][1])&&pt[0]<(poly[j][0]-poly[i][0])*(pt[1]-poly[i][1])/(poly[j][1]-poly[i][1])+poly[i][0]&&(c=!c);return c}function findNearbySlice(mouseX,mouseY){for(var x,y,slices=plot.getData(),options=plot.getOptions(),radius=options.series.pie.radius>1?options.series.pie.radius:maxRadius*options.series.pie.radius,i=0;i<slices.length;++i){var s=slices[i];if(s.pie.show){if(ctx.save(),ctx.beginPath(),ctx.moveTo(0,0),ctx.arc(0,0,radius,s.startAngle,s.startAngle+s.angle/2,!1),ctx.arc(0,0,radius,s.startAngle+s.angle/2,s.startAngle+s.angle,!1),ctx.closePath(),x=mouseX-centerLeft,y=mouseY-centerTop,ctx.isPointInPath){if(ctx.isPointInPath(mouseX-centerLeft,mouseY-centerTop))return ctx.restore(),{datapoint:[s.percent,s.data],dataIndex:0,series:s,seriesIndex:i}}else{var p1X=radius*Math.cos(s.startAngle),p1Y=radius*Math.sin(s.startAngle),p2X=radius*Math.cos(s.startAngle+s.angle/4),p2Y=radius*Math.sin(s.startAngle+s.angle/4),p3X=radius*Math.cos(s.startAngle+s.angle/2),p3Y=radius*Math.sin(s.startAngle+s.angle/2),p4X=radius*Math.cos(s.startAngle+s.angle/1.5),p4Y=radius*Math.sin(s.startAngle+s.angle/1.5),p5X=radius*Math.cos(s.startAngle+s.angle),p5Y=radius*Math.sin(s.startAngle+s.angle),arrPoly=[[0,0],[p1X,p1Y],[p2X,p2Y],[p3X,p3Y],[p4X,p4Y],[p5X,p5Y]],arrPoint=[x,y];if(isPointInPoly(arrPoly,arrPoint))return ctx.restore(),{datapoint:[s.percent,s.data],dataIndex:0,series:s,seriesIndex:i}}ctx.restore()}}return null}function onMouseMove(e){triggerClickHoverEvent("plothover",e)}function onClick(e){triggerClickHoverEvent("plotclick",e)}function triggerClickHoverEvent(eventname,e){var offset=plot.offset(),canvasX=parseInt(e.pageX-offset.left),canvasY=parseInt(e.pageY-offset.top),item=findNearbySlice(canvasX,canvasY);if(options.grid.autoHighlight)for(var i=0;i<highlights.length;++i){var h=highlights[i];h.auto!=eventname||item&&h.series==item.series||unhighlight(h.series)}item&&highlight(item.series,eventname);var pos={pageX:e.pageX,pageY:e.pageY};target.trigger(eventname,[pos,item])}function highlight(s,auto){var i=indexOfHighlight(s);-1==i?(highlights.push({series:s,auto:auto}),plot.triggerRedrawOverlay()):auto||(highlights[i].auto=!1)}function unhighlight(s){null==s&&(highlights=[],plot.triggerRedrawOverlay());var i=indexOfHighlight(s);-1!=i&&(highlights.splice(i,1),plot.triggerRedrawOverlay())}function indexOfHighlight(s){for(var i=0;i<highlights.length;++i){var h=highlights[i];if(h.series==s)return i}return-1}function drawOverlay(plot,octx){function drawHighlight(series){series.angle<=0||isNaN(series.angle)||(octx.fillStyle="rgba(255, 255, 255, "+options.series.pie.highlight.opacity+")",octx.beginPath(),Math.abs(series.angle-2*Math.PI)>1e-9&&octx.moveTo(0,0),octx.arc(0,0,radius,series.startAngle,series.startAngle+series.angle/2,!1),octx.arc(0,0,radius,series.startAngle+series.angle/2,series.startAngle+series.angle,!1),octx.closePath(),octx.fill())}var options=plot.getOptions(),radius=options.series.pie.radius>1?options.series.pie.radius:maxRadius*options.series.pie.radius;octx.save(),octx.translate(centerLeft,centerTop),octx.scale(1,options.series.pie.tilt);for(var i=0;i<highlights.length;++i)drawHighlight(highlights[i].series);drawDonutHole(octx),octx.restore()}var canvas=null,target=null,options=null,maxRadius=null,centerLeft=null,centerTop=null,processed=!1,ctx=null,highlights=[];plot.hooks.processOptions.push(function(plot,options){options.series.pie.show&&(options.grid.show=!1,"auto"==options.series.pie.label.show&&(options.series.pie.label.show=options.legend.show?!1:!0),"auto"==options.series.pie.radius&&(options.series.pie.radius=options.series.pie.label.show?.75:1),options.series.pie.tilt>1?options.series.pie.tilt=1:options.series.pie.tilt<0&&(options.series.pie.tilt=0))}),plot.hooks.bindEvents.push(function(plot,eventHolder){var options=plot.getOptions();options.series.pie.show&&(options.grid.hoverable&&eventHolder.unbind("mousemove").mousemove(onMouseMove),options.grid.clickable&&eventHolder.unbind("click").click(onClick))}),plot.hooks.processDatapoints.push(function(plot,series,data,datapoints){var options=plot.getOptions();options.series.pie.show&&processDatapoints(plot,series,data,datapoints)}),plot.hooks.drawOverlay.push(function(plot,octx){var options=plot.getOptions();options.series.pie.show&&drawOverlay(plot,octx)}),plot.hooks.draw.push(function(plot,newCtx){var options=plot.getOptions();options.series.pie.show&&draw(plot,newCtx)})}var REDRAW_ATTEMPTS=10,REDRAW_SHRINK=.95,options={series:{pie:{show:!1,radius:"auto",innerRadius:0,startAngle:1.5,tilt:1,shadow:{left:5,top:15,alpha:.02},offset:{top:0,left:"auto"},stroke:{color:"#fff",width:1},label:{show:"auto",formatter:function(label,slice){return"<div style='font-size:x-small;text-align:center;padding:2px;color:"+slice.color+";'>"+label+"<br/>"+Math.round(slice.percent)+"%</div>"},radius:1,background:{color:null,opacity:0},threshold:0},combine:{threshold:-1,color:null,label:"Other"},highlight:{opacity:.5}}}};$.plot.plugins.push({init:init,options:options,name:"pie",version:"1.1"})}(jQuery);