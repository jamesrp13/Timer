//
//  AppearanceController.swift
//  Timer
//
//  Created by Daniel Lee on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import UIKit


class AppearanceController{
    
    static func initializeAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.customLightBlue()
        //UIView.appearance().backgroundColor = UIColor.customDarkBlue()
        UIButton.appearance().backgroundColor = UIColor.customDarkGrey()
        UIButton.appearance().setTitleColor(UIColor.customLightBlue(), forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.customLightBlue()], forState: .Selected)
        
    }
    
}

