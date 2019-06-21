$('.multi-menu .title').click(function () {
    //只有一级菜单
    $(this).next().toggleClass('hide')
    // 存在二级及以上的菜单
    // $(this).next().removeClass('hide');
    // $(this).parent().siblings().find('.body').addClass('hide')
});
