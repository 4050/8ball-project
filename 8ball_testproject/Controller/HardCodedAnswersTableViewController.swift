//
//  HardCodedAnswersTableViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 12/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import UIKit

class HardCodedAnswersTableViewController: UIViewController, UITabBarDelegate {
    
    private let tableView = UITableView()
    private var safeArea: UILayoutGuide!
    private var alertTextFiled = UITextField()
    private var defaultAnswers: [PresentableAnswer] = []
    private var hardCodedAnswerViewModel: HardCodedAnswersViewModel
    
    init(hardCodedAnswerViewModel: HardCodedAnswersViewModel) {
        self.hardCodedAnswerViewModel = hardCodedAnswerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveButton))
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        defaultAnswers = hardCodedAnswerViewModel.getMotivationAnswers()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
    @objc
    func saveButton() {
        let alert = UIAlertController(title: L10n.Title.addCustomAnswer, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.Title.cancel, style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = L10n.Title.inputYourAnswer
            self.alertTextFiled = textField
        })
        
        alert.addAction(UIAlertAction(title: L10n.Title.add, style: .default, handler: {_ in
            if let text = self.alertTextFiled.text, !text.isEmpty {
                let answer = alert.textFields?.first?.text
                self.hardCodedAnswerViewModel.saveCustomAnswer(answer: PresentableAnswer(answer: answer))
                self.defaultAnswers = self.hardCodedAnswerViewModel.getMotivationAnswers()
                self.tableView.reloadData()
                // Решил пока сделать так, но я помню про NSFRC и хочу в будущем работать через него.
                // Очень надеюсь, что так делать не запрещено
            } else {
                return
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension HardCodedAnswersTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self),
                                                 for: indexPath)
        let answer = defaultAnswers[indexPath.row]
        cell.textLabel?.text = answer.answer
        return cell
    }
}
