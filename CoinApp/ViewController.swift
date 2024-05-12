//
//  ViewController.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 8.05.2024.
//

import UIKit

extension ViewController {
    
    fileprivate enum Constants {
        static let cellTitleHeight: CGFloat = 50
        static let cellPosterImageRatio: CGFloat = 1/2
        static let cellLeftPadding: CGFloat = 16
        static let cellRightPadding: CGFloat = 16
    }
    
}

class ViewController: UIViewController {
    @IBOutlet var homeTableView: UITableView!
       
    let service: CoinServiceProtocol = CoinService()
    var coins = [Coins]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        service.fetchCoinData { response in
            
            //guard let self else { return }
            switch response {
            case .success(let coins):
                DispatchQueue.main.async {
                    print(coins.first?.name ?? "")
                    self.coins = coins
                    self.homeTableView.reloadData()
                    print(self.coins[1].name)
                }
            case .failure(_):
                print("Error")
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "CoinCell")
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(coins[indexPath.row].name ?? "")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as! CoinCell
        cell.configure(coin: coins[indexPath.row])
        
        
        
        return cell
    }
    
    private func calculateHeight() -> CGFloat {
        let cellWidth = homeTableView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let posterImageHeight = cellWidth * Constants.cellPosterImageRatio
        return Constants.cellTitleHeight + posterImageHeight
    }
    
}

