//
//  ViewController.swift
//  AlfaBank
//
//  Created by Nataly on 23.06.2023.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameViewController = GameViewController()
        addChild(gameViewController)
        view.addSubview(gameViewController.view)
        gameViewController.didMove(toParent: self)
        
        gameViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            gameViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gameViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}



