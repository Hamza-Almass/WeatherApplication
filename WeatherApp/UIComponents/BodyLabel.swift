//
//  BodyLabel.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

class BodyLabel: UILabel {
    
    let alignment: NSTextAlignment
    
    init(alignment: NSTextAlignment = .natural) {
        self.alignment = alignment
        super.init(frame: .zero)
        setFont()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFont() {
        self.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.textAlignment = alignment
    }
    
}


class NormalLabel: BodyLabel {
    override func setFont() {
        self.font = UIFont(name: "Arial", size: 18)
        self.textAlignment = alignment
    }
}

class LargeLabel: BodyLabel {
    override func setFont() {
        self.font = .systemFont(ofSize: 38, weight: .heavy)
        self.textAlignment = alignment
    }
}

class MediumLabel: BodyLabel {
    override func setFont() {
        self.font = .systemFont(ofSize: 24, weight: .heavy)
        self.textAlignment = alignment
    }
}
