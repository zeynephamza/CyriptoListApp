//
//  DetailViewController.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 13.05.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedCoin: Coins?
    var detailViewModel: DetailViewModel?
    
    @IBOutlet var imageLabel: UIImageView!
    @IBOutlet var lowLabel: UILabel!
    @IBOutlet var highLabel: UILabel!
    @IBOutlet var changeLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var symbolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Passed the selectedcoin to Detail view model.
        if let selectedCoin = selectedCoin {
            detailViewModel = DetailViewModel(selectedCoin: selectedCoin)
            
            //Loads the UI with getting the datas from DetailViewModel.
            loadDetailUI()
        }
    }
    
    //Update the view by getting data from ViewModel using get methods.
    func loadDetailUI() {
        nameLabel.text   = detailViewModel?.getNameText()
        priceLabel.text  = detailViewModel?.getPriceText()
        symbolLabel.text = detailViewModel?.getSymbolText()
        highLabel.text   = detailViewModel?.getHighText()
        lowLabel.text    = detailViewModel?.getLowText()
        imageLabel.sd_setImage(with: detailViewModel?.getImageURL(), placeholderImage: UIImage(named: "https://cdn.coinranking.com/H1arXIuOZ/doge.png"))
        changeLabel.text = detailViewModel?.getChangeText()
        if (changeLabel.text?.first == "-") {
            (changeLabel.textColor = .systemRed)
        } else {
            (changeLabel.textColor = .systemGreen)
        }
    }
    
}

