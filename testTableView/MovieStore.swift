//
//  MovieStore.swift
//  testTableView
//
//  Created by Tina Andria on 22/04/2020.
//  Copyright © 2020 Tina Andria. All rights reserved.
//

import UIKit

class MovieStore {
    var allMovies = [Movie]()
    
//    @discardableResult func createMovie() -> Movie {
//        let newMovie = Movie()
//        allMovies.append(newMovie)
//        return newMovie
//    }
    
    init() {
        guard let codeData = try? Data(contentsOf: movieArchiveURL) else { return; }
        allMovies = try! (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codeData) as? [Movie])!
    }
    
    func removeMovie(_ movie: Movie) {
        if let index = allMovies.firstIndex(of: movie) {
            allMovies.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedMovie = allMovies[fromIndex]
        allMovies.remove(at: fromIndex)
        allMovies.insert(movedMovie, at: toIndex)
    }
    
    func addMovie(_ movie: Movie) {
        allMovies.append(movie)
    }
    
    let movieArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!

        return documentDirectory.appendingPathComponent("movie.archive" )
    }()
    
    func saveChanges() -> Bool {
        print("Saving books to: \(movieArchiveURL.path)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allMovies , requiringSecureCoding: false)
            try data.write(to: movieArchiveURL)
            return true;
        } catch {
            return false;
        }
    }
}
