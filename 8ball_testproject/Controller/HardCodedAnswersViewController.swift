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

    //@IBOutlet private weak var textField: UITextField!
    var textField = UITextField()

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let saveAnswerLabel = UILabel()
        saveAnswerLabel.text = "Здесь вы можете выбрать варианты ответа если отключится интернет. Выберите предложенный вариант из списка:"
        saveAnswerLabel.textColor = .black
        saveAnswerLabel.textAlignment = .center
        saveAnswerLabel.font = UIFont.boldSystemFont(ofSize: 14)
        saveAnswerLabel.numberOfLines = 4
        saveAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveAnswerLabel)
        saveAnswerLabel.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        saveAnswerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        saveAnswerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        textField = UITextField(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20.0, height: 40))
        textField.placeholder = "Нажмите сюда:"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)

        textField.topAnchor.constraint(equalTo: saveAnswerLabel.bottomAnchor, constant: 10).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true

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
