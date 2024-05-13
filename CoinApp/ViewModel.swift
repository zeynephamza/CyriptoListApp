//
//  ViewModel.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 12.05.2024.
//

import Foundation

extension ViewModel {
    
    fileprivate enum Constants {
        static let cellTitleHeight: Double = 50
        static let cellPosterImageRatio: Double = 1/2
        static let cellLeftPadding: Double = 16
        static let cellRightPadding: Double = 16
    }
}

protocol ViewModelProtocol {
    var delegate: ViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    
    func load()
    func getACoin(index: Int) -> Coins?
    func calculateCellHeight(tableViewWidth: Double) -> Double
    
}

protocol ViewModelDelegate: AnyObject {
    //func showLoading()
    //func hideLoading()
    func reloadData()
}

final class ViewModel {
    
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
                    print(coins.first?.name ?? "")
                    self.coins = coins
                    //self.homeTableView.reloadData()
                    
                    // Tells to vc that data can be reload.
                    self.delegate?.reloadData()
                    print(self.coins[1].name as Any)
                }
            case .failure(_):
                print("Error")
            }
            
        }
    }
    
}


extension ViewModel: ViewModelProtocol {
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
    
}
