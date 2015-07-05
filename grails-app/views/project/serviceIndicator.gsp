<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.Task; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'task')}" />
    <title>服务指标</title>
    <asset:javascript src="flot/jquery.flot.js"/>
    <asset:javascript src="flot/jquery.flot.pie.js"/>
    <asset:javascript src="flot/jquery.flot.resize.js"/>
    <style  type="text/css">

    </style>
</head>
<body>


<!--<h1><g:message code="default.list.label" args="[entityName]" /></h1> -->
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div title="查询条件" style="margin: 10px">
    <div title="查询条件" style="margin: 10px">
        <g:form action="serviceIndicator" method="post" class="form-inline" role="form">
            <div class="form-group">
                <label for="pid">项目名称：</label>
                <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" noSelection="['-1':'-空选择-']" class="form-control"/>
            </div>
            <div class="form-group">
                <label for="year">年份：</label>
                <g:select name="year" from="${2014..<2021}"  value="${params.year}"  class="form-control"/>
            </div>
            <div class="form-group">
                <label>月份：</label>
                <g:select name="month" from="${1..<13}"  value="${params.month}"  class="form-control"/>
            </div>
            <button type="submit" class="btn btn-info btn-sm pull-right">查询</button>
        </g:form>
    </div>
</div>

<div class="row">
    <div id="show-contract" class="col-xs-12" role="main">
        <div class="col-md-9">
            <div class="widget-box">
                <div class="widget-header widget-header-flat widget-header-small">
                    <h5 class="widget-title">
                        <i class="ace-icon fa fa-signal"></i>
                        效率指标
                    </h5>


                </div>

                <div class="widget-body">
                    <div class="widget-main">
                        <!-- #section:plugins/charts.flotchart -->
                        <div id="piechart-placeholder"></div>

                        <!-- /section:plugins/charts.flotchart -->
                        <div class="hr hr8 hr-double"></div>

                        <div class="clearfix">
                            <!-- #section:custom/extra.grid -->
                            <div class="grid3">
                                <span class="grey">
                                    <i class="ace-icon fa fa-facebook-square fa-2x blue"></i>
                                    &nbsp; 有效服务时间
                                </span>
                                <h4 class="bigger pull-right">${total}小时</h4>
                            </div>

                            <div class="grid3">
                                <span class="grey">
                                    <i class="ace-icon fa fa-twitter-square fa-2x purple"></i>
                                    &nbsp; 分析设计占用
                                </span>
                                <h4 class="bigger pull-right">${des}小时</h4>
                            </div>

                            <div class="grid3">
                                <span class="grey">
                                    <i class="ace-icon fa fa-pinterest-square fa-2x red"></i>
                                    &nbsp; 开发测试占用
                                </span>
                                <h4 class="bigger pull-right">${dev}小时</h4>
                            </div>

                            <!-- /section:custom/extra.grid -->
                        </div>
                        <div class="hr hr8 hr-double"></div>
                        <div class="infobox-container">


                            <div class="infobox infobox-green infobox-small infobox-dark">
                                <div class="infobox-icon">
                                    <i class="ace-icon fa fa-comments"></i>
                                </div>

                                <div class="infobox-data">
                                    <div class="infobox-content">需求总数</div>
                                    <div class="infobox-content">${amount[0]}个</div>
                                </div>
                            </div>
                            <div class="infobox infobox-orange infobox-small infobox-dark">
                                <div class="infobox-icon">
                                    <i class="ace-icon fa fa-flask"></i>
                                </div>

                                <div class="infobox-data">
                                    <div class="infobox-content">超时数量</div>
                                    <div class="infobox-content">${amount[1]}个</div>
                                </div>
                            </div>
                            <div class="infobox infobox-blue infobox-small infobox-dark">
                                <div class="infobox-progress">
                                    <!-- #section:pages/dashboard.infobox.easypiechart -->
                                    <div class="easy-pie-chart percentage" data-percent="${amount[0]!=0&&amount[1]?((amount[0]-amount[1])/amount[0]*100).intValue():'0'}" data-size="39">
                                        <span class="percent">${amount[0]!=0&&amount[1]?((amount[0]-amount[1])/amount[0]*100).intValue():'0'}</span>%
                                    </div>

                                    <!-- /section:pages/dashboard.infobox.easypiechart -->
                                </div>

                                <div class="infobox-data">
                                    <div class="infobox-content">开发及时率</div>

                                </div>
                            </div>

                            <!-- /section:custom/extra.grid -->
                        </div>
                    </div><!-- /.widget-main -->
                </div><!-- /.widget-body -->
            </div>
        </div><!-- /.widget-main -->

    </div>
</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(function(){
        //flot chart resize plugin, somehow manipulates default browser resize event to optimize it!
        //but sometimes it brings up errors with normal resize event handlers
        $.resize.throttleWindow = false;

        var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'200px'});
        var data = [
        <%
             for(int i=0 ;i<hours.size();i++){
        %>
            { label: "${hours[i][0].name}",  data: "${hours[i][1]}"}${i==hours.size()?'':','}
        <%
             }
        %>
        ]
        function drawPieChart(placeholder, data, position) {
            $.plot(placeholder, data, {
                series: {
                    pie: {
                        show: true,
                        tilt:0.8,
                        highlight: {
                            opacity: 0.25
                        },
                        stroke: {
                            color: '#fff',
                            width: 2
                        },
                        startAngle: 2
                    }
                },
                legend: {
                    show: true,
                    position: position || "ne",
                    labelBoxBorderColor: null,
                    margin:[-30,15]
                }
                ,
                grid: {
                    hoverable: true,
                    clickable: true
                }
            })
        }
        drawPieChart(placeholder, data);

        /**
         we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
         so that's not needed actually.
         */
        placeholder.data('chart', data);
        placeholder.data('draw', drawPieChart);


        //pie chart tooltip example
        var $tooltip = $("<div class='tooltip top in'><div class='tooltip-inner'></div></div>").hide().appendTo('body');
        var previousPoint = null;

        placeholder.on('plothover', function (event, pos, item) {
            if(item) {
                if (previousPoint != item.seriesIndex) {
                    previousPoint = item.seriesIndex;
                    var tip = item.series['label'] + " : " + item.series['percent']+'%';
                    $tooltip.show().children(0).text(tip);
                }
                $tooltip.css({top:pos.pageY + 10, left:pos.pageX + 10});
            } else {
                $tooltip.hide();
                previousPoint = null;
            }

        });

        $('.easy-pie-chart.percentage').each(function(){
            var $box = $(this).closest('.infobox');
            var barColor = $(this).data('color') || (!$box.hasClass('infobox-dark') ? $box.css('color') : 'rgba(255,255,255,0.95)');
            var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#E2E2E2';
            var size = parseInt($(this).data('size')) || 50;
            $(this).easyPieChart({
                barColor: barColor,
                trackColor: trackColor,
                scaleColor: false,
                lineCap: 'butt',
                lineWidth: parseInt(size/10),
                animate: /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) ? false : 1000,
                size: size
            });
        })

    })
</script>
</body>
</html>
