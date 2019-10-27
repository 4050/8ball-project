//
//  HardCodedAnswersTableViewController.swift
//  8ball_testproject
//
//  Created by Станислав on 12/10/2019.
//  Copyright © 2019 Stanislav Buryan. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class HardCodedAnswersTableViewController: UIViewController, UITabBarDelegate {

    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    private var safeArea: UILayoutGuide!
    private var alertTextFiled = UITextField()
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
        //tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupBindings()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveButton))
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         self.hardCodedAnswerViewModel.tapAction.onNext(())
        //defaultAnswers = hardCodedAnswerViewModel.getMotivationAnswers()
        //tableView.reloadData()
    }

    private func setupBindings() {
        hardCodedAnswerViewModel.answerStream.bind(
        to: tableView.rx.items(cellIdentifier: "cell")) { rowItem, answer, cell in
            cell.textLabel?.text = answer
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            }.disposed(by: disposeBag)
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
                //self.hardCodedAnswerViewModel.customAnswer.onNext(PresentableAnswer(answer: answer))
                //self.hardCodedAnswerViewModel.saveCustomAnswer(answer: PresentableAnswer(answer: answer))
                //self.hardCodedAnswerViewModel.tapAction.onNext(())
                //self.defaultAnswers = self.hardCodedAnswerViewModel.getMotivationAnswers()
                //self.tableView.reloadData()
            } else {
                return
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//extension HardCodedAnswersTableViewController: UITableViewDataSource {
   // func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   //     return defaultAnswers.count
   // }
//
   // func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   //     let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self),
   //                                              for: indexPath)
   //     let answer = defaultAnswers[indexPath.row]
   //     cell.textLabel?.text = answer.answer
   //     return cell
   // }
//}
