//
//  MainTabBarController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 26/02/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
 

    override func viewDidLoad() {
        super.viewDidLoad()

        changeRadiusOfTabbar()
    }
    func changeRadiusOfTabbar(){
      
          self.tabBar.layer.masksToBounds = true
          self.tabBar.isTranslucent = true
          self.tabBar.layer.cornerRadius = 30
          self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      
         }


}



