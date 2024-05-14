//
//  DetailViewModel.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 13.05.2024.
//

import Foundation


protocol DetailViewModelProtocol{
    
    func changeDiff() -> Double
}

final class DetailViewModel {
    
    private var selectedCoin: Coins
    
    init(selectedCoin: Coins) {
        self.selectedCoin = selectedCoin
    } 
    func getNameText() -> String {
        return selectedCoin.name ?? ""
    }
    
    func getPriceText() -> String {
        let priceToLoad = String(format: "%.3f", Double(selectedCoin.price!)!)
        return "$\(priceToLoad)"
    }
    
    func getSymbolText() -> String {
        return selectedCoin.symbol ?? ""
    }
    
    func getChangeText() -> String {
        let newChange = changeDiff()
        if selectedCoin.change!.contains("-") {
            let formatStr = String(format: "%.3f", newChange)
            return "\(selectedCoin.change!)% (-$\(formatStr))"
        } else {
            let formatStr = String(format: "%.3f", newChange)
            return "+\(selectedCoin.change!)% (+$\(formatStr))"
        }
    }
    
    func getHighText() -> String {
        let highToLoad = String(format: "%.2f", Double(selectedCoin.sparkline?.max() ?? "") ?? 0)
        return "High: \(highToLoad)"
    }
    
    func getLowText() -> String {
        let lowToLoad = String(format: "%.2f", Double(selectedCoin.sparkline?.min() ?? "") ?? 0)
        return "Low: \(lowToLoad)"
    }
    
    func getImageURL() -> URL {
        let svgUrl = selectedCoin.iconUrl
        let pngUrl: String = svgUrl?.replacingOccurrences(of: ".svg", with: ".png", options: .literal, range: nil) ?? "https://cdn.coinranking.com/H1arXIuOZ/doge.png"
        return URL(string: pngUrl)!
    }
    
}

extension DetailViewModel: DetailViewModelProtocol{
    // Calculates the percent currency change
    func changeDiff() -> Double {
        let currentPriceD: Double? = Double(selectedCoin.price ?? "")
        let changeD: Double? = Double(selectedCoin.change ?? "")
        let newChange = (currentPriceD ?? 0) - ((currentPriceD ?? 0) / (1+(changeD ?? 0)/100))
        
        return newChange
    }
    
}

