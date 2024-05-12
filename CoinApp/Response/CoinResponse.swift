//
//  CoinResponse.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 9.05.2024.
//

import Foundation



public struct CoinResponse: Decodable {
    
    public let coinResults: [Coins]?
    
    private enum RootCodingKeys: String, CodingKey{
        case coinResults = "coins"
    }
    
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.coinResults = try container.decodeIfPresent([Coins].self, forKey: .coinResults)
    }
    
}

