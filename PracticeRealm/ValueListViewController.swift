//
//  ValueListViewController.swift
//  PracticeRealm
//
//  Created by Johnny Toda on 2022/07/03.
//

import UIKit

class ValueListViewController: UIViewController {
    @IBOutlet private weak var valueListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        valueListTableView.delegate = self
        valueListTableView.dataSource = self
        registrateXibFile()
    }

    private let nib = "ValueListTableViewCell"
    private let cellID = "CellID"

    private func registrateXibFile() {
        valueListTableView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: cellID)
    }

    private let sampleArray = ["a", "b", "c", "d", "e", "f"]
}

extension ValueListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sampleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = valueListTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ValueListTableViewCell

        cell.configure(saveValue: sampleArray[indexPath.row])

        return cell
    }
}
