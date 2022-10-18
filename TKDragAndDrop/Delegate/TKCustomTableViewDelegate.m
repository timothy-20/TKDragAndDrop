//
//  TKCustomTableViewDelegate.m
//  TKDragAndDrop
//
//  Created by 임정운 on 2022/10/13.
//

#import "TKCustomTableViewDelegate.h"

@implementation TKCustomTableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = UIColor.clearColor;
    
    return footerView;
}

@end
