//
//  ParentController.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

class ParentController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleController()
    }
    
    private func styleController() {
        view.backgroundColor = CoreColor.myPrimaryColor.color
    }
    
}
