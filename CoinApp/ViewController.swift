//
//  ViewController.swift
//  CoinApp
//
//  Created by Zeynep Özcan on 8.05.2024.
//

import UIKit



class ViewController: UIViewController {

    
    @IBOutlet var homeTableView: UITableView!

    let button = UIButton(primaryAction: nil)
    var menuChildren: [UIMenuElement] = []
    
    var viewModel: ViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(cellType: CoinCell.self)
    
        setFilterButton()
        
    }
    
    //Function that performs button setting operations and selection operations.
    func setFilterButton(){
        let actionClosure = { [self] (action: UIAction) in
            print(action.title)
            
            //The function was called to filter the TableView.
            viewModel.filterTable(filterAs: action.title)
            reloadData()
        }
        
        //Adds what should be in the dropdown button for the sort operation.
        for dataToFilter in viewModel.getDataToFilter() {
            menuChildren.append(UIAction(title: dataToFilter, handler: actionClosure))
        }
        
        setButtonLayout(button: button)
    }
    
    // Since it has UI operations, UI op. was done here, calculations carried in viewmodel.
    func setButtonLayout(button: UIButton){
        button.menu = UIMenu(options: .displayInline, children: menuChildren)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        button.frame = viewModel.getButtonLocation()
        button.titleLabel?.font = UIFont.systemFont(ofSize: viewModel.getButtonFont())
        button.layer.cornerRadius = viewModel.getHalf(number: button.frame.height)
        
        // They stayed here because they are UI related.
        button.tintColor = #colorLiteral(red: 0.4176113904, green: 0.3831275702, blue: 0.9505799413, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.9106807113, green: 0.9057188034, blue: 1, alpha: 1)
        self.view.addSubview(button)
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            guard let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
            // argument passing
            detailsVC.selectedCoin =  self.viewModel.getACoin(index: indexPath.row)
            present(detailsVC, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueCell(cellType: CoinCell.self, indexPath: indexPath)
        
        if let coin = viewModel.getACoin(index: indexPath.row) {
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
