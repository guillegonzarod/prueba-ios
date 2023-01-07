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
    
    private let mockData = [
        "value0",
        "value1",
        "value2",
        "value3"
    ]
        
    // MARK: - Constants
    
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
    }

}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.contentTable.dequeueReusableCell(withIdentifier: "tcell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "tcell")
        }
        if #available(iOS 14.0, *) {
            var content = cell?.defaultContentConfiguration()
            content?.text = self.mockData[indexPath.row]
            cell?.contentConfiguration = content
        } else {
            cell!.textLabel?.text = self.mockData[indexPath.row]
        }
        return cell!
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailVc.mockCharacter = mockData[indexPath.row]
        self.navigationController?.pushViewController(self.detailVc, animated: true)
    }
}
