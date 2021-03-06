//
//  ViewController.swift
//  SlideMenuDemo1
//
//  Created by duycuong on 1/23/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leadingRed: NSLayoutConstraint!
    
    
    var isOn: Bool = false {
        didSet {
            UIView.animate(withDuration: 1.0) {
                // self.withRedView.constant = self.isOn ? 0 : 100
//                var tabBarFrame = self.tabBarController?.tabBar.frame.origin.y
//                .
                // self.redViewCentrerX. = self.isOn ? 1/3 : 3
                
//                self.redView.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>, constant: <#T##CGFloat#>)
                self.leadingRed.constant = self.isOn ? -150 : 0
                self.view.layoutIfNeeded()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isOn = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        isOn = true
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func Menu(_ sender: UIBarButtonItem) {
        isOn = !isOn
    }
    
}

