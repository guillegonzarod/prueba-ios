//
//  HomeViewController.swift
//  prueba-ios
//
//  Created by Guille on 7/1/23.
//

import UIKit
import CoreData

final class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The outlet of the table view containing the list of characters.
    @IBOutlet weak var contentTable: UITableView!
    
    // MARK: - Variables
    
    private var characters: [Character]?
    
    // MARK: - Constants
    
    /// Instance of DetailViewController.
    private let detailVc = DetailViewController()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Initialization
    
    /// Initializes a new home screen view controller.
    init(){
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Personajes"
        self.navigationItem.backButtonTitle = "Volver"
        self.contentTable.dataSource = self
        self.contentTable.delegate = self
        self.contentTable.tableFooterView = UIView()
        self.contentTable.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customcell")
        SharedProvider.shared.showLoadingAlert(vc: self, message: "Cargando personajes")
        ApiCommunicationProvider.shared.getAllCharacters(success: { (characters) in
            
            self.delete(entityName: "Character")
            
            for c in characters {
                                
                let character = Character(context: self.context)
                character.id = c.id!
                character.name = c.name
                character.status = c.status
                character.species = c.species
                character.type = c.type
                character.gender = c.gender
                character.originName = c.origin?.name
                character.originUrl = c.origin?.url
                character.locationName = c.location?.name
                character.locationUrl = c.location?.url
                character.image = c.image
                character.episode = c.episode
                character.url = c.url
                character.created = c.created
            }
            
            try! self.context.save()
            
            DispatchQueue.main.async {
                self.fetchCharacters()
                self.dismiss(animated: false, completion: nil)
            }
        }, failure: { (error) in
            self.dismiss(animated: false, completion: nil)
            SharedProvider.shared.showAlert(vc: self, title: "ERROR", message: error.debugDescription, lifespanSeconds: 2)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCharacters()
    }
    
    // MARK: - Functions
    
    func delete(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            SharedProvider.shared.showAlert(vc: self, title: "ERROR", message: error.debugDescription, lifespanSeconds: 2)
        }
    }
    
    private func fetchCharacters() {
        do {
            self.characters = []
            self.characters = try context.fetch(Character.fetchRequest())
            DispatchQueue.main.async {
                self.contentTable.reloadData()
            }
        } catch {
            SharedProvider.shared.showAlert(vc: self, title: "ERROR", message: "Se ha producido un error al recuperar los datos", lifespanSeconds: 2)
        }
    }
    
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.contentTable.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as? CustomCell
        cell!.imageC?.load(url: URL(string: self.characters![indexPath.row].image!)!)
        cell!.firstLabelC?.text = self.characters![indexPath.row].name
        cell!.secondLabelC?.text = self.characters![indexPath.row].species
        return cell!
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailVc.character = characters![indexPath.row]
        self.navigationController?.pushViewController(self.detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            let characterToDelete = self.characters![indexPath.row]
            self.context.delete(characterToDelete)
            try! self.context.save()
            self.characters!.remove(at: indexPath.row)
            self.contentTable.deleteRows(at: [indexPath], with: .automatic)
            DispatchQueue.main.async {
                self.fetchCharacters()
                completionHandler(true)
            }
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
