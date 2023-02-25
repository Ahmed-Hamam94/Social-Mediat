//
//  Indicator.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 23/02/2023.
//

import Foundation
import UIKit

class Indicator{
   static let shared = Indicator()
    let indicator = UIActivityIndicatorView(style: .large)

    private init(){
    
    }
    func setUpIndicator(view: UIView){
        indicator.center = view.center
       view.addSubview(indicator)
       indicator.startAnimating()
   }
  
}
