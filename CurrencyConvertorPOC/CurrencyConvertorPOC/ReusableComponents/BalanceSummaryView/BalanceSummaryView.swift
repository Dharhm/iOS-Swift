//
//  BalanceSummaryView.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 29/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import UIKit

@IBDesignable class BalanceSummaryView: UIView {
    
    let VIEW_IDENTIFIER = "BalanceSummaryView"
  
    @IBOutlet var contentView: UIView!

    @IBOutlet weak var balanceAmountLbl: UILabel!
    
    @IBOutlet weak var balanceSummaryTitle: UILabel!

    public var viewModel = BalanceSummaryViewModel()
    
    /*
     
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    /// Overide Init
    ///
    /// - Parameter frame: frame of the View Construction
    override init(frame: CGRect) {
        
        super.init(frame: frame)
     
        loadViewFromNib()
        // Register to receive notification in your class
     
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        loadViewFromNib()
  
    }
    
    
    /// Load View from Bundle Nib Name to get instance of the Custom Xib
    func loadViewFromNib(){
        
        Bundle.main.loadNibNamed(VIEW_IDENTIFIER, owner: self, options: nil)
        addSubview(contentView)
        setBorderAround(borderColor: Styler.balanceSummaryViewBorderColor, borderWidth: 0.5, shoudlMaskToBounds: true)
    
    }
 
    
    /// Apply Border for the View
    ///
    ///
    /// - Parameters:
    ///   - borderColor: View Border layer Color
    ///   - borderWidth: View Border layer Width
    ///   - shoudlMaskToBounds: View Border layer Color
    
    func setBorderAround(borderColor:CGColor, borderWidth:CGFloat, shoudlMaskToBounds:Bool){
        
        contentView.layer.borderColor = borderColor
        contentView.layer.borderWidth = borderWidth
        contentView.layer.masksToBounds = shoudlMaskToBounds
    }
    
}
