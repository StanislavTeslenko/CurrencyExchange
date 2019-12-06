//
//  HeaderViewController.swift
//  CurrencyExchange
//
//  Created by Stanislav Teslenko on 01.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import UIKit

class HeaderViewController: UIViewController {

    var currentDate = Date()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = formattedDate(from: currentDate)

    }
    
    
    
    @IBAction func calendarButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        
        guard let source = segue.source as? DatePickerViewController else {return}
        currentDate = source.currentDate
        dateLabel.text = formattedDate(from: source.currentDate)
        
    }
    
    fileprivate func formattedDate(from date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter.string(from: date)
    }

}

extension HeaderViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DatePickerSegue" {
            let destination = segue.destination as? DatePickerViewController
            destination?.currentDate = currentDate
        }
        
    }
    
    
}



