//
//  Extensions.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 10.02.23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        
        views.forEach({
            addSubview($0)
        })
    }
}
 
