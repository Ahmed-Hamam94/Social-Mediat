//
//  ShadowV.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 22/02/2023.
//

import UIKit

class ShadowV: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpShadow()
    }
    
    func setUpShadow(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.cornerRadius = 10
    }
}
