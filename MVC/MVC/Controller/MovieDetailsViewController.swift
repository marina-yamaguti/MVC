//
//  MovieDetailsViewController.swift
//  MVC
//
//  Created by Waldyr Schneider on 20/03/24.
//

import Foundation

class MovieDetailsViewController {
    
    static let shared = MovieDetailsViewController()
    
    var movie: Movie?
    
    private init() {}
       
    func setMovie(_ movie: Movie) {
        self.movie = movie
    }
}
