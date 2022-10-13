//
//  AppDelegate.h
//  TKDragAndDrop
//
//  Created by 임정운 on 2022/10/13.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

