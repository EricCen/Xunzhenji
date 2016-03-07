
function initFileUpload(name, id, size){
    var container=$("div#"+name);
    var image = container.parent().find(".uploaded-img img");
    image.each(function(){
        var imageId = $(this).attr('id');
        $(this).parent().addClass('uploaded-img-'+id + '-' + imageId);
        $('<a class="uploaded-close uploaded-close-'+id+'" onclick="removeImage(this);"></a>').insertBefore($(this));
        $('<input type="text" name="'+id+'.id" value="'+imageId+'" hidden="">').insertAfter($(this));
    });


    var block = container.find(".fileupload-block");
    block.addClass("fileupload-block-"+id);
    if($('.uploaded-img img').length <= size){
        block.show();
    }
    var imageSpace = $('<div class="uploaded-img-space-'+id+'"></div>')
    image.parent().wrapAll(imageSpace);
    var fileUpload = $('<input id="fileupload-'+id+'" type="file" name="files[]" class="file-upload file-upload-'+id+'" title="请上传项目图片">');
    container.append('<div class="livepreview-progress-bar"><div class="livepreview-progress" style="width:0%; height: 5px;"></div></div>')
    block.append(fileUpload);
    block.append('<input type="text" name="file-upload-hidden" class="file-upload-hidden-'+id+'" hidden>');
    fileUpload.fileupload({
        url: "/upload/imageUpload",
        dataType: 'json',
        maxNumberOfFiles: 1,
        done: function (e, data) {
            var file = data.result;
            $('.file-upload-hidden-'+id).val('true').focus().blur();
            var uploadImgSpace = $(this).parents(".uploaded-img-space");
            var newImage = '<img src="' + file.thumb + '">',
                imageWithClose = '<div class="uploaded-img"><a class="uploaded-close uploaded-close-'+id+
                    '" onclick="removeImage(this);"></a><img src="' + file.thumbUrl + '" data-url="' + file.deleteUrl + '" /><input type="text" name="' +
                    id + '.id" value=' + file.id + ' hidden></div>';

            setTimeout(function () {
                $('.fileupload-container .livepreview-progress-bar').hide();
                $('.fileupload-container .livepreview-progress-bar .livepreview-progress').css({width: '0%'});
                $('.livepreview-img span').append(newImage);
                if($(".uploaded-img-"+id).length < size){
                    $(imageWithClose).insertBefore($("#" + name));
                    if($('.uploaded-img').length == size) $('.fileupload-block-' + id).hide();
                }
            }, 300);

        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('.fileupload-container .livepreview-progress-bar').show();
            $('.fileupload-container .livepreview-progress-bar .livepreview-progress').css({width: progress + '%'});
        }
    }).on('fileuploadfail', function (e, data) {
        $.each(data.files, function (index, file) {
            alert('上传文件失败。');
        });
    }).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');

}

function removeImage(elem) {
    var uploadedImgBox = $(elem).parent('.uploaded-img');
    var url = uploadedImgBox.find('img').attr("data-url");
    var fileuploadBlock = $(uploadedImgBox).parent().find(".fileupload-block");
    $.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        success: function (data) {
            if (data.result == 0) {
                uploadedImgBox.remove();
                fileuploadBlock.show();
                $('.livepreview-img span img').attr('src', '/images/image-place-holder-basic.png');
                $(fileuploadBlock).find("[name=file-upload-hidden]").val('').focus().blur();
            }
        }
    });
}

function changeMarkerLocation(imageId, location){
    $.ajax({
        url: "/upload/chgMarkerLocation",
        data:{imageId: imageId, location: location},
        method: "POST",
        async: true,
        success: function (data) {
            if(data.errorcode == 0){ // refresh the image
                var img = $(".uploaded-img img[id="+imageId+"]");
                var src= img.attr("src");
                img.attr("src", src);
            }
        }
    });
}
