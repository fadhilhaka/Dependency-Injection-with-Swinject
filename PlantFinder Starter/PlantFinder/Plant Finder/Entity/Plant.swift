//
//  Plant.swift
//  PlantFinder
//
//  Created by Fadhil Hanri on 12/03/21.
//

struct Plant {
    struct Request {
        let baseURL = "https://trefle.io/"
        /// Get token from https://trefle.io
        let token = "?token="
        let searchPath = "api/v1/species/search"
        let searchLimit = 3
        var keyword = ""
        
        var query: String {
            get {
                return "&q=\(keyword)&limit=\(searchLimit)?"
            }
        }
        
        var stringURL: String {
            get {
                return baseURL + searchPath + token + query
            }
        }
    }
    
    struct Response: Decodable {
        let data: [Data]
        
        struct Data: Decodable {
            let author: String
            let common_name: String
            let family: String
            let image_url: String
            let scientific_name: String
        }
    }
}
