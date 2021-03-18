//
//  PlantFinderPresenter.swift
//  PlantFinder
//
//  Created by bmduser on 18/03/21.
//

import Foundation

protocol PlantFinderPresenterOutput: AnyObject {
    func presentError(with error: String)
    func presentPlantList(with data: [Plant.Response.Data])
}

class PlantFinderPresenter: PlantFinderInteractorOutput {
    var output: PlantFinderPresenterOutput!
    
    func presentError(with error: Error) {
        output?.presentError(with: "Error received requesting plant species: \(error.localizedDescription)")
    }
    
    func parsingPlantListData(with data: Data) {
        // TO DO - Parsing data
        let decoder = JSONDecoder()
        
        if let response = try? decoder.decode(Plant.Response.self, from: data) {
            if !response.data.isEmpty {
                output?.presentPlantList(with: response.data)
            } else {
                output?.presentError(with: "Error: Plant returned empty")
            }
            
        } else {
            output?.presentError(with: "Error: failed parsing data")
        }
    }
}
