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
    @IBAction private func showRegistValueVC(_ sender: Any) {
        let registValueVC = UIStoryboard(name: StoryboardKeyValue.name, bundle: nil).instantiateViewController(withIdentifier: StoryboardKeyValue.id) as! RegistValueViewController

        navigationController?.pushViewController(registValueVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
