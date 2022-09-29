//
//  DetailMedicinalViewController.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 28/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

class DetailMedicinalViewController: UIViewController {
    
    @IBOutlet weak var medicinalPlantImageView: UIImageView!
    @IBOutlet weak var otherNameLabel: UILabel!
    @IBOutlet weak var scienceNameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var partsUsedLabel: UILabel!
    
    @IBOutlet weak var functionLabel: UILabel!
    @IBOutlet weak var dosageAndUsageLabel: UILabel!
    
    @IBOutlet weak var tabooLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var detailMedicinal: MedicinalPlantsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    
    
    func fillData() {
        if let detailMedicinal = detailMedicinal {
            title = detailMedicinal.name
            if let imageName = detailMedicinal.imageName {
                medicinalPlantImageView.image = UIImage(named: imageName)
            }
            
            otherNameLabel.text = detailMedicinal.otherName
            scienceNameLabel.text = detailMedicinal.scienceName
            surnameLabel.text = detailMedicinal.surname
            partsUsedLabel.text = detailMedicinal.partsUsed
            
            functionLabel.text = detailMedicinal.function
            dosageAndUsageLabel.text = detailMedicinal.dosageAndUsage
            if let taboo = detailMedicinal.taboo {
                tabooLabel.text = taboo
            } else {
                tabooLabel.text = "\t"
            }
            if let note = detailMedicinal.note {
                noteLabel.text = note
            } else {
                noteLabel.text = "\t"
            }
        }
    }

}
