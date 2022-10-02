//
//  DetailMedicinalViewController.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 28/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit
import Kingfisher
import WebKit

class DetailMedicinalViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
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
        webView.navigationDelegate = self
    }
    
    
    
    func fillData() {
        if let detailMedicinal = detailMedicinal {
            title = detailMedicinal.name
            if let medicinalThumb = detailMedicinal.medicinalThumb {
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
                    let request = URLRequest(url: url)
                    webView.load(request)
                }
            }
            
            otherNameLabel.text = detailMedicinal.otherName ?? "\t"
            scienceNameLabel.text = detailMedicinal.scienceName ?? "\t"
            surnameLabel.text = detailMedicinal.surname ?? "\t"
            partsUsedLabel.text = detailMedicinal.partsUsed ?? "\t"
            
            functionLabel.text = detailMedicinal.function ?? "\t"
            dosageAndUsageLabel.text = detailMedicinal.dosageAndUsage ?? "\t"
            tabooLabel.text = detailMedicinal.taboo ?? "\t"
            noteLabel.text = detailMedicinal.note ?? "\t"
            webView.scrollView.showsVerticalScrollIndicator = false
            webView.scrollView.showsHorizontalScrollIndicator = false
        }
    }

}

extension DetailMedicinalViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
}
