//
//  UIImage+UrlToImg.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 21/02/2023.
//

import Foundation
import UIKit

extension UIImageView{
    func setUpImageFromString(stringUrl: String){
        if let imgUrl = URL(string: stringUrl) {
            DispatchQueue.global().async {
                if let imgData = try? Data(contentsOf: imgUrl){
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imgData)

                    }
                }
            }
        }
    }
    
    func makeCircular(){
        self.layer.cornerRadius = self.frame.width/2

    }
}
