//
//  IconImageView.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

class IconImageView: UIImageView {
    
    private let imageTintColor: UIColor
    init(imageTintColor: UIColor = .black) {
        self.imageTintColor = imageTintColor
        super.init(frame: .zero)
        styleImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleImageView() {
        tintColor = imageTintColor
        image?.withRenderingMode(.alwaysTemplate)
    }
    
}
