//
//  HomeController+Extension.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/23/23.
//

import UIKit

extension HomeController {
    
    func addTargetSegmentControl() {
        customView.segmentControl.addTarget(self, action: #selector(handleSelectSegment), for: .valueChanged)
    }

    @objc func handleSelectSegment(segmentControl: UISegmentedControl) {
        viewModel.inputs.selectedSegmentIndex(index: segmentControl.selectedSegmentIndex)
        customView.segmentControl.selectedSegmentIndex = segmentControl.selectedSegmentIndex
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
