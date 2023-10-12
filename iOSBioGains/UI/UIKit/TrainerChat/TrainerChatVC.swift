//
//  TrainerChatVC.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 10/12/23.
//

import UIKit

class TrainerChatVC: UIViewController {

    private let trainer: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trainer.text = "Trainer Chat VC"
        trainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(trainer)
        
        NSLayoutConstraint.activate([
            trainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            trainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
        self.view.backgroundColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .white : .black
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.view.backgroundColor = previousTraitCollection?.userInterfaceStyle == .light ? .black : .white
    }

}
