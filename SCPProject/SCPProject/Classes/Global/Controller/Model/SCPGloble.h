//
//  SCPGloble.h
//  SCPProject
//
//  Created by 韩辉 on 15/8/31.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCPGloble : NSObject

/** 图片 */
@property(nonatomic, copy)NSString *thumb;
/** 宽 */
@property (nonatomic, assign) CGFloat width;
/** 高 */
@property (nonatomic, assign) CGFloat height;
/**  linkageid */
@property (nonatomic, copy) NSString *linkageid;


@end

//{
//    "data": [
//             {
//                 "linkageid": "3479",
//                 "name": "中国",
//                 "thumb": "http://www.shepinxiu.com/uploadfile/2015/0417/20150417105312781.jpg",
//                 "width": 640,
//                 "height": 300
//             },
//             {
//                 "linkageid": "3486",
//                 "name": "意大利",
//                 "thumb": "http://www.shepinxiu.com/uploadfile/2015/0417/20150417105449733.jpg",
//                 "width": 640,
//                 "height": 300
//             },
//             {
//                 "linkageid": "3481",
//                 "name": "韩国",
//                 "thumb": "http://www.shepinxiu.com/uploadfile/2015/0417/20150417105326318.jpg",
//                 "width": 640,
//                 "height": 300
//             }
//             ],
//    "error": "200"
//}