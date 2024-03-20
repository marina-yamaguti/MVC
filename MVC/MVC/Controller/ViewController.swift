//
//  ViewController.swift
//  MVC
//
//  Created by Marina Yamaguti on 18/03/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    //MARK: UITableView Sections
    enum Section: Int, CaseIterable {
        case nowPlaying
        case popular
        
        var value: String {
            switch self {
            case .nowPlaying:
                return "Now Playing"
            case .popular:
                return "Popular"
            }
        }
    }
    
    private let tableView = UITableView()
    private let movieService = MovieService()
    private var subscriptions = Set<AnyCancellable>()
    
    private var sections: [Section] = Section.allCases
    private var nowPlaying: [Movie] = []
    private var popular: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        fetchAllMovies()
    }
    
    private func fetchAllMovies() {
        movieService.fetchMovies(fromPlaylist: .nowPlaying)
            .flatMap({ movies in
                movies.publisher
            })
            .flatMap({ movie in
                return self.movieService.fetchMoviePosterFor(posterPath: movie.posterPath)
                    .map({ data in
                        var newMovie = movie
                        newMovie.imageCover = UIImage(data: data)
                        return newMovie
                    })
                    .catch { _ in Just(movie)}//If any publisher fails a midst pipeline, everything eles fails
            })
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            }, receiveValue: { movie in
                self.nowPlaying = movie
                self.tableView.reloadData()
            })
            .store(in: &subscriptions)
        
        movieService.fetchMovies(fromPlaylist: .popular)
            .flatMap({ movies in
                movies.publisher
            })
            .flatMap({ movie in
                return self.movieService.fetchMoviePosterFor(posterPath: movie.posterPath)
                    .map({ data in
                        var newMovie = movie
                        newMovie.imageCover = UIImage(data: data)
                        return newMovie
                    })
                    .catch { _ in Just(movie)}
            })
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            }, receiveValue: { movie in
                self.popular = movie
                self.tableView.reloadData()
            })
            .store(in: &subscriptions)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = self.sections[section]
        
        switch currentSection {
        case .nowPlaying:
            return self.nowPlaying.count
        case .popular:
            return self.popular.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = self.sections[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else { fatalError() }
        var movie: Movie
        
        switch currentSection {
        case .nowPlaying:
            movie = nowPlaying[indexPath.row]
        case .popular:
            movie = self.popular[indexPath.row]
        }
        
        configureCell(cell, with: movie)
    
        return cell
    }
//    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 4
//    }
}

// MARK: - Cell Configuration Methods
extension ViewController {
    private func configureCell(_ cell: MovieCell, with movie: Movie) {
        var newMovie = movie
        
        if let image = movie.imageCover {
            cell.cover.image = image
        } else {
            if let imageURL = URL(string: movie.posterPath) {
                URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    if let image = UIImage(data: data) {
                        newMovie.imageCover = image
                        
                        DispatchQueue.main.async {
                            cell.cover.image = image
                        }
                    }
                }.resume()
            }
        }
        
        cell.titleLabel.text = newMovie.title
        cell.descriptionLabel.text = newMovie.overview
        cell.ratingLabel.text = String(format: "%.1f", newMovie.voteAverage)
    }
}
