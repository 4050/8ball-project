//
//  PickerViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 12/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let hardCodeAnswer = HardCodedAnswersModel()
    let picker = UIPickerView()

    @IBOutlet weak var textField: UITextField!

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self

        textField.inputView = picker

        textField.text = hardCodeAnswer.motivationAnswers[0]
        UserDefaults.standard.set(hardCodeAnswer.motivationAnswers[0], forKey: "answer")
    }

    // MARK: - PickerView
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hardCodeAnswer.motivationAnswers.count
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow rowItem: Int,
                    forComponent component: Int) -> String? {
        return hardCodeAnswer.motivationAnswers[rowItem]
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow rowItem: Int,
                    inComponent component: Int) {
        UserDefaults.standard.set(hardCodeAnswer.motivationAnswers[rowItem], forKey: "answer")
        textField.text = hardCodeAnswer.motivationAnswers[rowItem]
        self.view.endEditing(false)
    }

}
