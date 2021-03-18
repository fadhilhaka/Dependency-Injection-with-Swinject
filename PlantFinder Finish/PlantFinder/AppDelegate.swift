//
//  AppDelegate.swift
//  PlantFinder
//
//  Created by Fadhil Hanri on 12/03/21.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // TO DO: - Add Appinjector assembly
        AppInjector.assemblies = [
            PlantFinderConfigurator()
        ]
        return true
    }
}
