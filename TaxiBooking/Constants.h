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

#define MAIN_BUTTONS_BORDERS UIColorFromRGB(0xBE1522)
#define BUTTONS_STATES  UIColorFromRGB(0xD01522)
#define TEXT  UIColorFromRGB(0x000000)
#define TEXT_BACKGROUND_BORDER  UIColorFromRGB(0x888888)
#define LABELS_DARK_BACKGROUND     UIColorFromRGB(0x555555)
#define LIGHT_BACKGROUND_UTEXT_BORDER UIColorFromRGB(0xBBBBBB)
#define NAVIGATION_BACKGROUND UIColorFromRGB(0xF8F8F8)
