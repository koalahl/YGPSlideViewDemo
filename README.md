
http://code4app.com/ios/567577dd594b90e97f8b47e4 //可看动画演示

YGPSlideViewDemo
在做新闻客户端 UIScrollView 重用展现较多的栏目比较常见
简单的封装了下

Initial Method
```objc
titleArray = @[@"全部",
               @"待付款",
               @"待发货",
               @"待收货",
               @"待评价"
               ];
_slideView = [[YLSlideView alloc]initWithFrame:CGRectMake(0, 0,
                                                          SCREEN_WIDTH_YLSLIDE,
                                                          SCREEN_HEIGHT_YLSLIDE-64)
                                     forTitles:titleArray];
```

delegate Method
实现三个代理方法：
```objc
/**
 *  需要创建的页面数量
 */
- (NSInteger)columnNumber;

/**
 *  创建Cell方法，使用重用机制。目前在此处只针对UITableView，有特殊需求的可自行进行修改
 *
 *  @param slideView
 *  @param index     页面相对应的索引路径
 *
 *  @return Cell
 */
- (YLSlideCell *)slideView:(YLSlideView *)slideView
         cellForRowAtIndex:(NSUInteger)index;

/**
 *  当 cell 初始化完成时调用
 *  可以做预加载显示缓存数据
 *
 *  @param cell
 *  @param index
 */
- (void)slideViewInitiatedComplete:(YLSlideCell*)cell forIndex:(NSUInteger)index;
```

Cell 初始化完成时会进行回调，可以在此处加载缓存数据
``- (void)slideViewInitiatedComplete:(YLSlideCell*)cell forIndex:(NSUInteger)index``

Cell 可见时会回调此代理方法。这时可以加载新的数据
``- (void)slideVisibleView:(YLSlideCell*)cell forIndex:(NSUInteger)index``

数据缓存

如果你的 Cell 是 UITableView 当 UITableView 滚出屏幕不时可见时会保存offset。 当下一次加载Cell时会显示上次滚动的位置
