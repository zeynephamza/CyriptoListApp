//
//  DetailViewController.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 13.05.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedCoin: Coins?
    
    @IBOutlet var imageLabel: UIImageView!
    @IBOutlet var lowLabel: UILabel!
    @IBOutlet var highLabel: UILabel!
    @IBOutlet var changeLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var symbolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        if let labelToLoad = selectedCoin?.price{
            priceLabel.text = labelToLoad
        }
        reloadInputViews()
        */
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let priceToLoad = String(format: "%.3f", Double((selectedCoin?.price!)!)!)
        priceLabel.text = "$\(priceToLoad)"
        
        if let nameToLoad = selectedCoin?.name{
            nameLabel.text = nameToLoad
        }
        if let symbolToLoad = selectedCoin?.symbol{
            symbolLabel.text = symbolToLoad
        }
        
        
        let newChange = changeDiff(coin: selectedCoin!)
        if (((selectedCoin?.change!.contains("-"))) != nil) {
            changeLabel.textColor = .systemRed
            let formatStr = String(format: "%.3f", newChange)
            changeLabel.text = "\(String(describing: selectedCoin!.change!))% ($\(formatStr))"
        } else {
            changeLabel.textColor = .systemGreen
            let formatStr = String(format: "%.3f", newChange)
            changeLabel.text = "+\(String(describing: selectedCoin!.change!))% (+$\(formatStr))"
        }
        
        
        
        
        let highToLoad = String(format: "%.2f", Double((selectedCoin?.sparkline?.max())!) ?? "")
        highLabel.text = "High: \(highToLoad)"
        
        let lowToLoad = String(format: "%.2f", Double((selectedCoin?.sparkline?.min())!) ?? "")
        lowLabel.text = "Low: \(highToLoad)"
        
        
        
        
        
        let svgUrl = selectedCoin?.iconUrl
        let pngUrl: String = svgUrl?.replacingOccurrences(of: ".svg", with: ".png", options: .literal, range: nil) ?? "https://cdn.coinranking.com/H1arXIuOZ/doge.svg"
             
        imageLabel.sd_setImage(with: URL(string: pngUrl), placeholderImage: UIImage(named: "https://cdn.coinranking.com/H1arXIuOZ/doge.png"))
        
        
    }
    
    
    func changeDiff(coin: Coins) -> Double {
        let currentPriceD: Double? = Double(coin.price ?? "")
        let changeD: Double? = Double(coin.change ?? "")
        let newChange = (currentPriceD ?? 0) - ((currentPriceD ?? 0) / (1+(changeD ?? 0)/100))
        
        return newChange
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    
}

extension DetailViewController {
    // Calculates the change of the old and new priceces as percentage
    
}
