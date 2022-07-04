//
//  HomeViewController.swift
//  PracticeFirebase
//
//  Created by Johnny Toda on 2022/07/04.
//

import UIKit

private enum StoryboardKeyValue {
    static let name = "RegistValue"
    static let id = "storyboardID"
}

class HomeViewController: UIViewController {    
    @IBOutlet private weak var registratedValueLabel: UILabel!

    @IBAction private func showRegistValueVC(_ sender: Any) {
        let registValueVC = UIStoryboard(name: StoryboardKeyValue.name, bundle: nil).instantiateViewController(withIdentifier: StoryboardKeyValue.id) as! RegistValueViewController

        registValueVC.completion = { self.registratedValueLabel.text = $0 }
        navigationController?.pushViewController(registValueVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
