//
//  Movie.swift
//  MVC
//
//  Created by Waldyr Schneider on 18/03/24.
//

import Foundation
import UIKit

struct MovieResponse: Decodable {
    var results: [Movie]
}

struct Movie: Decodable, CustomStringConvertible, Hashable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
    
    var id: Int
    var title: String
    var overview: String
    var voteAverage: Double
    var posterPath: String
    
    var imageCover: UIImage?
    
    var description: String {
        return "\(self.id)" + " - " + self.title
    }
}
