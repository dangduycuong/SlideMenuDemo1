//
//  MedicinalTableViewCell.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 28/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit
import Kingfisher

class MedicinalTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var medicinalPlantsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.35
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 3
    }
    
    func fillData(medicinal: MedicinalPlantsModel) {
        nameLabel.text = medicinal.name
        if let medicinalThumb = medicinal.medicinalThumb {
            let array: [String] = medicinalThumb.components(separatedBy: "/")
            var components = URLComponents()
            var path: String = ""
            for i in 0..<array.count {
                switch i {
                case 0:
                    components.scheme = array[i].replacingOccurrences(of: ":", with: "", options: NSString.CompareOptions.literal, range: nil)
                case 2:
                    components.host = array[i]
                default:
                    break
                }
                if i > 2 {
                    path += "/\(array[i])"
                }
            }
            components.path = path
            
            if let url = components.url {
                
                let processor = DownsamplingImageProcessor(size: medicinalPlantsImageView.bounds.size)
                |> RoundCornerImageProcessor(cornerRadius: 8)
                medicinalPlantsImageView.kf.indicatorType = .activity
                medicinalPlantsImageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholderImage"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
                {
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        medicinalPlantsImageView.image = nil
    }
    
}
