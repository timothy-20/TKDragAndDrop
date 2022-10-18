//
//  TKCustomTableViewDragAndDrop.m
//  TKDragAndDrop
//
//  Created by 임정운 on 2022/10/14.
//

#import "TKCustomTableViewDragAndDrop.h"
#import "TKCustomTableViewCell.h"
#import "TKCustomItemProviderAdapter.h"

@import MobileCoreServices;
@import UniformTypeIdentifiers;

@implementation TKCustomTableViewDragAndDrop
#pragma mark - UITableViewDragDelegate
-(NSArray<UIDragItem *> * _Nonnull)tableView:(UITableView * _Nonnull)tableView itemsForBeginningDragSession:(id<UIDragSession> _Nonnull)session atIndexPath:(NSIndexPath * _Nonnull)indexPath {
    TKCustomTableViewCell *cell = (TKCustomTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    TKCustomItemProviderAdapter *adapter = [[TKCustomItemProviderAdapter alloc] initWithUserInfo:cell.userInfo];
//    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:adapter];
    
    NSItemProvider *itemProvider = [[NSItemProvider alloc] init];
    
    [itemProvider registerDataRepresentationForContentType:UTTypeData visibility:NSItemProviderRepresentationVisibilityAll loadHandler:^NSProgress * _Nullable(void (^ _Nonnull completionHandler)(NSData * _Nullable, NSError * _Nullable)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSProgress *progress = [NSProgress progressWithTotalUnitCount:100.0];
            NSError *error = nil;
            NSData *userInfoData = [NSJSONSerialization dataWithJSONObject:cell.userInfo options:NSJSONWritingPrettyPrinted error:&error];
            
            [progress setCompletedUnitCount:100.0];
            completionHandler(userInfoData, error);
        });
        
        return nil;
    }];
    
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    
    [dragItem setPreviewProvider:^UIDragPreview * _Nullable{
        return [[UIDragPreview alloc] initWithView:[self createPreviewView:cell]];
    }];

    return @[dragItem];
}

-(UIView *)createPreviewView:(TKCustomTableViewCell * _Nonnull)cell {
    CGRect previewViewFrame = CGRectMake(0.0f, 0.0f, cell.frame.size.height, cell.frame.size.height);
    UIView *previewView = [[UIView alloc] initWithFrame:previewViewFrame];
    previewView.backgroundColor = UIColor.blackColor;
    previewView.layer.cornerRadius = 5.0f;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"folder"]];
    imageView.frame = previewView.frame;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = UIColor.clearColor;
    imageView.tintColor = UIColor.whiteColor;
    
    [previewView addSubview:imageView];
    return previewView;
}

-(UIDragPreviewParameters *)tableView:(UITableView *)tableView dragPreviewParametersForRowAtIndexPath:(NSIndexPath *)indexPath {
    TKCustomTableViewCell *cell = (TKCustomTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:cell.contentView.frame cornerRadius:5.0];
    UIDragPreviewParameters *parameter = [[UIDragPreviewParameters alloc] init];
    parameter.visiblePath = bezierPath;
    parameter.backgroundColor = UIColor.clearColor;
    
    return parameter;
}

#pragma mark - UITableViewDropDelegate
-(BOOL)tableView:(UITableView *)tableView canHandleDropSession:(id<UIDropSession>)session {
//    [session canLoadObjectsOfClass:[TKCustomItemProviderAdapter class]];
    return YES;
}

-(UITableViewDropProposal *)tableView:(UITableView *)tableView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath {
    if (session.localDragSession == nil) {
        return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationCancel intent:UITableViewDropIntentUnspecified];
    }
    
    return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationMove intent:UITableViewDropIntentInsertAtDestinationIndexPath];
}

- (void)tableView:(UITableView * _Nonnull)tableView performDropWithCoordinator:(id<UITableViewDropCoordinator> _Nonnull)coordinator {
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
 
    if (destinationIndexPath == nil) {
        NSLog(@"%@ Unable to get destination index path.", self.description);
        
        NSUInteger section = tableView.numberOfSections - 1;
        NSUInteger row = [tableView numberOfRowsInSection:section];
        destinationIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    }
    
    [coordinator.session.items enumerateObjectsUsingBlock:^(UIDragItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.itemProvider loadDataRepresentationForContentType:UTTypeData completionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error != nil) {
                    NSLog(@"%@ Fail to get drag item. Error reason: %@", self.description, error.debugDescription);
                    return;
                }
                
                NSError *serializeError = nil;
                NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializeError];
                
                if (serializeError != nil) {
                    NSLog(@"%@ Fail to decode serialzed data.", self.description);
                    return;
                }
                
                NSLog(@"%@ Get user info: %@", self.description, userInfo);
            });
        }];
    }];

//    [coordinator.session loadObjectsOfClass:[TKCustomItemProviderAdapter class] completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
//        [objects enumerateObjectsUsingBlock:^(__kindof id<NSItemProviderReading>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj isKindOfClass:[TKCustomItemProviderAdapter class]]) {
//                TKCustomItemProviderAdapter *adapter = (TKCustomItemProviderAdapter *)obj;
//            }
//        }];
//    }];
}

@end
