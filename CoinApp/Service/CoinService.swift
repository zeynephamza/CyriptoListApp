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
            print(response.request as Any)
            print(response.response as Any)
            print(response.data as Any)
            print(response.result as Any)
            
            // response.result -> success -> .data.coins.name
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let json = try? decoder.decode(RootResponse.self, from: response.data ?? Data()) else { print("Unable to parse JSON"); return }
                
                    print(json)
                    print(json.data.coins.first?.name ?? "")
                    
                    coinElement = json.data.coins
                    coinData = json.data
                
                print(coinElement?.first?.name ?? "")
                print(coinElement?[1].name ?? "")
                    
                
                case .failure(let error):
                    print("*** Please try again later***", error.localizedDescription)
            }
        }
 
        /*
        let urlString = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
        
        AF.request(urlString).responseData { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let data):
                let decoder = Decoders.dateDecoder
                
                do {
                    let response = try decoder.JSONDecoder().decode(DataResponse.self, from: data)
                    completion(.success(response.coinData ?? DataClass(coins: [CoinElement]())))
                } catch {
                    print("JSON Decoder Error!")
                }
            case .failure(let error):
                print("*** Please try again later***", error.localizedDescription)
            }
        }*/
    }
}

