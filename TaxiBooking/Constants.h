//
//  Header.h
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

// COLOR DATA
#define UIColorFromRGB(rgbValue) \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                    green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                     blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                    alpha:1.0]

#define BUITY_RED UIColorFromRGB(0xBE1522)
#define RED  UIColorFromRGB(0xD01522)
#define BLACK  UIColorFromRGB(0x000000)
#define BUITY_GREY  UIColorFromRGB(0x888888)
#define DARK_GREY     UIColorFromRGB(0x555555)
#define GREY UIColorFromRGB(0xBBBBBB)
#define NAVIGATION_BACKGROUND UIColorFromRGB(0xF8F8F8)
