//
//  PickerViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 12/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

class HardCodedAnswersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    private var hardCodedAnswerViewModel: HardCodedAnswersViewModel!

    func setPickerModel(_ pickerModel: HardCodedAnswersViewModel) {
        self.hardCodedAnswerViewModel = pickerModel
    }

    private let picker = UIPickerView()
    private var defaultAnswers: [PresentableAnswer] = []

    @IBOutlet private weak var textField: UITextField!

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self

        textField.inputView = picker

        defaultAnswers = hardCodedAnswerViewModel.sendMotivationAnswers()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func sendIndex(index: Int) {
        hardCodedAnswerViewModel.sendIndex(index: index)
    }

    // MARK: - PickerView
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaultAnswers.count
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow rowItem: Int,
                    forComponent component: Int) -> String? {
        return defaultAnswers[rowItem].answer
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow rowItem: Int,
                    inComponent component: Int) {
        sendIndex(index: rowItem)
        textField.text = defaultAnswers[rowItem].answer
        self.view.endEditing(false)
    }

}
