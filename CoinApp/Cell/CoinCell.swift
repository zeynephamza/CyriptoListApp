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

        var svgUrl = coin.iconUrl
        let pngUrl: String = svgUrl?.replacingOccurrences(of: ".svg", with: ".png", options: .literal, range: nil) ?? "https://cdn.coinranking.com/H1arXIuOZ/doge.svg"
            
        //var url = svgUrl?.dropLast(3) ?? "https://cdn.coinranking.com/H1arXIuOZ/doge.png"
        //var pngUrl: String = url + "png"
        
        iconImgView.sd_setImage(with: URL(string: pngUrl), placeholderImage: UIImage(named: "https://cdn.coinranking.com/H1arXIuOZ/doge.png"))
        
        nameLabel.text = coin.name
        iconLabel.text = coin.symbol
        
    }
    
}
