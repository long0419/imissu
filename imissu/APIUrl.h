//
//  APIUrl.h
//  CarManager
//
//  Created by JinXin on 15/12/9.
//  Copyright © 2015年 droidgle. All rights reserved.
//

#ifndef APIUrl_h
#define APIUrl_h

#define API @"http://www.51kcgj.com"

#define API_IMAGE [NSString stringWithFormat:@"%@/%@",API,@"static"];

#define adUrl [NSString stringWithFormat:@"%@/%@",API,@"backend/floor/phone-ad.action?returnType=json"]

#define categoryUrl [NSString stringWithFormat:@"%@/%@",API,@"backend/floor/phone-category.action?returnType=json"]

#define categorySecondUrl [NSString stringWithFormat:@"%@/%@",API,@"product/product-category!mSecondCategorySearch.action?parentId="]

#define floorGoods [NSString stringWithFormat:@"%@/%@",API,@"backend/floor/phone-floor.action?returnType=json"]

#define searchProduct [NSString stringWithFormat:@"%@/%@",API,@"front/product!searchProduct.action?returnType=json&productName="]

#define loginUrl [NSString stringWithFormat:@"%@/%@",API,@"front/member-login!mValidateLogin.action?entity.username="]

#define registerUrl [NSString stringWithFormat:@"%@/%@",API,@"front/member-register!mStepUserAndPass.action?entity.username="]

#define deleteAddress [NSString stringWithFormat:@"%@/%@",API,@"front/recipient-msg!delete.action?returnType=json&ids="]

#define addAddress [NSString stringWithFormat:@"%@/%@",API,@"front/recipient-msg!save.action?returnType=json&username="]

#define modifyPsw [NSString stringWithFormat:@"%@/%@",API,@"front/member-login!save.action?entity.id="]

#define feedback [NSString stringWithFormat:@"%@/%@",API,@"front/common!saveBackMsg.action?returnType=json&userBackMsg="]


#endif /* APIUrl_h */
