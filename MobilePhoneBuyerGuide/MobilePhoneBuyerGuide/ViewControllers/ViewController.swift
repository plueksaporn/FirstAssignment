//
//  ViewController.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var mTable: UITableView!
    @IBOutlet weak var mSortBtn: UIButton!
    
    let api = APIManager()
    var mobiles: [Mobiles] = [] {
        didSet {
            mTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTable.estimatedRowHeight = CGFloat(500)
        mTable.rowHeight = UITableView.automaticDimension
        feedData()
    }
    
    func feedData(){
        api.getMobilesData() { [weak self] result in
            switch result {
            case .success(let data):
                self?.mobiles = data
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self?.present(alert, animated: true)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mobiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTable.dequeueReusableCell(withIdentifier: "cell") as! CustomViewCell
        let mobilesData: Mobiles = mobiles[indexPath.item]
        cell.MappingData(mobiles:mobilesData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.mobiles[indexPath.row]
        self.performSegue(withIdentifier: "showMobileDetail", sender: item)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMobileDetail",
            let viewController = segue.destination as? MobileDetailViewController,
            let selected = sender as? Mobiles {
            viewController.detail = selected
        }
    }
   
    @IBAction func onAllBtnClick(_ sender: UIButton) {
        allBtn.isSelected = true
        favBtn.isSelected = false
        
    }
    
    @IBAction func onFavBtnClick(_ sender: UIButton) {
        allBtn.isSelected = false
        favBtn.isSelected = true
    }
    @IBAction func onSortBtnClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
   
    }
    func Message(){
        
    }
    
  

}

