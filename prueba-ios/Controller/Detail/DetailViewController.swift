//
//  DetailViewController.swift
//  prueba-ios
//
//  Created by Guille on 7/1/23.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The outlet of the table view containing the detail of character.
    @IBOutlet weak var detailTable: UITableView!
    
    // MARK: - Variables
    
    var character: Character = Character()
    
    var itemList: [ItemDetail] = []
    
    // MARK: - Constants
    
    private var editMode: Bool = false
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        self.navigationItem.title = self.character.name
        self.itemList = []
        self.itemList.append(ItemDetail(name: "Nombre:", description: self.character.name ?? ""))
        self.itemList.append(ItemDetail(name: "Status:", description: self.character.status ?? ""))
        self.itemList.append(ItemDetail(name: "Especie:", description: self.character.species ?? ""))
        self.itemList.append(ItemDetail(name: "Género:", description: self.character.gender ?? ""))
        self.itemList.append(ItemDetail(name: "Origen:", description: self.character.originName ?? ""))
        self.itemList.append(ItemDetail(name: "Procedencia:", description: self.character.locationName ?? ""))
        DispatchQueue.main.async {
            self.detailTable.reloadData()
        }
    }
    
    // MARK: - Functions
    
    @objc private func editCharacter() {
                
        let rowCount  = self.detailTable.numberOfRows(inSection: 0)
        for row in 0 ..< rowCount {
            let cell = self.detailTable.cellForRow(at: NSIndexPath(row: row, section: 0) as IndexPath) as? DetailCustomCell
            cell!.textFieldC?.isUserInteractionEnabled = self.editMode ? false : true
        }
        
        if !self.editMode {
            self.navigationItem.rightBarButtonItem?.title = "Guardar"
            self.editMode = !self.editMode
        } else {
            
            SharedProvider.shared.showLoadingAlert(vc: self, message: "Guardando personaje")
                        
            for row in 0 ..< rowCount {
                let cell = self.detailTable.cellForRow(at: NSIndexPath(row: row, section: 0) as IndexPath) as? DetailCustomCell
                let characterToEdit = self.character
                
                switch cell!.labelC.text! {
                case "Nombre:":
                    characterToEdit.name = cell!.textFieldC.text!
                    break
                case "Status:":
                    characterToEdit.status = cell!.textFieldC.text!
                    break
                case "Especie:":
                    characterToEdit.species = cell!.textFieldC.text!
                    break
                case "Género:":
                    characterToEdit.gender = cell!.textFieldC.text!
                    break
                case "Origen:":
                    characterToEdit.originName = cell!.textFieldC.text!
                    break
                case "Procedencia:":
                    characterToEdit.locationName = cell!.textFieldC.text!
                    break
                default:
                
                    break
                }
            }
            try! self.context.save()
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
                self.navigationItem.rightBarButtonItem?.title = "Editar"
                self.editMode = !self.editMode
            }
            
        }
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
    var readOnly: Bool = false
    
    init(name: String, description: String){
        self.name  = name
        self.description = description
    }
}

