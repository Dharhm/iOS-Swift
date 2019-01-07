//
//  CustomSliderView.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 30/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import UIKit

@IBDesignable class CustomSliderView: UIView {

    
    let VIEW_IDENTIFIER = "CustomSliderView"
    
    @IBOutlet var contentView: UIView!
    
//    @IBOutlet weak var balanceAmountLbl: UILabel!
//    
//    @IBOutlet weak var balanceSummaryTitle: UILabel!
//    
    public var viewModel = CustomSliderViewModel()
    
    @IBOutlet weak var sliderControl: UISlider!
    @IBOutlet weak var sliderValueLbl: UILabel!
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
    }
    
    required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    
    loadViewFromNib()
        
        
    
    }
    
    

    
    
    /// Load View from Bundle Nib Name to get instance of the Custom Xib
    func loadViewFromNib(){
    
    Bundle.main.loadNibNamed(VIEW_IDENTIFIER, owner: self, options: nil)
    addSubview(contentView)
    
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        self.viewModel.sliderValue = String(sender.value)
        
        let viewModelDict:[String: CustomSliderViewModel] = ["viewModel": self.viewModel]
        
        // post a notification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: viewModelDict)
        // `default` is now a property, not a method call
        
        
        refresh()
    }
    
}
