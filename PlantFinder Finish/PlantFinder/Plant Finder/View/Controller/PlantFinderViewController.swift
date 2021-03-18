//
//  PlantFinderViewController.swift
//  PlantFinder
//
//  Created by Fadhil Hanri on 12/03/21.
//

import UIKit

class PlantFinderViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var plantCollectionView: UICollectionView!
    
    var interactor: PlantFinderInteractorInput!
    var router: PlantFinderRouterDelegate!
    var keyword: String = "rose"
    var plantList: [Plant.Response.Data] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Plant Finder"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor.requestPlantList(with: keyword)
//        requestPlantList()
    }
    
    func setupView() {
        searchBar.delegate = self
        plantCollectionView.delegate = self
        plantCollectionView.dataSource = self
        plantCollectionView.register(UINib(nibName: PlantCell.identifier, bundle: nil), forCellWithReuseIdentifier: PlantCell.identifier)
    }
    
    func requestPlantList() {
        let request = Plant.Request(keyword: keyword)
        
        // 1. Make URL request
        guard let url = URL(string: request.stringURL) else { return }
        var urlRequest = URLRequest(url: url)
            urlRequest.cachePolicy = .reloadIgnoringCacheData
        
        // 2. Make networking request
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    // 3. Present errors
                    self?.presentAlert(with: "Error received requesting plant species: \(error.localizedDescription)")
                }
            }
            
            // 4. Parse the returned information
            let decoder = JSONDecoder()
            
            guard let data = data,
                  let response = try? decoder.decode(Plant.Response.self, from: data), !response.data.isEmpty
            else {
                DispatchQueue.main.async { [weak self] in
                    self?.resetList()
                    // 3. Present errors
                    self?.presentAlert(with: "Error: Plant returned empty")
                }
                return
            }
            
            self.plantList = response.data
            
            // 5. Update the UI with plant list
            DispatchQueue.main.async { [weak self] in
                self?.plantCollectionView.reloadData()
            }
        }
        task.resume()
    }
    
    func resetList() {
        self.plantList = []
        self.plantCollectionView.reloadData()
    }
    
    func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension PlantFinderViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        keyword = searchText.lowercased()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetList()
        requestPlantList()
        view.endEditing(true)
    }
}

extension PlantFinderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        plantList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantCell.identifier, for: indexPath) as! PlantCell
            cell.setupCell(with: plantList[indexPath.row])
        return cell
    }
}

extension PlantFinderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        PlantCell.cellSize
    }
}

extension PlantFinderViewController: PlantFinderPresenterOutput {
    func presentError(with error: String) {
        DispatchQueue.main.async {
            self.router.presentAlert(with: error)
        }
    }
    
    func presentPlantList(with data: [Plant.Response.Data]) {
        self.plantList = data

        DispatchQueue.main.async {
            self.plantCollectionView.reloadData()
        }
    }
}
