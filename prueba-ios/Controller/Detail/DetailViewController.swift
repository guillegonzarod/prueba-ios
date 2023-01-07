//
//  DetailViewController.swift
//  prueba-ios
//
//  Created by Guille on 7/1/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The outlet of the table view containing the detail of character.
    @IBOutlet weak var detailTable: UITableView!
    
    // MARK: - Variables
    
    var mockCharacter: Character = Character()
    
    var itemList: [ItemDetail] = []
    
    // MARK: - Life Cycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(self.editCharacter))
        self.detailTable.dataSource = self
        self.detailTable.delegate = self
        self.detailTable.tableFooterView = UIView()
        self.detailTable.register(UINib(nibName: "DetailCustomCell", bundle: nil), forCellReuseIdentifier: "detailcustomcell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.mockCharacter)
        self.navigationItem.title = self.mockCharacter.name
        self.itemList.append(ItemDetail(name: "Nombre:", description: self.mockCharacter.name))
        self.itemList.append(ItemDetail(name: "Status:", description: self.mockCharacter.status))
        self.itemList.append(ItemDetail(name: "Especie:", description: self.mockCharacter.species))
        self.itemList.append(ItemDetail(name: "Género:", description: self.mockCharacter.gender))
        self.itemList.append(ItemDetail(name: "Origen:", description: self.mockCharacter.origin.name))
        self.itemList.append(ItemDetail(name: "Procedencia:", description: self.mockCharacter.location.name))
    }
    
    // MARK: - Functions
    
    @objc private func editCharacter() {
        print("Editing...")
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.detailTable.dequeueReusableCell(withIdentifier: "detailcustomcell", for: indexPath) as? DetailCustomCell
        cell!.labelC?.text = self.itemList[indexPath.row].name
        cell!.textFieldC?.text = self.itemList[indexPath.row].description
        return cell!
    }
}

// MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

struct ItemDetail {
    var name: String = ""
    var description: String = ""
    
    init(name: String, description: String){
            self.name  = name
            self.description = description
        }
}

