//
//  ItemsViewController.swift
//  testTableView
//
//  Created by Tina Andria on 18/04/2020.
//  Copyright © 2020 Tina Andria. All rights reserved.
//

import UIKit

protocol ItemsDelegate {
    func updateMovie(_ oldMovie: Movie, with movie: Movie)
    func addMovie(_ movie: Movie)
}

class ItemsViewController: UITableViewController {
    var movieStore: MovieStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MovieViewCellStyle.self, forCellReuseIdentifier: "MovieInfoSubtitle" )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView , numberOfRowsInSection section: Int) -> Int {
        return movieStore.allMovies.count
    }
    
    override func tableView(_ tableView: UITableView , cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell , with subtitle appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoSubtitle", for: indexPath)
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let movie: Movie = movieStore.allMovies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "\(movie.director) (rating: \(movie.rating))"
        return cell
    }
    
    override func tableView(_ tableView: UITableView , commit editingStyle: UITableViewCell.EditingStyle , forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let movie = movieStore.allMovies[indexPath.row]
            // Remove the movie from the store
            let title = "Delete \(movie.title) (directed by \(movie.director))?"
            let message = "Are you sure you want to delete this film?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                self.movieStore.removeMovie(movie)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationPath: IndexPath) {
        movieStore.moveItem(from: sourceIndexPath.row, to: destinationPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "showMovie", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("bonjour")
        switch segue.identifier {
            case "showMovie"?:
                print("in case")
                let detailViewController = segue.destination as! MovieDetailsViewController
                detailViewController.delegate = self
                if let row = tableView.indexPathForSelectedRow?.row {
                    print("in if")
                    let movie = movieStore.allMovies[row]
                    detailViewController.movie = movie
                }
            case "addSegue"?:
                let detailViewController = segue.destination as! MovieDetailsViewController
                detailViewController.delegate = self
            default:
                preconditionFailure("Unexpected segue identifier.")
            }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIBarButtonItem) {
    // If you are currently in editing mode...
    if isEditing {
        // Turn off editing mode
        setEditing(false, animated: true)
    } else {
        // Enter editing mode
        setEditing(true, animated: true) }
    }
    
    func updateMovie(_ oldMovie: Movie, with movie: Movie){
        print("in save item")
        if let index = movieStore.allMovies.firstIndex(of: oldMovie) {
            print("neveeeeeeer")
            movieStore.allMovies[index] = movie
            // update tableview
        }
    }

    func addMovie(_ movie: Movie) {
        print("in save item")
        movieStore.addMovie(movie)
        if let index = movieStore.allMovies.firstIndex(of: movie) {
            print("ello")
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }

}
