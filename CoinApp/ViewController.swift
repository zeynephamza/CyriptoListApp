//
//  ViewController.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 8.05.2024.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate {

    
    @IBOutlet var homeTableView: UITableView!
    
    
    
    let service: CoinServiceProtocol = CoinService()
    var coins = [Coins]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homeTableView.delegate = self
        
        service.fetchCoinData { [weak self] response in
            
            guard let self else { return }
            
            switch response {
            case .success(let coins):
                print(coins.first?.name ?? "")
                self.coins = coins
            case .failure(_):
                print("Error")
            }
            
        }
        //service.fetchCoinData()
        /*
        fetchCoins(from: url) { result in
            switch result {
            case .success(let data):
                // Veriyi başarılı bir şekilde aldık, şimdi bu veriyi kullanabiliriz.
                // JSON verisini parse etmek için kullanacağınız işlemleri burada yapabilirsiniz.
                print("JSON verisi başarıyla alındı.")
                
                // Örnek olarak, her coin'in adını yazdıralım
                if let coins = data.data.coins {
                    for coin in coins {
                        if let name = coin.name {
                            print("Coin Name:", name)
                        }
                    }
                } else {
                    print("Coin verisi bulunamadı.")
                }
            case .failure(let error):
                // Bir hata oluştu, bu hatayı ele alabilirsiniz.
                print("Hata oluştu:", error)
            }
        }*/
        
        
    }


}

