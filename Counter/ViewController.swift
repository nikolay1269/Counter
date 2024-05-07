//
//  ViewController.swift
//  Counter
//
//  Created by Nikolay on 07.05.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var historyTextView: UITextView!
    
    private var counter: UInt = 0
    
    @IBAction func plusButtonDidTap() {
        counter += 1
        counterLabel.text = "Значение счётчика: \(counter)"
        addHistoryRecord(text: "\(currentDateTime()): значение изменено на +1\n")
    }
    
    @IBAction func minusButtonDidTap(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            counterLabel.text = "Значение счётчика: \(counter)"
            addHistoryRecord(text: "\(currentDateTime()): значение изменено на -1\n")
        } else {
            addHistoryRecord(text: "\(currentDateTime()): попытка уменьшить значение счётчика меньше 0\n")
        }
    }
    
    @IBAction func resetButtonDidTap(_ sender: Any) {
        counter = 0
        counterLabel.text = "0"
        addHistoryRecord(text: "\(currentDateTime()): значение сброшено\n")
    }
    
    private func addHistoryRecord(text: String) {
        historyTextView.insertText(text)
    }
    
    private func currentDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
}
