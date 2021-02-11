//
//  FlashcardSetDetailViewController.swift
//  CS422L
//
//  Created by Jonathan Sligh on 2/5/21.
//

import Foundation
import UIKit

class SecondViewController: UIViewController{
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var movieTitleLabel: UILabel!
    var numberOfMoviesSeen: Int = 0
    var numberOfMoviesNotSeen: Int = 0
    var currentIndex: Int = 0
    @IBOutlet var notSeenLabel: UILabel!
    @IBOutlet var seenLabel: UILabel!
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 8.0
        cardView.layer.borderColor = UIColor.gray.cgColor
        cardView.layer.borderWidth = 2.0
        //connect hard coded collection to sets
        movies = Movie.getHardCodedCollection()
        movieTitleLabel.text = movies[currentIndex].movie
        notSeenLabel.text = "Movies Not Seen: \(numberOfMoviesNotSeen)"
        seenLabel.text = "Movies Seen: \(numberOfMoviesSeen)"
    }
    
    //increments havent seen
    @IBAction func haventSEen(_ sender: Any) {
        numberOfMoviesNotSeen = numberOfMoviesNotSeen + 1
        goToNextMovie()
    }
    
    //increments have seen
    @IBAction func seen(_ sender: Any) {
        numberOfMoviesSeen = numberOfMoviesSeen + 1
        goToNextMovie()
    }
    
    //resets the movie card and increments numbers
    func goToNextMovie()
    {
        currentIndex = currentIndex + 1
        if currentIndex >= movies.count
        {
            currentIndex = 0
            numberOfMoviesNotSeen = 0
            numberOfMoviesSeen = 0
        }
        notSeenLabel.text = "Movies Not Seen: \(numberOfMoviesNotSeen)"
        seenLabel.text = "Movies Seen: \(numberOfMoviesSeen)"
        movieTitleLabel.text = movies[currentIndex].movie
    }
}
