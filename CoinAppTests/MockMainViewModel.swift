//
//  MockMainViewModel.swift
//  CoinAppTests
//
//  Created by Zeynep Özcan on 14.05.2024.
//

import Foundation
@testable import CoinApp


final class MockMainViewModel: ViewModelDelegate {
    
    var isInvokedReloadData = false
    
    func reloadData() {
        isInvokedReloadData = true
    }
    
}

