//
//  PickerViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 12/08/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import UIKit

class HardCodedAnswersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    private var hardCodedAnswerViewModel: HardCodedAnswersViewModel
    private let picker = UIPickerView()
    private var defaultAnswers: [PresentableAnswer] = []

    private let saveAnswerLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Text.textForSecondController
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textFieldChoice: UITextField = {
        let field = UITextField(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20.0, height: 40))
        field.placeholder = L10n.Text.pressHere
        field.font = UIFont.systemFont(ofSize: 15)
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.autocorrectionType = UITextAutocorrectionType.no
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    init(hardCodedAnswerViewModel: HardCodedAnswersViewModel) {
        self.hardCodedAnswerViewModel = hardCodedAnswerViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(saveAnswerLabel)
        view.addSubview(textFieldChoice)
        setupLayout()

        picker.delegate = self
        picker.dataSource = self
        textFieldChoice.inputView = picker
        defaultAnswers = hardCodedAnswerViewModel.getMotivationAnswers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: - PickerView
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaultAnswers.count
    }

    public func pickerView(_ pickerView: UIPickerView,
                           titleForRow rowItem: Int,
                           forComponent component: Int) -> String? {
        return defaultAnswers[rowItem].answer
    }

    public func pickerView(_ pickerView: UIPickerView,
                           didSelectRow rowItem: Int,
                           inComponent component: Int) {
        saveIndex(index: rowItem)
        textFieldChoice.text = defaultAnswers[rowItem].answer
        self.view.endEditing(false)
    }

    private func saveIndex(index: Int) {
        hardCodedAnswerViewModel.saveIndex(index: index)
    }

    private func setupLayout() {
        saveAnswerLabel.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        saveAnswerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        saveAnswerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        textFieldChoice.topAnchor.constraint(
            equalTo: saveAnswerLabel.bottomAnchor, constant: 10).isActive = true
        textFieldChoice.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        textFieldChoice.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
}
