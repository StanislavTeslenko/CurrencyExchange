//
//  DatePickerViewController.swift
//  CurrencyExchange
//
//  Created by Stanislav Teslenko on 05.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate: class {
    func sendRequest(with date: Date)
}

class DatePickerViewController: UIViewController {
    
    let calendar = Calendar.current
    var currentDate = Date()
    
    weak var delegate: DatePickerViewControllerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        modalPresentationStyle = .popover
        popoverPresentationController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let minimumDate = calendar.date(byAdding: .year, value: -4, to: Date())
        
        datePicker.setDate(currentDate, animated: true)
        datePicker.maximumDate = Date()
        datePicker.minimumDate = minimumDate
        
        self.delegate = UIApplication.shared.windows.first!.rootViewController as! MainViewController
        
    }
    
    
    @IBAction func okButtonPressed(_ sender: UIButton) {
      
        delegate?.sendRequest(with: datePicker.date)
        
        currentDate = datePicker.date
        
    }
  
}

extension DatePickerViewController: UIPopoverPresentationControllerDelegate {
    
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        // Tells iOS that we do NOT want to adapt the presentation style for iPhone
//        return .none
//    }
    
    
    
}


