//
//  SplitViewController.swift
//  SplitVC
//
//  Created by Yassine DAOUDI on 30/12/2021.
//

import UIKit

class SplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureSplitVC()
    }
    
    func configureSplitVC() {
        self.preferredDisplayMode = .automatic
        setViewController(PrimaryViewController(), for: .primary)
        setViewController(SecondaryViewController(), for: .secondary)
    }
}
