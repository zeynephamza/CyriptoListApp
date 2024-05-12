//
//  Coin.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 8.05.2024.
//

/*
import Foundation


public struct Data: Decodable {
    public let data: DataClass
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
}


public struct DataClass: Decodable {
    public let coins: [CoinElement]?
    
    enum CodingKeys: String, CodingKey {
        case coins
    }
    
}

public struct CoinElement: Decodable {
    public let name: String?
    public let symbol: String?
    public let iconUrl: String?
    public let price: Double?
    public let listedAt: Int?
    public let change: Double?
    public let _24HourVolume: String?
    public let sparkling: [String]?
    
    
    enum CodingKeys: String, CodingKey {
        case name, symbol, price, change, iconUrl, listedAt, sparkling 
        case _24HourVolume = "24hVolume"
    }
    
}
*/

public struct RootResponse: Decodable {
   let data: DataClass?
   let status: String?
}

public struct DataClass: Decodable {
  let coins: [Coins]?
}

public struct Coins: Decodable {

    let name, symbol, price, change, iconUrl: String?
    let sparkline: [String]?
    let listedAt: Int?

}

