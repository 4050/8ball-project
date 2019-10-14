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
    private var defaultAnswers: [PresentableAnswer] = []
    private var hardCodedAnswerViewModel: HardCodedAnswersViewModel

    init(hardCodedAnswerViewModel: HardCodedAnswersViewModel) {
        self.hardCodedAnswerViewModel = hardCodedAnswerViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        tableView.dataSource = self
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableData()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func setupTableData() {
        defaultAnswers = hardCodedAnswerViewModel.getMotivationAnswers()
        tableView.reloadData()
    }
}

extension HardCodedAnswersTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultAnswers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let answer = defaultAnswers[indexPath.row]
        cell.textLabel?.text = answer.answer
        return cell
    }

}
