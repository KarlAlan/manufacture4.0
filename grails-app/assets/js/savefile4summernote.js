function sendFile(file, editor, welEditable){
    alert('正在上传图片');
    var filename = false;
    try{
        filename = file['name'];
    } catch(e){
        filename = false;
    }
    if(!filename){
        $(".note-alarm").remove();
    }

    //文件上传地址
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;
    var url = '/'+basepath+'/file/upload';

    //以上防止在图片在编辑器内拖拽引发第二次上传导致的提示错误
    //var ext = filename.substr(filename.lastIndexOf("."));
    //ext = ext.toUpperCase();

    var $note = $(this);

    data = new FormData();
    data.append("file", files[0]);

    $.ajax({
        data: data,
        type: "POST",
        url: url,
        cache: false,
        contentType: false,
        processData: false,
        success: function(data) {
            //alert("上传成功,请等待加载");
            $.each(data, function (index, img) {
                // use summernote api
                $note.summernote('insertImage', location.protocol+"//"+location.host+img.url);
            });

            setTimeout(function(){
                $(".note-alarm").remove();
            },3000);
        },
        error:function(){
            alert("上传失败");
            setTimeout(function(){
                $(".note-alarm").remove();
            },3000);
        }
    });


}