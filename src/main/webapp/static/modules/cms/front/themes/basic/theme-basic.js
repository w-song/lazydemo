/**
 * <p>Copyright ® 2002 东软  软件开发事业部版权所有。</p>
 */

$(function() {

    // 延迟加载
    $("img.lazy").lazyload({
        threshold : 200,
        effect : "fadeIn"
    });

    // 默认图片
//    $('img').error(function() {
//        $(this).attr("src", ctxStaticTheme + "/img/nopic.jpg");
//    });

    // 默认内容
    $(".panel-body, .category-list-2").each(function() {
        if (!$(this).has('a').length) {
            $(this).html("<p>暂无内容</p>");
        }
    });

});
