//
//  ParentController+Extension.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

extension ParentController {
    
    func showAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { action in
            completion()
            alertController.dismiss(animated: true)
        }
        alertController.addAction(actionOK)
        present(alertController, animated: true)
    }
    
}
