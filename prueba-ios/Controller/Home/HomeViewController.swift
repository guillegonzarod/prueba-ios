//
//  HomeViewController.swift
//  prueba-ios
//
//  Created by Guille on 7/1/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The outlet of the table view containing the list of characters.
    @IBOutlet weak var contentTable: UITableView!
    
    // MARK: - Variables
    
    // MARK: - Constants
    
    private var characters: [Character] = []
    
    /// Instance of DetailViewController.
    private let detailVc = DetailViewController()
    
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
            self.characters = characters
            DispatchQueue.main.async {
                self.contentTable.reloadData()
                self.dismiss(animated: false, completion: nil)
            }
        }, failure: { (error) in
            self.dismiss(animated: false, completion: nil)
            SharedProvider.shared.showAlert(vc: self, title: "ERROR", message: error.debugDescription, lifespanSeconds: 2)
        })
    }
    
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.contentTable.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as? CustomCell
        cell!.imageC?.load(url: URL(string: self.characters[indexPath.row].image!)!)
        cell!.firstLabelC?.text = self.characters[indexPath.row].name
        cell!.secondLabelC?.text = self.characters[indexPath.row].species
        return cell!
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailVc.character = characters[indexPath.row]
        self.navigationController?.pushViewController(self.detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.characters.remove(at: indexPath.row)
            self.contentTable.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
