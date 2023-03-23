//
//  WeatherStackView.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

class WeatherStackView: UIStackView {
    
    init(distribution: UIStackView.Distribution,
         alignment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, spacing: CGFloat = 5) {
        super.init(frame: .zero)
        self.distribution = distribution
        self.alignment = alignment
        self.axis = axis
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
