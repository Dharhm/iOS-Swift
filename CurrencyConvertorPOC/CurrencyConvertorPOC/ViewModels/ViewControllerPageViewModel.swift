//
//  ViewControllerPageViewModel.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 30/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import Foundation


class  ViewControllerPageViewModel: NSObject {
    
    var summarySectionViewModels:[BalanceSummaryViewModel] = []
    var sliderSectionViewModels:[CustomSliderViewModel] = []

    var error:CustomNSError?
 
    func setInitialModel(){ // I am creating page by page models here with an enumerated list for better app performance and to reduce index path conflicts for the initial load
        summarySectionViewModels.removeAll()
        sliderSectionViewModels.removeAll()

        for i in 0..<CurrencyType.allList.count{
            
            let viewModel = BalanceSummaryViewModel()
            viewModel.currencyType = Array(SharedTransactionHistory.sharedInstance.balanceDetails.keys).sorted{$0.rawValue < $1.rawValue }[i]
            viewModel.balanceAmountValue = SharedTransactionHistory.sharedInstance.balanceDetails[viewModel.currencyType]!
            viewModel.balanceSummaryTitleText = "Available Balance in " + CurrencyType.currencyShortForm[i] //TODO: string should be moved to localiisable strings
            viewModel.currencyShortForm = CurrencyType.currencyShortForm[i]
            viewModel.currencySymbol = CurrencyType.currencySymbols[i]

            summarySectionViewModels.append(viewModel)
            
            let customSliderViewModel = CustomSliderViewModel()
            customSliderViewModel.currencyType =  viewModel.currencyType
            customSliderViewModel.sliderValue = "0"
            customSliderViewModel.sliderMaxValue = Float(SharedTransactionHistory.sharedInstance.balanceDetails[viewModel.currencyType]!)!
            customSliderViewModel.currencySymbol = viewModel.currencySymbol
            customSliderViewModel.currencyShortForm =  viewModel.currencyShortForm

            sliderSectionViewModels.append(customSliderViewModel)
            
        }
        
    }
}
