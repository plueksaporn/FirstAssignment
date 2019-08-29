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
    let api = APIManager()
    var mobileList: [Mobiles] = []
    var mobiles: [Mobiles] = [] {
        didSet {
            mTable.reloadData()
        }
    }
    var favList : [Mobiles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTable.estimatedRowHeight = CGFloat(500)
        mTable.rowHeight = UITableView.automaticDimension
        feedData()
        let sortBtn = UIBarButtonItem(title: "Sort", style: .plain, target: self, action:#selector(onSortBtnClick(_:)) )
        self.navigationItem.rightBarButtonItem = sortBtn
       
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
        cell.delegate = self
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
        mobiles = self.mobileList
        mTable.reloadData()
    }
    
    @IBAction func onFavBtnClick(_ sender: UIButton) {
        allBtn.isSelected = false
        favBtn.isSelected = true
        let selectedPersons = mobiles.filter {
            $0.favouriteStatus!
        }
       
        favList = selectedPersons
        mobileList = self.mobiles
        mobiles = self.favList
        mTable.reloadData()
    }
    
    @IBAction func onSortBtnClick(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Price high to low", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.sorting(type: "high")}))
        alert.addAction(UIAlertAction(title: "Price low to high", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.sorting(type: "low")}))
        alert.addAction(UIAlertAction(title: "Rating", style: UIAlertAction.Style.default, handler:{ (alert: UIAlertAction!) in self.sorting(type: "rating")}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler:nil))
        self.present(alert, animated: true, completion: nil)
   
    }
    func sorting(type:String){
        mobiles.sort { (lhs: Mobiles, rhs: Mobiles) -> Bool in
            if type == "low" {
                return lhs.price < rhs.price
            }else if type == "high" {
                return lhs.price > rhs.price
            }else{
            return lhs.rating > rhs.rating
            }
        }
        mTable.reloadData()
    }
    
    func btnFavTapped(cell : UITableViewCell){
        let indexPath = mTable.indexPath(for: cell)
        var id = mobiles[indexPath!.row].id
        if mobiles[indexPath!.row].favouriteStatus == true
        {
            mobiles[indexPath!.row].favouriteStatus = false
            
            
        }else{
            mobiles[indexPath!.row].favouriteStatus = true
        }
//        print(mobiles[indexPath!.row].favouriteStatus)
        for mobile in mobiles {
            print("name: \(mobile.name)")
            print("isFav: \(mobile.favouriteStatus)")
        }
    }
    
  

}

