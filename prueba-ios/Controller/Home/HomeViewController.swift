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
        
    private var mockData: [Character] = [
        Character(),
        Character(),
        Character(),
        Character(),
        Character(),
        Character(),
        Character(),
        Character(),
        Character(),
        Character()
    ]
    
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
    }
    
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.contentTable.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as? CustomCell
        cell!.imageC?.load(url: URL(string: self.mockData[indexPath.row].image)!)
        cell!.firstLabelC?.text = self.mockData[indexPath.row].name
        cell!.secondLabelC?.text = self.mockData[indexPath.row].species
        return cell!
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailVc.mockCharacter = mockData[indexPath.row]
        self.navigationController?.pushViewController(self.detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                self.mockData.remove(at: indexPath.row)
                self.contentTable.deleteRows(at: [indexPath], with: .automatic)
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
}








struct Origin {
    var name: String = "Earth (C-137)"
    var url: String = "https://rickandmortyapi.com/api/location/1"
}

struct Location {
    var name: String = "Citadel of Ricks"
    var url: String = "https://rickandmortyapi.com/api/location/3"
}

struct Character {
    var id: Int = 1
    var name: String = "Rick Sanchez"
    var status: String = "Alive"
    var species: String = "Human"
    var type: String = ""
    var gender: String = "Male"
    var origin: Origin = Origin()
    var location: Location = Location()
    var image: String = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    var episode: [String] = [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2",
        "https://rickandmortyapi.com/api/episode/3",
        "https://rickandmortyapi.com/api/episode/4",
        "https://rickandmortyapi.com/api/episode/5",
        "https://rickandmortyapi.com/api/episode/6",
        "https://rickandmortyapi.com/api/episode/7",
        "https://rickandmortyapi.com/api/episode/8",
        "https://rickandmortyapi.com/api/episode/9",
        "https://rickandmortyapi.com/api/episode/10",
        "https://rickandmortyapi.com/api/episode/11",
        "https://rickandmortyapi.com/api/episode/12",
        "https://rickandmortyapi.com/api/episode/13",
        "https://rickandmortyapi.com/api/episode/14",
        "https://rickandmortyapi.com/api/episode/15",
        "https://rickandmortyapi.com/api/episode/16",
        "https://rickandmortyapi.com/api/episode/17",
        "https://rickandmortyapi.com/api/episode/18",
        "https://rickandmortyapi.com/api/episode/19",
        "https://rickandmortyapi.com/api/episode/20",
        "https://rickandmortyapi.com/api/episode/21",
        "https://rickandmortyapi.com/api/episode/22",
        "https://rickandmortyapi.com/api/episode/23",
        "https://rickandmortyapi.com/api/episode/24",
        "https://rickandmortyapi.com/api/episode/25",
        "https://rickandmortyapi.com/api/episode/26",
        "https://rickandmortyapi.com/api/episode/27",
        "https://rickandmortyapi.com/api/episode/28",
        "https://rickandmortyapi.com/api/episode/29",
        "https://rickandmortyapi.com/api/episode/30",
        "https://rickandmortyapi.com/api/episode/31",
        "https://rickandmortyapi.com/api/episode/32",
        "https://rickandmortyapi.com/api/episode/33",
        "https://rickandmortyapi.com/api/episode/34",
        "https://rickandmortyapi.com/api/episode/35",
        "https://rickandmortyapi.com/api/episode/36",
        "https://rickandmortyapi.com/api/episode/37",
        "https://rickandmortyapi.com/api/episode/38",
        "https://rickandmortyapi.com/api/episode/39",
        "https://rickandmortyapi.com/api/episode/40",
        "https://rickandmortyapi.com/api/episode/41",
        "https://rickandmortyapi.com/api/episode/42",
        "https://rickandmortyapi.com/api/episode/43",
        "https://rickandmortyapi.com/api/episode/44",
        "https://rickandmortyapi.com/api/episode/45",
        "https://rickandmortyapi.com/api/episode/46",
        "https://rickandmortyapi.com/api/episode/47",
        "https://rickandmortyapi.com/api/episode/48",
        "https://rickandmortyapi.com/api/episode/49",
        "https://rickandmortyapi.com/api/episode/50",
        "https://rickandmortyapi.com/api/episode/51"
    ]
    var url: String = "https://rickandmortyapi.com/api/character/1"
    var created: String = "2017-11-04T18:48:46.250Z"
}


