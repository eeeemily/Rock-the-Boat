//
//  UIStackViewExtention.swift
//  Rock the Boat
//
//  Created by Zheng, Minghui on 10/4/21.
//

import UIKit

extension UIStackView {
    
    func rotate(by radians: Double, with relativeAnchorPt: CGPoint) {
        
        var transform = CGAffineTransform.identity
        let anchorPt = CGPoint(x: self.bounds.size.width * relativeAnchorPt.x,
                               y: self.bounds.size.height * relativeAnchorPt.y)
        
        transform = transform.translatedBy(x: anchorPt.x, y: anchorPt.y)
        transform = transform.rotated(by: CGFloat(radians))
        transform = transform.translatedBy(x: -anchorPt.x, y: -anchorPt.y)
        self.transform = transform
    }
}
