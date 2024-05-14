//
//  MainViewModelTest.swift
//  CoinAppTests
//
//  Created by Zeynep Özcan on 14.05.2024.
//

import Foundation
@testable import CoinApp

final class MainViewModelTest: ViewModelProtocol{
    
 
     var isInvokedFetchCoin = false
     var invokedFetchCoinCount = 0
     let dataToFilter = ["1", "2", "3", "4", "5"]
     private var coins = [Coins]()
     //var service: CoinServiceProtocol
     
     
     var delegate: (any CoinApp.ViewModelDelegate)?
     
     var numberOfItems: Int = 0
     
     func load() {
     
     }
     
     func getACoin(index: Int) -> CoinApp.Coins? {
     coins.first
     }
     
     func filterTable(filterAs: String) {
    
     }
     
     func getDataToFilter() -> [String] {
     [""]
     }
     
     func getButtonLocation() -> CGRect {
     CGRect(x: 0,y: 0,width: 0,height: 0)
     }
     
     func getButtonFont() -> CGFloat {
     CGFloat(0)
     }
     
     func getHalf(number: CGFloat) -> CGFloat {
     CGFloat(0)
     }
        func calculateCellHeight(tableViewWidth: Double) -> Double {
            0
        }
     
}
     
