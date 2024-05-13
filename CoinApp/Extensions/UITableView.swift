//
//  UITableView.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 12.05.2024.
//

import UIKit


extension UITableView {
    func register(cellType: UITableViewCell.Type) {
        register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("error")
        }
        
        return cell
    }
}
