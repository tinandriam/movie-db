//
//  Movies.swift
//  testTableView
//
//  Created by Tina Andria on 18/04/2020.
//  Copyright © 2020 Tina Andria. All rights reserved.
//

import UIKit

class Movie: NSObject, NSCoding {
    var title: String;
    var director: String;
    var watchingDate: Date?;
    var dateCreated: Date;
    var review: String;
    var rating: UInt32;
    
    init(title: String, director: String, watchingDate: Date?, rating: UInt32, review: String) {
        self.title = title;
        self.director = director;
        self.watchingDate = watchingDate;
        self.dateCreated = Date();
        self.rating = rating;
        self.review = review;
        super.init();
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(director, forKey: "director")
        aCoder.encode(watchingDate, forKey: "watchingDate")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(review, forKey: "review")
        aCoder.encode(rating, forKey: "rating")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        director = aDecoder.decodeObject(forKey: "director") as! String
        watchingDate = aDecoder.decodeObject(forKey: "watchingDate") as! Date?
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        review = aDecoder.decodeObject(forKey: "review") as! String
        rating = aDecoder.decodeObject(forKey: "rating") as! UInt32
        
    }
    
//    convenience init(random: Bool = false) {
//        if random {
//            let movies = [ "iOS Programming", "iOS in a nutchell", "Learning iOS" ];
//            let director = ["W. Shakespear", "L. Tolstoi", "T. Hardy"];
//            var idx = arc4random_uniform(UInt32(movies.count));
//
//            let randomMovie = movies[Int(idx)];
//            idx = arc4random_uniform(UInt32(director.count));
//            let randomAuthors = director[Int(idx)];
//            let randomRating = arc4random_uniform(UInt32(10));
//            self.init(title: randomMovie, director: randomAuthors, watchingDate: nil, rating: randomRating);
//        } else {
//            self.init(title: "", director: "", watchingDate: nil, rating: 0);
//        }
//    }
}
