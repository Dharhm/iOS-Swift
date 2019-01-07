//
//  BalanceSummaryCell.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 30/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import UIKit

class BalanceSummaryCell: UITableViewCell {
    
    static let CELL_IDENTIFIER = "BalanceSummaryCell"

    @IBOutlet weak var balanceSummaryView: BalanceSummaryView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func refresh(){
        
      balanceSummaryView.refresh()  // this is a custom reload data function constructed in the extension class
        
    }

}
