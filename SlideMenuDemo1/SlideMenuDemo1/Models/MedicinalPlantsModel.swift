//
//  MedicinalPlantsModel.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 28/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import Foundation

struct MedicinalPlantsModel: Codable {
    var name: String?
    var otherName: String?
    var scienceName: String?
    var surname: String?
    
    var partsUsed: String?
    var function: String?
    var dosageAndUsage: String?
    var note: String?
    
    var imageName: String?
    var taboo: String?
}
