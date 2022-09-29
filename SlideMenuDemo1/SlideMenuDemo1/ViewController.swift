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
    
    var sortByName: (() -> Void)?
    var sortByFunction: (() -> Void)?
    
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
        setupUI()
//        isOn = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setupUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    
    @IBAction func sortByNameClicked(_ sender: UIButton) {
        sortByName?()
        dismiss(animated: true)
    }
    
    @IBAction func sortByFunctionClicked(_ sender: UIButton) {
        sortByFunction?()
        dismiss(animated: true)
    }
}

