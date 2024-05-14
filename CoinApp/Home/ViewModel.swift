//
//  ViewModel.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 12.05.2024.
//

import Foundation

extension ViewModel {
    
    fileprivate enum Constants {
        // For cell
        static let cellTitleHeight: Double = 50
        static let cellPosterImageRatio: Double = 1/2
        static let cellLeftPadding: Double = 16
        static let cellRightPadding: Double = 16
        //For Button
        static let location = CGRect(x: 257, y: 50, width: 125, height: 42)
        static let font = 18
    }
    
}

protocol ViewModelProtocol {
    
    var delegate: ViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    
    func load()
    func getACoin(index: Int) -> Coins?
    func calculateCellHeight(tableViewWidth: Double) -> Double
    func filterTable(filterAs: String)
    func getDataToFilter() -> [String]
    func getButtonLocation() -> CGRect
    func getButtonFont() -> CGFloat
    func getHalf(number: CGFloat) -> CGFloat
}

protocol ViewModelDelegate: AnyObject {
    //func showLoading()
    //func hideLoading()
    func reloadData()
}

final class ViewModel {
    
    //Sort will be done according to these
    let dataToFilter = ["24h Vol", "Price", "Change", "Market Cap", "Listed At"]
    private var coins = [Coins]()
    var service: CoinServiceProtocol
    weak var delegate: ViewModelDelegate?
    
    init(service: CoinServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchCoins() {
        // show loading olabilir burda
        service.fetchCoinData { response in
            
            //guard let self else { return }
            switch response {
            case .success(let coins):
                // hide loading
                DispatchQueue.main.async {
                    
                    // Loaading the model
                    self.coins = coins
            
                    // Tells to vc that data can be reload.
                    self.delegate?.reloadData()
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
}

extension ViewModel: ViewModelProtocol {
    func getHalf(number: CGFloat) -> CGFloat {
        number / 2
    }
    
    func getButtonFont() -> CGFloat {
        CGFloat(Constants.font)
    }
    
    func getButtonLocation() -> CGRect {
        Constants.location
    }
    
    func getDataToFilter() -> [String] {
        dataToFilter
    }
    
    var numberOfItems: Int {
        coins.count
    }
    
    func load() {
        fetchCoins()
    }
    
    func getACoin(index: Int) -> Coins? {
        coins[index]
    }
    
    func calculateCellHeight(tableViewWidth: Double) -> Double {
            let cellWidth = tableViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
            let posterImageHeight = cellWidth * Constants.cellPosterImageRatio
            return Constants.cellTitleHeight + posterImageHeight
    }
    
    func getCoins() -> [Coins] {
        coins
    }
    
    func filterTable(filterAs: String) {
        switch filterAs {
        case "Price":
            coins.sort() { Double($0.price!)! > Double($1.price!)! }
        case "24h Vol":
            coins.sort() { Int($0._24hVolume!)! > Int($1._24hVolume!)! }
        case "Change":
            coins.sort() { Double($0.change!)! > Double($1.change!)! }
        case "Market Cap":
            coins.sort() { Int($0.marketCap!)! > Int($1.marketCap!)! }
        case "Listed At":
            
            // Must do here an epoch time to normal date conversion
            coins.sort() { NSDate(timeIntervalSince1970:TimeInterval($0.listedAt!)) as Date > NSDate(timeIntervalSince1970:TimeInterval($1.listedAt!)) as Date }
        default:
            print("Error") // Shouldn't reach here
        }
    }
}
