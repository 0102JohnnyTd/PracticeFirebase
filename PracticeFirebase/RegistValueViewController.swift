//
//  ViewController.swift
//  PracticeFirebase
//
//  Created by Johnny Toda on 2022/07/03.
//

import UIKit

class RegistValueViewController: UIViewController {
    @IBOutlet private weak var valueTextView: UITextView!
    @IBAction private func registValue(_ sender: Any) {
        completion?(valueTextView.text)
        navigationController?.popViewController(animated: true)
    }
    
    var completion: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
