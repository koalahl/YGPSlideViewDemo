
#import "ViewController.h"
#import "YLSlideView/YLSlideView.h"
#import "YLSlideConfig.h"
#import "YLSlideView/YLSlideCell.h"
#import "YGPCache.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<YLSlideViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    YLSlideView * _slideView;
    NSArray *colors;
    NSArray *_testArray;
    NSArray * data;
    NSArray * titleArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新闻客户端ScrollView重用";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars =NO;
    self.modalPresentationCapturesStatusBarAppearance =NO;
    self.navigationController.navigationBar.translucent =NO;
    
    colors = @[[UIColor redColor],[UIColor yellowColor],[UIColor blackColor],[UIColor redColor],[UIColor yellowColor],[UIColor blackColor],[UIColor redColor],[UIColor yellowColor],[UIColor blackColor]];
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
    
    _slideView.backgroundColor = [UIColor whiteColor];
    _slideView.delegate        = self;
    [self.view addSubview:_slideView];
    _slideView.initailVisibleYLSCell = 3;
    data = @[@"a",@"1",@"a2",@"a3",@"a5"];
    
    
}

- (NSInteger)columnNumber{
    return titleArray.count;
}

- (YLSlideCell *)slideView:(YLSlideView *)slideView
         cellForRowAtIndex:(NSUInteger)index{
    
    YLSlideCell * cell = [slideView dequeueReusableCell];
    
    if (!cell) {
        cell = [[YLSlideCell alloc]initWithFrame:CGRectMake(0, 0, 320, 500)
                                           style:UITableViewStylePlain];
        cell.delegate   = self;
        cell.dataSource = self;
        
    }
    [cell registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    //    cell.backgroundColor = colors[index];
    
    
    return cell;
}
- (void)slideVisibleView:(YLSlideCell *)cell forIndex:(NSUInteger)index{
    
    NSLog(@"index :%@ ",@(index));
    
    [cell reloadData]; //刷新TableView
    //    NSLog(@"刷新数据");
}

- (void)slideViewInitiatedComplete:(YLSlideCell *)cell forIndex:(NSUInteger)index{
    
    //可以在这里做数据的预加载（缓存数据）
    NSLog(@"缓存数据 %@",@(index));
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell reloadData];
        
    });
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return data.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"cell";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    //    }
    
    cell.textLabel.text = [@(arc4random()%1000) stringValue];
    
    
    return cell;
}

@end
