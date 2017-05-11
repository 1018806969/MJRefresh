# MJRefresh


原理：
1.利用分类给scrollView添加一个MJ_header的属性和一个MJ_footer的属性,然后在vc中对这两个属性赋值。
2.重写系统的- (void)willMoveToSuperview:(UIView *)newSuperview方法
当header和footer被添加到supView上时调用，然后赋值给footer和header的属性，即获得footer和header的父视图。
3.在上述方法中利用kvo添加观察者观察supView的偏移量，根据不同的偏移量对header和footer的不同状态
4.当偏移量达到要求刷新的条件时改变supView的contentInset的值使刷新状态展示，当刷新结束时复原

自定义上拉刷新或者下拉加载更多

根据需要可以继承相对应的类，然后在类中重写父类的方法，注意，重写方法时要先调用父类的即 【super prepare】

根据需要重写相应的父类方法，不必全部重写
重写父类的初始化方法 - （void）prepare

重写父类的布局子视图方法 - (void)placeSubviews

重写父类的state的set方法 - (void)setState:(MJRefreshState)state
要先检查当前状态，即在方法中先MJRefreshCheckState

重写父类的偏移量监听方法 - (void)scrollViewContentOffsetDidChange:(NSDictionary *)chang
可以在方法中获取父视图的偏移量，参数中使用new健拿到的是NSvalue类型的值，需要转化为CGPoint类型，如下
    NSValue *value = [chang objectForKey:@"new"];
    CGPoint point = [value CGPointValue];
    
重写父类contentSize改变的监听方法 - (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

重写父类拖动手势改变的监听方法 - (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;






