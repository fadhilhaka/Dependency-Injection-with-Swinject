//
//  PlantCell.swift
//  PlantFinder
//
//  Created by Fadhil Hanri on 12/03/21.
//

import UIKit

class PlantCell: UICollectionViewCell {
    
    static var cellSize: CGSize {
        let cellWitdth: CGFloat = UIScreen.main.bounds.width
        let cellHeight: CGFloat = 500.0
        return CGSize(width: cellWitdth, height: cellHeight)
    }
    
    static let identifier = "PlantCell"

    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var plantInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        plantImage.image = nil
    }
    
    func setupCell(with data: Plant.Response.Data) {
        plantName.text = data.scientific_name + " " + data.author
        plantInfo.text = "Also called \(data.common_name). Is a species of the \(data.family) family."
        
        guard let imageURL = URL(string: data.image_url),
              plantImage.image == nil
        else { return }
        
        downloadImage(from: imageURL) { (image, error) in
            guard let image = image, error == nil else { return }
            
            DispatchQueue.main.async() { [weak self] in
                self?.plantImage.image = image
            }
        }
    }
    
    func downloadImage(from imageURL: URL, completion: @escaping (UIImage?, Error?) -> ()) {
        getImage(from: imageURL) { (data, _, error) in
            if let error = error {
                print("Error received requesting plant image: \(error.localizedDescription)")
                completion(nil, error)
            }
            
            if let imageData = data {
                print("Image is downloaded")
                completion(UIImage(data: imageData), nil)
            }
        }
        print("Image is downloading")
    }
    
    func getImage(from imageURL: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: imageURL, completionHandler: completion).resume()
    }
}
