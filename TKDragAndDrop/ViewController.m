//
//  ViewController.m
//  TKDragAndDrop
//
//  Created by 임정운 on 2022/10/13.
//

#import "ViewController.h"
#import "Delegate/TKCustomTableViewDataSource.h"
#import "Delegate/TKCustomTableViewDelegate.h"
#import "Delegate/TKCustomTableViewDragAndDrop.h"
#import "Cell/TKCustomTableViewCell.h"

@interface ViewController () {
    TKCustomTableViewDelegate *_tableViewDelegate;
    TKCustomTableViewDataSource *_tableViewDataSource;
    TKCustomTableViewDragAndDrop *_tableViewDragAndDrop;
    UITableView *_tableView;
}

@end

@implementation ViewController
-(void)dealloc {
    self->_tableViewDelegate = nil;
    self->_tableViewDataSource = nil;
    self->_tableViewDragAndDrop = nil;
    self->_tableView = nil;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self->_tableViewDelegate = [[TKCustomTableViewDelegate alloc] init];
    self->_tableViewDataSource = [[TKCustomTableViewDataSource alloc] init];
    self->_tableViewDragAndDrop = [[TKCustomTableViewDragAndDrop alloc] init];
    self->_tableView = [[UITableView alloc] initWithFrame:[self getSafeAreaFrame]];
    self->_tableView.backgroundColor = UIColor.clearColor;
    self->_tableView.allowsSelection = NO;
    self->_tableView.scrollEnabled = YES;
    self->_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self->_tableView.delegate = self->_tableViewDelegate;
    self->_tableView.dataSource = self->_tableViewDataSource;
    self->_tableView.dragInteractionEnabled = YES;
    self->_tableView.dragDelegate = self->_tableViewDragAndDrop;
    self->_tableView.dropDelegate = self->_tableViewDragAndDrop;
    self->_tableView.refreshControl = [[UIRefreshControl alloc] init];
    
    [self->_tableView registerClass:[TKCustomTableViewCell class] forCellReuseIdentifier:TKCustomTableViewCell.identifier];
    [self->_tableView.refreshControl addTarget:self action:@selector(actionRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self->_tableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - Utils
-(CGRect)getSafeAreaFrame {
    NSSet<UIScene *> *filteredScenes = [UIApplication.sharedApplication.connectedScenes objectsPassingTest:^BOOL(UIScene *scene, BOOL * _Nonnull stop) {
        if ([scene isKindOfClass:[UIWindowScene class]]) {
            return YES;
        }
        
        return NO;
    }];
    
    UIWindowScene *windowScene = (UIWindowScene *)filteredScenes.allObjects.firstObject;
    UIWindow *window = windowScene.windows.firstObject;
    CGRect safeAreaFrame = UIEdgeInsetsInsetRect(self.view.frame, window.safeAreaInsets);
    
    return safeAreaFrame;
}

#pragma mark - Actions
-(void)actionRefresh:(UIRefreshControl *)sender {
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [sender endRefreshing];
        [self->_tableView reloadData];
    });
}

@end
