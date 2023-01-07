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
    
    // MARK: - Constants
    
    private var editMode: Bool = false
    
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
                
        let rowCount  = self.detailTable.numberOfRows(inSection: 0)
        for row in 0 ..< rowCount {
            let cell = self.detailTable.cellForRow(at: NSIndexPath(row: row, section: 0) as IndexPath) as? DetailCustomCell
            cell!.textFieldC?.isUserInteractionEnabled = self.editMode ? false : true
        }
        
        if !self.editMode {
            self.navigationItem.rightBarButtonItem?.title = "Guardar"
            self.editMode = !self.editMode
        } else {
            let alert = UIAlertController(title: nil, message: "Guardando...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.startAnimating();
            alert.view.addSubview(loadingIndicator)
            self.present(alert, animated: true, completion: nil)
            
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

