//
//  UserDetailsTabViewHeaderView.swift
//  PracticeFirebase
//
//  Created by Johnny Toda on 2022/07/14.
//

import UIKit

class UserDetailsTableViewHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private weak var profileImageView: UIImageView!

    @IBOutlet private weak var nameLabel: UILabel!

    @IBOutlet private weak var emailLabel: UILabel!

    static let nib = UINib(nibName: String(describing: UserDetailsTableViewHeaderView.self), bundle: nil)
    static let identifier = String(describing: UserDetailsTableViewHeaderView.self)

    func configure(userInfomation: (String?, String?, URL?), height: CGFloat) {
        if let name = userInfomation.0 {
            nameLabel.text = name
        } else {
            nameLabel.text = "名前を表示できません"
        }
        if let email = userInfomation.1 {
            emailLabel.text = email
        } else {
            emailLabel.text = "アドレスを表示できません"
        }
        if let url = userInfomation.2 {
            fetchProfileImage(url: url)
        } else {
            profileImageView.image = UIImage(named: "user_icon")
        }
        let imageheight = height * 0.7
        profileImageView.layer.cornerRadius = imageheight * 0.5
    }
}

extension UserDetailsTableViewHeaderView {
    private func fetchProfileImage(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imageData = data else { return }

            DispatchQueue.global().async { [self] in
                guard let image = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }
        task.resume()
    }
}
