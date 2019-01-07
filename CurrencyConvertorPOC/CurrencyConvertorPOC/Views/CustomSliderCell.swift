//
//  CustomSliderCell.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 30/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import UIKit

class CustomSliderCell: UITableViewCell {

    static let CELL_IDENTIFIER = "CustomSliderCell"

    @IBOutlet weak var customSliderView: CustomSliderView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func refresh(){
        
        customSliderView.refresh()  // this is a custom reload data function constructed in the extension class
    }
}
