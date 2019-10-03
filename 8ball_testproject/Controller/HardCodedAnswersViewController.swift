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

    func setPickerViewModel(_ pickerViewModel: HardCodedAnswersViewModel) {
        self.hardCodedAnswerViewModel = pickerViewModel
    }

    let picker = UIPickerView()
    var defaultAnswer: [String] = [""]

    @IBOutlet private weak var textField: UITextField!

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self

        textField.inputView = picker
        //defaultAnswer = hardCodedAnswerViewModel.getDefaultAnswer()

        textField.text = defaultAnswer[0]
        UserDefaults.standard.set(defaultAnswer[0], forKey: "answer")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func setHardCodedAnswersViewModel(_ viewModel: HardCodedAnswersViewModel) {
        self.hardCodedAnswerViewModel = viewModel
    }

    // MARK: - PickerView
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaultAnswer.count
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow rowItem: Int,
                    forComponent component: Int) -> String? {
        return defaultAnswer[rowItem]
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow rowItem: Int,
                    inComponent component: Int) {
        UserDefaults.standard.set(defaultAnswer[rowItem], forKey: "answer")
        textField.text = defaultAnswer[rowItem]
        self.view.endEditing(false)
    }

}
