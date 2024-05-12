//
//  CoinService.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 9.05.2024.
//

import Foundation
import Alamofire


public protocol CoinServiceProtocol {
    
    func fetchCoinData(completion: @escaping (Result<[Coins], Error>) -> Void)
}

public class CoinService: CoinServiceProtocol {
    
    public init(){}
    public func fetchCoinData(completion: @escaping (Result<[Coins], any Error>) -> Void) {
        
        let url = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
      
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        AF.request(encodedUrl!).responseJSON { response in
            //print(response.request as Any)
            //print(response.response as Any)
            //print(response.data as Any)
            //print(response.result as Any)
            
            // response.result -> success -> .data.coins.name
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            //successStatus=response.result
            switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let json = try? decoder.decode(RootResponse.self, from: response.data ?? Data()) else { print("Unable to parse JSON"); return }
                    
                completion(.success((json.data?.coins)!))
                    //print(json)
                    //print(json.data.coins.first?.name ?? "")
                         
                
                case .failure(let error):
                    print("*** Please try again later***", error.localizedDescription)
            }
        }
 
    }
}

