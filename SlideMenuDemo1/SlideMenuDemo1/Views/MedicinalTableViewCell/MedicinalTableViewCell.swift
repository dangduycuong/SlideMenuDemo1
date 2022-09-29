//
//  MedicinalTableViewCell.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 28/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

class MedicinalTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var medicinalPlantsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(medicinal: MedicinalPlantsModel) {
        nameLabel.text = medicinal.name
        if let imageName = medicinal.imageName {
            medicinalPlantsImageView.image = UIImage(named: imageName)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        medicinalPlantsImageView.image = nil
    }
    
}
