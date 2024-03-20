//
//  MovieService.swift
//  MVC
//
//  Created by Waldyr Schneider on 19/03/24.
//

import Foundation
import Combine
import UIKit

struct MovieService {
    //MARK: Movie Types
    enum MoviePlaylist: String {
        case popular = "popular"
        case nowPlaying = "now_playing"
    }
    //MARK: Poster Sizes
    enum PosterSize: String {
        case w92 = "92"
        case w154 = "154"
        case w185 = "185"
        case w342 = "342"
        case w500 = "500"
        case w780 = "780"
        case original = "original"
    }
    typealias MovieJSON = [String: Any]
    
    func fetchMovies(fromPlaylist type: MoviePlaylist = .popular, atPage page: Int = 1) -> AnyPublisher<[Movie], Error> {
        let url = self.buildAPIUrlFor(movieCategory: type.rawValue, atPage: page)
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .mapError({ $0 as Error })
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMoviePosterFor(posterPath: String, withSize size: PosterSize = .w500) -> AnyPublisher<Data, Error> {
        let url = self.buildPosterURLFor(posterPath: posterPath)
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(\.data)
            .mapError({ $0 as Error })
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension MovieService {
    private func buildAPIUrlFor(movieCategory: String, atPage page: Int) -> URL {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieCategory)?api_key=29e140b5aab9879b19e9118a0af356c9&language=en-US&page=\(page)"
        guard let url = URL(string: urlString) else {
            //in case something happens, return a default first page of popular movies
            return URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=29e140b5aab9879b19e9118a0af356c9&language=en-US&page=1")!
        }
        
        return url
    }
    
    private func buildPosterURLFor(posterPath: String, withSize size: PosterSize = .w500) -> URL {
        let urlString = "https://image.tmdb.org/t/p/\(size)\(posterPath)"
        guard let url = URL(string: urlString) else {
            //in case something happens, return a default poster size of 500
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
        }
        
        return url
    }
}
