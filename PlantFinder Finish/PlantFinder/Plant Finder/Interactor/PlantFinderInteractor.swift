//
//  PlantFinderInteractor.swift
//  PlantFinder
//
//  Created by bmduser on 18/03/21.
//

import Foundation

protocol PlantFinderInteractorInput {
    var ouput: PlantFinderInteractorOutput! { get set }
    var worker: PlantFinderWorkerDelegate! { get set }
    
    func requestPlantList(with keyword: String)
}

protocol PlantFinderInteractorOutput {
    var output: PlantFinderPresenterOutput! { get set }
    
    func presentError(with error: Error)
    func parsingPlantListData(with data: Data)
}

class PlantFinderInteractor: PlantFinderInteractorInput {
    var ouput: PlantFinderInteractorOutput!
    var worker: PlantFinderWorkerDelegate!
    
    func requestPlantList(with keyword: String) {
        // 1. Make URL request
        let request = Plant.Request(keyword: keyword)
        guard let url = URL(string: request.stringURL) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        
        worker?.getPlantList(request: urlRequest, completion: { (data, error) in
            if let error = error {
                self.ouput?.presentError(with: error)
            }
            
            if let data = data {
                self.ouput?.parsingPlantListData(with: data)
            }
        })
    }
}
