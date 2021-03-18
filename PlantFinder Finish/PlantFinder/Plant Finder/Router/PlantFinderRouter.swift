//
//  PlantFinderRouter.swift
//  PlantFinder
//
//  Created by bmduser on 18/03/21.
//

import Foundation
import UIKit

protocol PlantFinderRouterDelegate {
    func presentAlert(with message: String)
}

class PlantFinderRouter: PlantFinderRouterDelegate {
    weak var parentController: PlantFinderViewController!
    
    func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        parentController?.present(alert, animated: true, completion: nil)
    }
}
