//
//  ViewController.swift
//  MVC
//
//  Created by Marina Yamaguti on 18/03/24.
//

import UIKit
import Combine

class MoviesView: UIViewController, UITableViewDataSource {
    weak var coordinator: MainCoordinator?
    
    //MARK: - UITableView Sections    
    private let tableView = UITableView()
    
    private var controller: MoviesViewController  = MoviesViewController.shared
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.controller.fetchAllMovies(tableView: tableView)
        configViews()
    }

    
    private func configViews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
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

extension MoviesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var movie: Movie!
        
        if indexPath.section == 0 {
            movie = controller.nowPlaying[indexPath.row]
        } else if indexPath.section == 1 {
            movie = controller.popular[indexPath.row]
        }
        
        MovieDetailsViewController.shared.setMovie(movie)
        coordinator?.goToDetails(movie: movie)
    }
}

// MARK: - TableView DataSource
extension MoviesView {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return controller.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return controller.sections[section].value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = controller.sections[section]
        
        switch currentSection {
        case .nowPlaying:
            return controller.nowPlaying.count
        case .popular:
            return controller.popular.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = controller.sections[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else { fatalError() }
        var movie: Movie
        
        switch currentSection {
        case .nowPlaying:
            movie = controller.nowPlaying[indexPath.row]
        case .popular:
            movie = controller.popular[indexPath.row]
        }
        
        controller.configureCell(cell, with: movie)
    
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude)
        
        return cell
    }
    
}

