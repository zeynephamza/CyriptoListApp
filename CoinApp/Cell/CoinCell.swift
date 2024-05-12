//
//  CoinCell.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 11.05.2024.
//

import UIKit
import SDWebImage

class CoinCell: UITableViewCell {

    
    @IBOutlet var iconImgView: UIImageView!
    @IBOutlet var iconLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var changeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(coin: Coins){

        let svgUrl = coin.iconUrl
        let pngUrl: String = svgUrl?.replacingOccurrences(of: ".svg", with: ".png", options: .literal, range: nil) ?? "https://cdn.coinranking.com/H1arXIuOZ/doge.svg"
             
        iconImgView.sd_setImage(with: URL(string: pngUrl), placeholderImage: UIImage(named: "https://cdn.coinranking.com/H1arXIuOZ/doge.png"))
        
        nameLabel.text = coin.name
        iconLabel.text = coin.symbol
        
        
        let newChange = changeDiff(coin: coin)
        if (coin.change!.contains("-")) {
            changeLabel.textColor = .systemRed
            var formatStr = String(format: "%.3f", newChange)
            changeLabel.text = "\(String(describing: coin.change!))% ($\(formatStr))"
        } else {
            changeLabel.textColor = .systemGreen
            var formatStr = String(format: "%.3f", newChange)
            changeLabel.text = "+\(String(describing: coin.change!))% (+$\(formatStr))"
        }
        
        let formatPrice = String(format: "%.3f", Double(coin.price!)!)
        priceLabel.text = "$\(formatPrice)"
    
    }
    
    // Calculates the change of the ol and new priceces as percentage
    func changeDiff(coin: Coins) -> Double {
        
        let currentPriceD: Double? = Double(coin.price ?? "")
        //var oldPriceD: Double? = Double(oldCoin.price ?? "")
        let changeD: Double? = Double(coin.change ?? "")
        
        let newChange = (currentPriceD ?? 0) - ((currentPriceD ?? 0) / (1+(changeD ?? 0)/100))
        
        return newChange
    }
    
}
