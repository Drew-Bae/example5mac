//
//  ViewController.swift
//  CS422L
//
//  Created by Jonathan Sligh on 1/29/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var movieTableView: UITableView!
    var movies = [Movie]()
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies = Movie.getHardCodedCollection()
        //connect hard coded collection to sets
        movieTableView.delegate = self
        movieTableView.dataSource = self
        //Long press to edit
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        self.movieTableView.addGestureRecognizer(longPressGesture)
    }
    
    //handle long press function
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        //find out where the long press is
        let p = longPressGesture.location(in: self.movieTableView)
        let indexPath = self.movieTableView.indexPathForRow(at: p)
        //if long press is starting (this will also trigger on ending if you dont have this if statement)
        if longPressGesture.state == UIGestureRecognizer.State.began {
            selectedIndex = indexPath?.row ?? 0
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let alertVC = sb.instantiateViewController(identifier: "CustomAlertViewController") as! CustomAlertViewController
            alertVC.parentVC = self
            alertVC.modalPresentationStyle = .overCurrentContext
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        cell.movieTitleLabel.text = movies[indexPath.row].movie
        cell.selectionStyle = .none
        return cell
    }
    
    //create normal alert
    func createAlert(indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "\(movies[indexPath.row].movie)", message: "\(movies[indexPath.row].desc)", preferredStyle: .alert)
        selectedIndex = indexPath.row
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: {})
            self.createCustomEditAlert()
        }))
        self.present(alert, animated: true)
    }
    
    //create custom alert
    func createCustomEditAlert()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let alertVC = sb.instantiateViewController(identifier: "CustomAlertViewController") as! CustomAlertViewController
        alertVC.parentVC = self
        alertVC.modalPresentationStyle = .overCurrentContext
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        createAlert(indexPath: indexPath)
    }
    
    //go to new viewcontroller
    @IBAction func takeQuiz(_ sender: Any) {
        performSegue(withIdentifier: "GoToQuiz", sender: self)
    }
    
    

    
    
    
}

