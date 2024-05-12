//
//  Decoders.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 9.05.2024.
//

import Foundation


public enum Decoders {
    
    static let dateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
