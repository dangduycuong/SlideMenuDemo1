//
//  MedicinalPlantsViewController.swift
//  SlideMenuDemo1
//
//  Created by cuongdd on 28/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

class MedicinalPlantsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy private var searchView: UIView = {
        let view: SearchView = SearchView.loadFromNibView()
        return view
    }()
    
    var listMedicinalPlants = [MedicinalPlantsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadJson(filename: "Thuoc")
        tableView.registerCell(MedicinalTableViewCell.self)
    }
    
    func loadJson(filename fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([MedicinalPlantsModel].self, from: data)
                self.listMedicinalPlants = jsonData
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
        let rightBarButtonItem = UIBarButtonItem(customView: searchView)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        showNavCustom()
    }
}

extension MedicinalPlantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMedicinalPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MedicinalTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(medicinal: listMedicinalPlants[indexPath.row])
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = selectedView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailMedicinalViewController") as! DetailMedicinalViewController
        vc.detailMedicinal = listMedicinalPlants[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
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
