//
//  ViewController.swift
//  Counter
//
//  Created by Nikolay on 07.05.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var historyTextView: UITextView!
    
    private var counter: UInt = 0
    
    override func viewDidLoad() {
        
        initCounter()
        initHistory()
    }
    
    private func initCounter() {
        counter = UInt(UserDefaults.standard.integer(forKey: "counter"))
        if counter > 0 {
            counterLabel.text = "Значение счётчика: \(counter)"
        }
    }
    
    private func initHistory() {
        let history = UserDefaults.standard.string(forKey: "history")
        if let history = history {
            if history.count > 0 {
                historyTextView.text = history
            }
        }
    }
    
    @IBAction private func plusButtonDidTap() {
        counter += 1
        counterLabel.text = "Значение счётчика: \(counter)"
        addHistoryRecord(text: "\(currentDateTime()): значение изменено на +1\n")
        saveParameters()
    }
    
    @IBAction private func minusButtonDidTap(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            counterLabel.text = "Значение счётчика: \(counter)"
            addHistoryRecord(text: "\(currentDateTime()): значение изменено на -1\n")
            saveParameters()
        } else {
            addHistoryRecord(text: "\(currentDateTime()): попытка уменьшить значение счётчика меньше 0\n")
            saveHistory()
        }
    }
    
    @IBAction private func resetButtonDidTap(_ sender: Any) {
        counter = 0
        counterLabel.text = "0"
        addHistoryRecord(text: "\(currentDateTime()): значение сброшено\n")
        saveParameters()
    }
    
    private func saveParameters() {
        saveCounter()
        saveHistory()
        UserDefaults.standard.synchronize()
    }
    
    private func saveCounter() {
        UserDefaults.standard.setValue(counter, forKey: "counter")
        UserDefaults.standard.synchronize()
    }
    
    private func saveHistory() {
        UserDefaults.standard.setValue(historyTextView.text, forKey: "history")
        UserDefaults.standard.synchronize()
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
