//
//  PlantFinderWorker.swift
//  PlantFinder
//
//  Created by bmduser on 18/03/21.
//

import Foundation

protocol PlantFinderWorkerDelegate {
    func getPlantList(request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}

class PlantFinderWorker: PlantFinderWorkerDelegate {
    var getListTask: URLSessionDataTask?
    
    func getPlantList(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        // 2. Make networking request
        getListTask?.cancel()
        getListTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                print("Error received requesting plant species: \(error.localizedDescription)")
                completion(nil, error)
            }
            
            if let data = data, !data.isEmpty {
                print("Plant returned")
                completion(data, nil)
            }
        }
        getListTask?.resume()
    }
}
