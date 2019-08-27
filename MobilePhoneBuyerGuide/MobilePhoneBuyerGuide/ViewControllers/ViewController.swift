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


}

