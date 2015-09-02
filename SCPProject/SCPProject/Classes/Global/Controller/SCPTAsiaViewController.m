//
//  SCPTAsiaViewController.m
//  SCPProject
//
//  Created by 韩辉 on 15/8/27.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "SCPTAsiaViewController.h"
#import "SCPAsia.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "SCPShopsTableViewCell.h"
#import <MJRefresh.h>


@interface SCPTAsiaViewController ()

/** manager */
@property(nonatomic, strong)AFHTTPSessionManager *manager;

/** 参数数据 */
@property(nonatomic, strong)NSArray *shops;

@end

static NSString * const SCPID = @"shopscell";

@implementation SCPTAsiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupTableView];
    // 网络请求
    [self setupRefresh];
}

/**
 *  上拉下拉
 */
- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpNetwork)];
    // 自动改变透明度
    // self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

- (void)loadMoreTopics
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"version"] = @"v3.2";
    params[@"op"] = @"app_api";
    params[@"action"] = @"QuanQiu";
    params[@"id"] = @3476;
    
    // 请求
    
    [self.manager GET:@"http://www.shepinxiu.com/api.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        self.shops = [SCPAsia objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSLog(@"%zd",self.shops.count);
        //    [self.shops addObjectsFromArray:[SCPAsia objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
    
    [self.tableView.footer endRefreshing];
    
}


- (void)setUpNetwork
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
   
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"version"] = @"v3.2";
    params[@"op"] = @"app_api";
    params[@"action"] = @"QuanQiu";
    params[@"id"] = @3476;
    
    // 请求
    
    [self.manager GET:@"http://www.shepinxiu.com/api.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        self.shops = [SCPAsia objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSLog(@"%zd",self.shops.count);
//    [self.shops addObjectsFromArray:[SCPAsia objectArrayWithKeyValuesArray:responseObject[@"data"]]];

        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];

    [self.tableView.header endRefreshing];
}


- (void)setupTableView
{
   
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SCPShopsTableViewCell class]) bundle:nil] forCellReuseIdentifier:SCPID];
    self.tableView.rowHeight = [UIScreen mainScreen].bounds.size.width * (300/640.0);
    // 设置TabbleView的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SCPTabbleViewBottomInset, 0);
    // 删除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置背景图片
    self.view.backgroundColor = SCPMainBackground;
}



#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if(_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:_manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];//添加类型
        _manager.responseSerializer.acceptableContentTypes = contentTypes;
    }
    
    return _manager;
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%zd",self.shops.count);
    return self.shops.count;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    SCPShopsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SCPID];
    cell.backgroundColor = SCPMainBackground;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.asia = self.shops[indexPath.row];
//   
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//       
//    }
//   // cell.backgroundColor = [UIColor purpleColor];
//    NSDictionary *shop = self.shops[indexPath.row];
//    cell.textLabel.text = shop[@"name"];
////    [cell.backgroundView sd_setImageWithURL:[NSURL URLWithString:shop[@"thumb"]] placeholderImage:[UIImage imageNamed:@"empty_bg"]];
//
//    
    return cell;
}

@end
