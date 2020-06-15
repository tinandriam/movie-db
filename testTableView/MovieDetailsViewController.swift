//
//  MovieDetailsViewController.swift
//  testTableView
//
//  Created by Tina Andria on 23/04/2020.
//  Copyright © 2020 Tina Andria. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var directorTextField: UITextField!

    @IBOutlet weak var ratingTextField: UITextField!

    @IBOutlet weak var dateOfWatching: UIDatePicker!

    @IBOutlet weak var reviewTextField: UITextField!
    
    @IBOutlet var ratingStepper: UIStepper!
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        ratingStepper.minimumValue = 0
        ratingStepper.maximumValue = 10
        ratingStepper.stepValue = 1
        ratingTextField.text = numberFormatter.string(from: NSNumber(value: ratingStepper.value))
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 0
        return nf
    }()
    
    var delegate: ItemsViewController?
    
    @IBAction func onSave(_ sender: Any) {
        let newMovie = Movie(
                title: titleTextField.text ?? "",
                director: directorTextField.text ?? "",
                watchingDate: dateOfWatching.date,
                rating: UInt32(ratingTextField.text ?? "0") ?? 0,
                review: reviewTextField.text ?? "")
        if let movie = movie {
            delegate?.updateMovie(movie, with: newMovie)
        } else {
            delegate?.addMovie(newMovie)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookViewCancel(segue: UIStoryboardSegue) {
        navigationController?.popViewController(animated: true)
    }
    
    var movie: Movie? {
        didSet {
            print("should set")
            navigationItem.title = movie?.title
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.text = movie?.title
        directorTextField.text = movie?.director
        ratingTextField.text = String(movie?.rating ?? 0)
        reviewTextField.text = movie?.review
        if let date = movie?.watchingDate {
            dateOfWatching.date = date
            
        }
//        else {
//            // if watching date not set, disabled the date picker
//            dateOfWatching.isEnabled = false
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movie?.title = titleTextField.text ?? ""
        movie?.director = directorTextField.text ?? ""
        movie?.rating = UInt32(ratingTextField.text ?? "0") ?? 0
        movie?.review = reviewTextField.text ?? ""
        if dateOfWatching.isEnabled {
            movie?.watchingDate = dateOfWatching.date
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
