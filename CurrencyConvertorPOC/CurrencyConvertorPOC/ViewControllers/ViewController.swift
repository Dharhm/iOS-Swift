//
//  ViewController.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 29/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import UIKit
import FCAlertView

class ViewController: UIViewController {
    
    @IBOutlet weak var balanceSummaryView: BalanceSummaryView!
    
    var pageViewModel = ViewControllerPageViewModel()
    
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var pageTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pageViewModel.setInitialModel()
        pageTableView.separatorColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.parseNotificationObject(notification:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
        
    }
    
    
    func parseNotificationObject (notification: NSNotification) {
        
        if let vm = notification.userInfo?["viewModel"] as? CustomSliderViewModel {
            
            for cell in pageTableView.visibleCells{
                
                if let summaryCell = cell as? BalanceSummaryCell{
                    if vm.currencyType == summaryCell.balanceSummaryView.viewModel.currencyType {
                        summaryCell.balanceSummaryView.viewModel.balanceAmountValue = String(Double(SharedTransactionHistory.sharedInstance.balanceDetails[summaryCell.balanceSummaryView.viewModel.currencyType]!)! - Double(vm.sliderValue)!)
                        summaryCell.balanceSummaryView.refresh()
                        
                    }
                }else{
                    
                    if let sliderCell = cell as? CustomSliderCell{
                        if  sliderCell.customSliderView.viewModel.currencyType != vm.currencyType{
                            sliderCell.customSliderView.viewModel.sliderValue = "0"
                            sliderCell.customSliderView.refresh()
                        }else{
                            
                            SharedTransactionHistory.sharedInstance.selectedTransaction.amount = vm.sliderValue
                            SharedTransactionHistory.sharedInstance.selectedTransaction.fromCurrency = vm.currencyShortForm
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func convertButtonAction(_ sender: Any) {
        
        let fcAlertView = FCAlertView()
        fcAlertView.darkTheme = true
        if SharedTransactionHistory.sharedInstance.selectedTransaction.amount != "0"{
            
        fcAlertView.showAlert(withTitle: "Select the currency you want to convert to", withSubtitle: "By this you are confirming for conversion", withCustomImage: nil, withDoneButtonTitle: CurrencyType.currencyShortForm.last, andButtons:nil)
        
        fcAlertView.addButton(CurrencyType.currencyShortForm[0]) {
            SharedTransactionHistory.sharedInstance.selectedTransaction.toCurrency = CurrencyType.currencyShortForm[0]
            
            self.submitConversion()
        }
        
        fcAlertView.addButton(CurrencyType.currencyShortForm[1]) {
            SharedTransactionHistory.sharedInstance.selectedTransaction.toCurrency = CurrencyType.currencyShortForm[1]
            self.submitConversion ()
        }
        
        fcAlertView.doneActionBlock {
            SharedTransactionHistory.sharedInstance.selectedTransaction.toCurrency = CurrencyType.currencyShortForm[2]
            self.submitConversion()
        }
        
        }else{
            self.infoTextView.text = "Please slide to some values 😊"
        }
        
        
    }
    
    
    func submitConversion() {
        
        if SharedTransactionHistory.sharedInstance.transactionHistory.count >= SharedTransactionHistory.sharedInstance.freeTransactionLimit {
            
            SharedTransactionHistory.sharedInstance.selectedTransaction.comissionCharge = SharedTransactionHistory.sharedInstance.commission
        }
        
        CurrencyTransactionManager.convertCurrenciesWithDetails(selectedTransaction: SharedTransactionHistory.sharedInstance.selectedTransaction) { (error, transactionModel) in
            
            if error == nil {
                
                CurrencyTransactionManager.processConversion(transactionModel:transactionModel)
                
                self.infoTextView.textColor = Styler.successMessageColor
                
                self.infoTextView.text = "You have converted \(String(format: "%.2f",Float(SharedTransactionHistory.sharedInstance.selectedTransaction.amount)!))  \(SharedTransactionHistory.sharedInstance.selectedTransaction.fromCurrency) to \(SharedTransactionHistory.sharedInstance.balanceDetails[CurrencyType.currencyShortFormEquations[(transactionModel?.toCurrency)!]!] ?? "0")  \(SharedTransactionHistory.sharedInstance.selectedTransaction.toCurrency). Commission Fee: \( Double(SharedTransactionHistory.sharedInstance.selectedTransaction.amount)! * (transactionModel?.comissionCharge)!) \(SharedTransactionHistory.sharedInstance.selectedTransaction.fromCurrency)"
                
                self.pageViewModel.setInitialModel()
                SharedTransactionHistory.sharedInstance.resetSelection()
                self.pageTableView.reloadData()
                
            }else{
                
                self.infoTextView.textColor = Styler.failureMessageColor
                self.infoTextView.text = "Something Went Wrong!"
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
            
        case 0:
            return 90
            
        case 1:
            return 80
            
        default:
            return 100
            
        }
    }
}

extension ViewController : UITableViewDataSource
{
    
    /// tableView delegate
    ///
    /// - Parameter tableView: page table view
    /// - Returns: number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    /// tableView delegate
    ///
    /// - Parameters:
    ///   - tableView: page table view
    ///   - section: returns section
    /// - Returns:  number of rows to display
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return CurrencyType.allList.count
        
    }
    
    /// tableView delegate
    ///
    /// - Parameters:
    ///   - tableView: page Table View
    ///   - indexPath: index path
    /// - Returns:  Cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let balancySummaryCell = tableView.dequeueReusableCell(withIdentifier: BalanceSummaryCell.CELL_IDENTIFIER, for: indexPath) as! BalanceSummaryCell
            balancySummaryCell.selectionStyle = .none
            if  pageViewModel.summarySectionViewModels.count > indexPath.row {
                balancySummaryCell.balanceSummaryView.viewModel =  pageViewModel.summarySectionViewModels[indexPath.row]
            }
            balancySummaryCell.refresh()
            balancySummaryCell.selectionStyle = .none
            
            return balancySummaryCell
            
        case 1:
            let customSliderCell = tableView.dequeueReusableCell(withIdentifier: CustomSliderCell.CELL_IDENTIFIER, for: indexPath) as! CustomSliderCell
            customSliderCell.selectionStyle = .none
            if  pageViewModel.summarySectionViewModels.count > indexPath.row {
                customSliderCell.customSliderView.viewModel =  pageViewModel.sliderSectionViewModels[indexPath.row]
            }
            customSliderCell.refresh()
            customSliderCell.selectionStyle = .none
            
            return customSliderCell
            
        default:
            return  UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        
        //declaring the cell variable again
    }
    
}
