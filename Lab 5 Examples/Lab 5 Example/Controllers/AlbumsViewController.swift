//
//  AlbumsViewController.swift
//  Lab 5 Example
//
//  Created by Jonathan Sligh on 2/18/21.
//

import UIKit
import CoreData

class AlbumsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet var tableView: UITableView!
    var selectedArtist: Artist?
    var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup()
    {
        tableView.delegate = self
        tableView.dataSource = self
        if let artist = selectedArtist
        {
            title = artist.name
            albums = Array(artist.albums as! Set<Album>)
        }
    }
    
    @IBAction func addAlbum(_ sender: Any) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =
        appDelegate.persistentContainer.viewContext

        let entity =
        NSEntityDescription.entity(forEntityName: "Album",
                                  in: managedContext)!

        let album = NSManagedObject(entity: entity,
                                  insertInto: managedContext) as! Album
        album.artist = selectedArtist
        album.title = "New Album Title"
        
        do {
            try managedContext.save()
            //selectedArtist?.addToAlbums(album)
            albums = Array(selectedArtist?.albums as! Set<Album>)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! ArtistTableViewCell
        cell.artistName.text = albums[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        albums[indexPath.row].title = "Clicked Album Title"
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedAlbum = albums[indexPath.row]
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext =
            appDelegate.persistentContainer.viewContext
            managedContext.delete(deletedAlbum)
            selectedArtist?.removeFromAlbums(deletedAlbum)
            albums.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

}
