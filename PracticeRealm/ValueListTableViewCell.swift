//
//  ValueListTableViewCell.swift
//  PracticeRealm
//
//  Created by Johnny Toda on 2022/07/04.
//

import UIKit

class ValueListTableViewCell: UITableViewCell {
    @IBOutlet private weak var savedValueLabel: UILabel!
    func configure(saveValue: String) {
        savedValueLabel.text = saveValue
    }
}
