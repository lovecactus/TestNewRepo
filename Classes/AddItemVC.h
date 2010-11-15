//
//  AddItemVC.h
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-14.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddItemVC : UITableViewController 
<UIAlertViewDelegate,UITextFieldDelegate>{
	UITextField *nameField;
	UITextField *priceField;
}

@end
