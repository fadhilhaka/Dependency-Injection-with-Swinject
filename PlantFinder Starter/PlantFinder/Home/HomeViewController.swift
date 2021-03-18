//
//  HomeViewController.swift
//  PlantFinder
//
//  Created by Fadhil Hanri on 12/03/21.
//

import Foundation
import UIKit
import Swinject

class HomeViewController: UIViewController {
    @IBAction func goToPlantFinder(_ sender: UIButton) {
        let plantVC = PlantFinderViewController()
            plantVC.modalPresentationStyle = .overFullScreen
            plantVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(plantVC, animated: true)
    }
}
