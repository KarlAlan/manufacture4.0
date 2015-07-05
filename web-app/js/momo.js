/*!
 * momo v0.1.0, http://www.rcstc.com
 * ===================================
 * Powerful jQuery plugin for table customization
 *
 * (c) 2013 Karl, http://www.rcstc.com
 * MIT Licensed
 */

;(function($) {
    jQuery.fn.extend({
        momo: function(options){
            var defaults = {
                source:"cookie"
            }

            var opts = $.extend(defaults,options);

            momodata = new MomoData($(this).attr('id'),opt.source);
            momodata.extraction();
            momodata.restore();

            formatTable(momodata.current);
        },

        momoConfig: function(){
            //extraction data
            var config = extraction();

            // build modal

            // open modal

        },

        momoDeploy: function(){
            // get config data
            var data = null;


            // close modal

            // save in buffer
            if(data){
                $("body").data(name,data);
            }

            // save to cookie or remote
            if (source == "cookie") {
                data = $.cookie(name);
            } else {
                // ajax from remote
            }

            // format Table
            formatTable(data);
        }
    });

    var momodata = null;

    function MomoData(tableName,source) {
        this.tableName = tableName;
        this.source = source;
        this.original = new Array();
        this.current = new Array();

        if (typeof MomoData._initialized == "undefined") {
            MomoData.prototype.extraction = function() {
                $('thead tr th').each(function(index){
                    var th = $(this);
                    cmd = new ColumnMetaData(index,th.text(),'',th.is(":hidden"));

                    this.original.push(cmd);
                })
            };

            MomoData.prototype.restore = function() {
                if (source == "cookie") {
                    this.current = $.cookie(this.tableName);
                } else {
                    // ajax from remote
                }
            };

            MomoData.prototype.save = function() {
                if (source == "cookie") {
                    this.current = $.cookie(this.tableName, this.current);
                } else {
                    // ajax from remote
                }
            };

            Car._initialized = true;
        }
    }

    function ColumnMetaData(index,columnName,columnTag,display){
        this.index = index;
        this.columnName = columnName;
        this.columnTag = columnTag;
        this.display = display;
    }

    // format table by style data
    function formatTable(data) {
        // format table thead
        var $th;
        data.each(function(){
            var md = this;
            var th = $('thead tr th ').eq(md.index).clone(true);
            $(th).text(md.columnName);
            $(th).appendTo('thead tr');
            if(md.display){
                $(th).hide();
            }
        })

        $('thead tr th ').gt(data.size()).remove();

        // format table tbody
    }

})(window.jQuery);

jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') {
        options = options || {};
        if (value === null) {
            value = '';
            options = $.extend({}, options);
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString();
        }
        var path = options.path ? '; path=' + (options.path) : '';
        var domain = options.domain ? '; domain=' + (options.domain) : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else {
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};