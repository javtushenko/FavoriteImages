//
//  FavoriteTableVC.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 20.01.2022.
//

import UIKit
import SwiftUI
import RealmSwift
import AlamofireImage

class FavoriteTableVC: UITableViewController {
    
    var favoritePhotos: Results<FavoriteModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritePhotos = realm.objects(FavoriteModel.self)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePhotos.isEmpty ? 0 : favoritePhotos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellF", for: indexPath)
        let nameCreator = favoritePhotos[indexPath.row].nameCreator
        let imageUrl = URL(string: favoritePhotos[indexPath.row].imageUrl)
        
        cell.heightAnchor.constraint(equalToConstant: 120).isActive = true
     
        let favoriteImage = UIImageView()
        favoriteImage.af.setImage(withURL: imageUrl!)
        cell.addSubview(favoriteImage)
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.contentMode = .scaleAspectFill
        favoriteImage.clipsToBounds = true
        favoriteImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        favoriteImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        favoriteImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20).isActive = true
        
        let labelCreator = UILabel()
        cell.addSubview(labelCreator)
        labelCreator.text = nameCreator
        labelCreator.translatesAutoresizingMaskIntoConstraints = false
        labelCreator.centerYAnchor.constraint(equalTo: cell.centerYAnchor, constant: 0).isActive = true
        labelCreator.leadingAnchor.constraint(equalTo: favoriteImage.trailingAnchor, constant: 50).isActive = true
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let deletePhoto = favoritePhotos[indexPath.row]
            
            StorageManager.deleteObject(deletePhoto)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
// MARK: Навигация
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            guard let identifier = segue.identifier else { return }
            
            if identifier == "showFavorite" {
                let infoVC = segue.destination as! InfoTableVC
                
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                infoVC.currentPhoto = self.favoritePhotos[indexPath.row]
                infoVC.segueSourceFavorite = true
            }
        

    }
    
}
