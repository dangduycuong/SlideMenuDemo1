//
//  MedicinalPlantsViewController.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 28/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

enum SortType {
    case name
    case function
    
    var text: String {
        get {
            switch self {
            case .name:
                return "Tìm theo tên"
            case .function:
                return "Tìm theo công năng"
            }
        }
    }
}

protocol MedicinalPlantsViewControllerDelegate: AnyObject {
    func selectSortType(sortType: SortType)
}

class MedicinalPlantsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy private var searchView: UIView = {
        let view: SearchView = SearchView.loadFromNibView()
        return view
    }()
    
    lazy private var searchDocumentView: UIView = {
        let view: SearchDocumentView = SearchDocumentView.loadFromNibView()
        return view
    }()
    
    var listMedicinalPlants = [MedicinalPlantsModel]()
    var filterMedicinalPlants = [MedicinalPlantsModel]()
    var sortType = SortType.name
    
    weak var delegate: MedicinalPlantsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadJson(filename: "Thuoc")
        tableView.registerCell(MedicinalTableViewCell.self)
        addObserver()
    }
    
    private func addObserver() {
        if let searchDocumentView = searchDocumentView as? SearchDocumentView {
            delegate.self = searchDocumentView
            searchDocumentView.showPopup = { [weak self] button in
                self?.flowerButtonlicked(button: button)
            }
            searchDocumentView.textChange = { text in
                if text == "" {
                    self.filterMedicinalPlants = self.listMedicinalPlants
                } else {
                    switch self.sortType {
                    case .name:
                        self.filterMedicinalPlants = self.listMedicinalPlants.filter { (medicinal: MedicinalPlantsModel) in
                            if let name = medicinal.name?.lowercased().unaccent(), let otherName = medicinal.otherName?.lowercased().unaccent() {
                                if name.range(of: text.lowercased().unaccent()) != nil || otherName.range(of: text.lowercased().unaccent()) != nil {
                                    return true
                                }
                            }
                            return false
                        }
                    case .function:
                        self.filterMedicinalPlants = self.listMedicinalPlants.filter { (medicinal: MedicinalPlantsModel) in
                            if let function = medicinal.function?.lowercased().unaccent() {
                                if function.range(of: text.lowercased().unaccent()) != nil {
                                    return true
                                }
                            }
                            return false
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
            
            searchDocumentView.clearAllSearchText = {
                self.filterMedicinalPlants = self.listMedicinalPlants
                self.tableView.reloadData()
            }
        }
    }
    
    func flowerButtonlicked(button: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//        popover.barButtonItem = navigationItem.leftBarButtonItem
        popover.sourceView = searchDocumentView
//        popover.sourceRect = CGRect(origin: self.view.center, size: CGSize.zero)
        popover.delegate = self
        vc.sortByName = {
            self.sortType = .name
            self.delegate?.selectSortType(sortType: .name)
        }
        
        vc.sortByFunction = {
            self.sortType = .function
            self.delegate?.selectSortType(sortType: .function)
        }
        present(vc, animated: true, completion:nil)
    }
    
    func loadJson(filename fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([MedicinalPlantsModel].self, from: data)
                self.listMedicinalPlants = jsonData
                self.filterMedicinalPlants = jsonData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    private func setupUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.titleView = searchDocumentView
//        let rightBarButtonItem = UIBarButtonItem(customView: searchDocumentView)
//        navigationItem.rightBarButtonItem = rightBarButtonItem
        showNavCustom()
    }
}

extension MedicinalPlantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMedicinalPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MedicinalTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(medicinal: filterMedicinalPlants[indexPath.row])
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = selectedView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailMedicinalViewController") as! DetailMedicinalViewController
        vc.detailMedicinal = filterMedicinalPlants[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension MedicinalPlantsViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension FileManager {
    func getListFileNameInBundle(bundlePath: String) -> [String] {

        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent(bundlePath)
        do {
            let contents = try fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
            return contents.map{$0.lastPathComponent}
        }
        catch {
            return []
        }
    }

    func getImageInBundle(bundlePath: String) -> UIImage? {
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent(bundlePath)
        return UIImage.init(contentsOfFile: assetURL.relativePath)
    }
}
extension FileManager {
    //get list file (use in document)
    func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]? {
        let documentsURL = urls(for: directory, in: .userDomainMask)[0]
        let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        return fileURLs
    }
}
