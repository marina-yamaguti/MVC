//
//  ViewController.swift
//  MVC
//
//  Created by Marina Yamaguti on 18/03/24.
//

import UIKit

class ViewController: UIViewController {
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    private func configViews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.rowHeight = 118
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

// MARK: - TableView DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else { fatalError() }
        return cell
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
}

