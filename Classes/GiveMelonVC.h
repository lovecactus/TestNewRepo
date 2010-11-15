//
//  GiveMelonVC.h
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-7.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GiveMelonVC : UITableViewController 
<UIAlertViewDelegate,
UITextFieldDelegate>{
	UITextField *numberField;
	NSMutableDictionary	*ChildInfo;
}

@end
