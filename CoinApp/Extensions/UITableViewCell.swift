//
//  UITableViewCell.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 12.05.2024.
//

import UIKit


extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
}

