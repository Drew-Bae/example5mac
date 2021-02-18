//
//  ViewController.swift
//  Lab 5 Example
//
//  Created by Jonathan Sligh on 2/18/21.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var artists: [Artist] = []
    var artistsStatic: [String] = ["The Devil Wears Prada", "Thornhill", "Hellions", "Spiritbox", "A Day To Remember"]
    var homeTowns: [String] = ["Dayton, OH", "Melbourne, Australia", "Sydney, Australia", "Vancouver Island, British Columbia", "Ocala, FL"]
    var currentIndex = 0
    var artistSelected: Artist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getArtistsFromDB()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getArtistsFromDB()
    {
        guard let appDelegate =
           UIApplication.shared.delegate as? AppDelegate else {
             return
         }
         
         let managedContext =
           appDelegate.persistentContainer.viewContext
        
         let fetchRequest =
           NSFetchRequest<NSManagedObject>(entityName: "Artist")
         
         //3
         do {
            artists = try managedContext.fetch(fetchRequest) as? [Artist] ?? []
         } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
         }
    }

    @IBAction func addArtist(_ sender: Any) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =
        appDelegate.persistentContainer.viewContext

        let entity =
        NSEntityDescription.entity(forEntityName: "Artist",
                                  in: managedContext)!

        let artist = NSManagedObject(entity: entity,
                                  insertInto: managedContext) as! Artist
        artist.name = artistsStatic[currentIndex]
        artist.hometown = homeTowns[currentIndex]
        currentIndex += 1
        if (currentIndex >= artistsStatic.count)
        {
            currentIndex = 0
        }
        
        do {
            try managedContext.save()
            artists.append(artist)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! ArtistTableViewCell
        cell.artistName.text = artists[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "\(artists[indexPath.row].name ?? "Artist Name")", message: "Hometown: \(artists[indexPath.row].hometown ?? "")", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Albums", style: .default, handler: {_ in
            self.artistSelected = self.artists[indexPath.row]
            self.performSegue(withIdentifier: "GoToAlbums", sender: self)
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToAlbums"
        {
            if let vc = segue.destination as? AlbumsViewController
            {
                vc.selectedArtist = artistSelected
            }
        }
    }
    
}

