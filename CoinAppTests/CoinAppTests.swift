//
//  CoinAppTests.swift
//  CoinAppTests
//
//  Created by Zeynep Özcan on 8.05.2024.
//

import XCTest
@testable import CoinApp

final class CoinAppTests: XCTestCase {

    var sut: ViewModel!
    var view: MockMainViewModel!
    var mainViewModel: MainViewModelTest!
    var detailViewModel: DetailViewModelTest!
    
    
    override func setUp(){
        view = .init()
        mainViewModel = .init()
        detailViewModel = .init()
    }
    
    override func tearDown() {
        view = nil
        mainViewModel = nil
        detailViewModel = nil
    }
    
    func test_viewWillAppear_InvokesRequiredViewMethods(){
        
        mainViewModel.load()
    }
    func test_fetchCoin(){
        XCTAssert(<#T##expression: Bool##Bool#>)
    }
    
}

/*
extension CoinResult {
    
    static var response: CoinResult{
        let bundle = Bundle(for: CoinAppTests.self)
        let path = bundle.path(forResource: coins, ofType: json)!
        let file = try! String(contentsOf: path)
        let data = file.data(using: .utf8)
        let coinResponse = try! JSONDecoder().decode(CoinResult.self, from: data)
        return coinResponse
    }
    
}*/
