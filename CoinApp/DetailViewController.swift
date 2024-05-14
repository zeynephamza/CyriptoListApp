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
    
    @IBOutlet var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Passed the selectedcoin to Detail view model.
        if let selectedCoin = selectedCoin {
            detailViewModel = DetailViewModel(selectedCoin: selectedCoin)
            
            //Loads the UI with getting the datas from DetailViewModel.
            loadDetailUI()
            
            
            let cgfloatArray = selectedCoin.sparkline?.compactMap {str -> CGFloat? in
                return CGFloat(Double(str) ?? 0)
            }
            
            // Provide sample data for the line chart
            lineChartView.dataPoints = cgfloatArray ?? [0]
        }
    }
    
    //Update the view by getting data from ViewModel using get methods.
    func loadDetailUI() {
        nameLabel.text   = detailViewModel?.getNameText()
        priceLabel.text  = detailViewModel?.getPriceText()
        symbolLabel.text = detailViewModel?.getSymbolText()
        highLabel.text   = detailViewModel?.getHighText()
        lowLabel.text    = detailViewModel?.getLowText()
        imageLabel.sd_setImage(with: detailViewModel?.getImageURL(), placeholderImage: UIImage(named: "https://cdn.coinranking.com/H1arXIuOZ/doge.png")) // Acts as placeholder
        changeLabel.text = detailViewModel?.getChangeText()
        if (changeLabel.text?.first == "-") {
            (changeLabel.textColor = .systemRed)
        } else {
            (changeLabel.textColor = .systemGreen)
        }
    }
    
}





//////// Graphic Operations ////////////

class LineChartView: UIView {
    
    var dataPoints: [CGFloat] = []

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)

       
        let maxDataPoint = dataPoints.max() ?? 0
        let minDataPoint = dataPoints.min() ?? 0

        let numberOfLabels = 5
        let labelInterval = (maxDataPoint - minDataPoint) / CGFloat(numberOfLabels - 1)

        for i in 0..<numberOfLabels {
            let labelText = String(format: "%.2f", minDataPoint + labelInterval * CGFloat(i))
            let labelY = rect.height - (CGFloat(i) * rect.height / CGFloat(numberOfLabels - 1))
            drawText(labelText, at: CGPoint(x: 40, y: labelY))
        }

        guard !dataPoints.isEmpty else { return }

        let path = UIBezierPath()
        path.lineWidth = 2.0
        UIColor.blue.setStroke()

        let stepX = (rect.width - 50) / CGFloat(dataPoints.count - 1)
        let normalizedDataPoints = dataPoints.normalized(to: rect.height)
        for (index, dataPoint) in normalizedDataPoints.enumerated() {
            let x = stepX * CGFloat(index) + 50
            let y = rect.height - dataPoint
            let point = CGPoint(x: x, y: y)
            if index == 0 {
                path.move(to: point)
            } else {
                if x >= 0 && x <= rect.width && y >= 0 && y <= rect.height {
                    path.addLine(to: point)
                }
            }
        }

        path.stroke()

    }
    
    func drawText(_ text: String, at point: CGPoint) {
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left

        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.paragraphStyle: textStyle
        ]

        text.draw(with: CGRect(x: point.x, y: point.y, width: 50, height: 20), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
    }
}

extension Array where Element == CGFloat {
    func normalized(to height: CGFloat) -> [CGFloat] {
        guard let max = self.max(), max != 0 else { return [] }
        let factor = height / max
        return map { $0 * factor }
    }
}


