//
//  UserDetailsTableViewCell.swift
//  PracticeFirebase
//
//  Created by Johnny Toda on 2022/07/14.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {
    @IBOutlet private weak var optionLabel: UILabel!

    static let nib = UINib(nibName: String(describing: UserDetailsTableViewCell.self), bundle: nil)
    static let identifier = String(describing: UserDetailsTableViewCell.self)

    func configure(option: String?, textColor: UIColor) {
        optionLabel.text = option
        optionLabel.textColor = textColor
    }
}
