//
//  DetailViewController.swift
//  prueba-ios
//
//  Created by Guille on 7/1/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    
    var mockCharacter: Any = ""
    
    // MARK: - Life Cycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(self.editCharacter))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.mockCharacter)
    }
    
    // MARK: - Functions
    
    @objc private func editCharacter() {
        print("Editing...")
    }
}
