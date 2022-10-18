//
//  TKCustomDataSource.m
//  TKDragAndDrop
//
//  Created by 임정운 on 2022/10/13.
//

#import "TKCustomTableViewDataSource.h"
#import "TKCustomTableViewCell.h"

@implementation TKCustomTableViewDataSource {
    NSArray<NSDictionary *> const *_accountList;
}

-(void)dealloc {
    self->_accountList = nil;
}

-(id)init {
    self = [super init];
    
    if (self) {
        self->_accountList = @[@{@"title": @"Killer Queen",
                                 @"subTitle": @"Queen",
                                 @"image": [UIImage systemImageNamed:@"folder"]},
                               
                               @{@"title": @"Made In Haven",
                                 @"subTitle": @"Queen",
                                 @"image": [UIImage systemImageNamed:@"folder"]},
                               
                               @{@"title": @"Innuendo",
                                 @"subTitle": @"Queen",
                                 @"image": [UIImage systemImageNamed:@"folder"]}];
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section {
    return self->_accountList.count;
}

-(UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    NSDictionary *cellInfo = self->_accountList[indexPath.row];
    TKCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TKCustomTableViewCell.identifier];
    cell.tag = indexPath.row;
    
    [cell setTitle:cellInfo[@"title"]];
    [cell setSubTitle:cellInfo[@"subTitle"]];
    [cell setTitleImage:cellInfo[@"image"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

@end
