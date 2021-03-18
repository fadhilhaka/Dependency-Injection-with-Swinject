//
//  Configurator.swift
//  PlantFinder
//
//  Created by bmduser on 18/03/21.
//

import Foundation

import Swinject

final class PlantFinderConfigurator: Assembly {
    
    func assemble(container: Container) {
        // TO DO: - Add container registration
        // TO DO: - Register PlantFinderPresenterOutput
        container.register(PlantFinderPresenterOutput.self) { _ in PlantFinderViewController()}
        
        // TO DO: - Register PlantFinderWorkerDelegate
        container.register(PlantFinderWorkerDelegate.self) { _ in PlantFinderWorker() }
        
        // TO DO: - Register PlantFinderInteractorOutput
        container.register(PlantFinderInteractorOutput.self) { (r, output: PlantFinderPresenterOutput) in
            let presenter = PlantFinderPresenter()
            presenter.output = output
            return presenter
        }
        
        // TO DO: - Register PlantFinderInteractorInput
        container.register(PlantFinderInteractorInput.self) { (r, output: PlantFinderPresenterOutput) in
            let interactor = PlantFinderInteractor()
            interactor.ouput = r.resolve(PlantFinderInteractorOutput.self, argument: output)!
            interactor.worker = r.resolve(PlantFinderWorkerDelegate.self)!
            return interactor
        }
        
        // TO DO: - Register PlantFinderRouterDelegate
        container.register(PlantFinderRouterDelegate.self) { (r, vc: PlantFinderViewController) in
            let router = PlantFinderRouter()
            router.parentController = vc
            return router
        }
        
        // TO DO: - Register PlantFinderSwinjectVC
        container.register(PlantFinderViewController.self) { r in
            let vc = PlantFinderViewController()
            vc.interactor = r.resolve(PlantFinderInteractorInput.self, argument: vc as PlantFinderPresenterOutput)!
            vc.router = r.resolve(PlantFinderRouterDelegate.self, argument: vc)!
            return vc
        }
    }
}

