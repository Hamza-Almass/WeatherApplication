//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/23/23.
//

import UIKit

extension UIView {
    
    func animateView(duration: Double) {
        
        let caSpringAnimation = CASpringAnimation(keyPath: "transform.scale")
        caSpringAnimation.fromValue = 0.1
        caSpringAnimation.toValue = 1
        caSpringAnimation.speed = 0.7
        caSpringAnimation.duration = duration
        caSpringAnimation.damping = 4
        caSpringAnimation.mass = 0.5
        layer.add(caSpringAnimation, forKey: nil)
    }
    
}
