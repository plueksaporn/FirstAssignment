//
//  API.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIManagerProtocol {
    func getMobilesData(completion: @escaping (Swift.Result<[Mobiles], Error>) -> Void)
    func getImages(artistName: String, completion: @escaping (Swift.Result<[Images], Error>) -> Void)
}

class APIManager:APIManagerProtocol{
    let baseURL:String = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
    static let shared: APIManager = APIManager()
    
    func getMobilesData(completion: @escaping (Swift.Result<[Mobiles], Error>) -> Void) {
        Alamofire.request("\(baseURL)")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let mobiles = try JSONDecoder().decode([Mobiles].self, from: response.data!)
                        completion(.success(mobiles))
                    } catch (let error) {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    func getImages(artistName: String, completion: @escaping (Swift.Result<[Images], Error>) -> Void) {
    
    }
    
    
}
