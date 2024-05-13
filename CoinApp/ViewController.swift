//
//  ViewController.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 8.05.2024.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet var homeTableView: UITableView!
       

    var vievModel: ViewModelProtocol! {
        didSet{
            vievModel.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //fetchCoins()
        vievModel.load()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Ranking List"
        homeTableView.delegate = self
        homeTableView.dataSource = self
        //homeTableView.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "CoinCell")
        
        
        
        homeTableView.register(cellType: CoinCell.self)
        
        
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
            guard let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
                // argument passing
                detailsVC.selectedCoin =  self.vievModel.getACoin(index: indexPath.row)
                //detailsVC.modalPresentationStyle = .fullScreen
                //self.navigationController?.pushViewController(detailsVC, animated: true)
                present(detailsVC, animated: true)

        }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vievModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueCell(cellType: CoinCell.self, indexPath: indexPath)
        
        if let coin = vievModel.getACoin(index: indexPath.row) {
            cell.configure(coin: coin)
        }
        return cell
    }

}

extension ViewController: ViewModelDelegate {
    func reloadData() {
        homeTableView.reloadData()
    }
    
    
}
