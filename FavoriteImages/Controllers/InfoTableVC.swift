//
//  InfoTableVC.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 19.01.2022.
//

import UIKit
import AlamofireImage
import RealmSwift

class InfoTableVC: UITableViewController {
    
    var currentPhoto: FavoriteModel!
    var favoritePhoto: Results<FavoriteModel>!
    var segueSourceFavorite = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locateLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var buttonAddFavorite: UIButton!
    @IBOutlet weak var buttonRemoveFavorite: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentPhoto != nil {
            
            if segueSourceFavorite == false {
                buttonRemoveFavorite.isHidden = true
                buttonAddFavorite.isHidden = false
            } else {
                buttonAddFavorite.isHidden = true
                buttonRemoveFavorite.isHidden = false
            }
            
            let url = URL(string: currentPhoto.imageUrl)
            imageView.af.setImage(withURL: url!)
            
            
            creatorLabel.text = "Автор: \(currentPhoto.nameCreator)"
            dateLabel.text = "Дата создания: \(currentPhoto.dateCreator)"
            downloadLabel.text = "Количество скачиваний: \(currentPhoto.countDownloads)"
            
            if currentPhoto.locationCountry != nil && currentPhoto.locationCity != nil {
                locateLabel.text =
                "Местоположение: \(currentPhoto.locationCountry!) \(currentPhoto.locationCity!)"
            } else if currentPhoto.locationCountry != nil {
                locateLabel.text = "Местоположение: \(currentPhoto.locationCountry!)"
            } else {
                locateLabel.text = "Местоположение не указано"
            }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // Добавление в базу данных
    @IBAction func addFavoriteAction(_ sender: UIButton) {
        
        guard let addPhoto = currentPhoto else { return }
        StorageManager.saveObject(addPhoto)
        
        buttonAddFavorite.isHidden = true
        buttonRemoveFavorite.isHidden = false
        
        print("Добавление в БД")
    }
    
    // Удаление из базы данных
    @IBAction func removeFavoriteAction(_ sender: UIButton) {
        
        guard let deletePhoto = currentPhoto else { return }
        StorageManager.deleteObject(deletePhoto)
        
        buttonAddFavorite.isHidden = false
        buttonRemoveFavorite.isHidden = true
        
        print("Удаление из БД")
    }
    
    func updateChange() {
        
    }
}

