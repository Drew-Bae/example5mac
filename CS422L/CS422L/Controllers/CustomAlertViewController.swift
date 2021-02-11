//
//  CustomAlertViewController.swift
//  CS422L
//
//  Created by Jonathan Sligh on 2/11/21.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    @IBOutlet var alertView: UIView!
    var parentVC: MainViewController!
    @IBOutlet var movieTitle: UITextField!
    @IBOutlet var movieDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToLookPretty()
        //set text and description of dialog
        movieTitle.text = parentVC.movies[parentVC.selectedIndex].movie
        movieDescription.text = parentVC.movies[parentVC.selectedIndex].desc
    }
    
    @IBAction func save(_ sender: Any) {
        //change title/description to the new text and tell the tableView to reload
        parentVC.movies[parentVC.selectedIndex].movie = movieTitle.text ?? ""
        parentVC.movies[parentVC.selectedIndex].desc = movieDescription.text ?? ""
        parentVC.movieTableView.reloadData()
        self.dismiss(animated: true, completion: {})
    }
    
    @IBAction func deleteMovie(_ sender: Any) {
        //delete the movie and tell the tableview to reload
        parentVC.movies.remove(at: parentVC.selectedIndex)
        parentVC.movieTableView.reloadData()
        self.dismiss(animated: true, completion: {})
    }

    
    func setupToLookPretty()
    {
        alertView.layer.cornerRadius = 8.0
        alertView.layer.borderWidth = 3.0
        alertView.layer.borderColor = UIColor.gray.cgColor
        movieTitle.becomeFirstResponder()
    }
    
}
