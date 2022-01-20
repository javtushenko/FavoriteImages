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
    
    let buttonAddToFavorite = UIButton()
    let buttonDeleteForFavorite = UIButton()
    
    var currentPhoto: FavoriteModel!
    var favoritePhoto: Results<FavoriteModel>!
    var segueSourceFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            let selectImageView = UIImageView()
            let url = URL(string: currentPhoto.imageUrl)
            selectImageView.af.setImage(withURL: url!)
            
            // Настройка ячейки
            cell.addSubview(selectImageView)
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.heightAnchor.constraint(equalToConstant: 400).isActive = true
            
            // Настройка отображения изображения
            selectImageView.translatesAutoresizingMaskIntoConstraints = false
            selectImageView.widthAnchor.constraint(equalToConstant: cell.frame.width - 40).isActive = true
            selectImageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            selectImageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 20).isActive = true
            selectImageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 30).isActive = true
            selectImageView.contentMode = .scaleAspectFit
            selectImageView.clipsToBounds = false
            
            return cell
            
        case 1:
            let labelCreator = UILabel()
            labelCreator.text = "Автор: \(currentPhoto.nameCreator)"
            cell.addSubview(labelCreator)
            labelCenterInCell(label: labelCreator, cell: cell)
            return cell
            
        case 2:
            let dateLabel = UILabel()
            dateLabel.text = "Дата создания: \(currentPhoto.dateCreator)"
            cell.addSubview(dateLabel)
            labelCenterInCell(label: dateLabel, cell: cell)
            return cell
            
        case 3:
            let locationLabel = UILabel()
            
            if currentPhoto.locationCountry != nil && currentPhoto.locationCity != nil {
                locationLabel.text =
                "Местоположение: \(currentPhoto.locationCountry!) \(currentPhoto.locationCity!)"
            } else if currentPhoto.locationCountry != nil {
                locationLabel.text = "Местоположение: \(currentPhoto.locationCountry!)"
            } else {
                locationLabel.text = "Местоположение не указано"
            }
            
            cell.addSubview(locationLabel)
            labelCenterInCell(label: locationLabel, cell: cell)
            return cell
            
        case 4:
            let downloadLabel = UILabel()
            downloadLabel.text = "Количество скачиваний: \(currentPhoto.countDownloads)"
            cell.addSubview(downloadLabel)
            labelCenterInCell(label: downloadLabel, cell: cell)
            return cell
            
        case 5:
            
            // Проверяем с какой View пришел пользователь
            if currentPhoto != nil {
                if segueSourceFavorite == false {
                    buttonDeleteForFavorite.isHidden = true
                    buttonAddToFavorite.isHidden = false
                } else {
                    buttonAddToFavorite.isHidden = true
                    buttonDeleteForFavorite.isHidden = false
                }
            }
            
            // Добавление actions кнопок
            buttonAddToFavorite.addTarget(self, action: #selector(buttonAddToFavoriteAction(button:)), for: .touchUpInside)
            buttonDeleteForFavorite.addTarget(self, action: #selector(buttonDeleteForFavoriteAction(button:)), for: .touchUpInside)
            
            // Настройка кнопок
            cell.addSubview(buttonAddToFavorite)
            cell.addSubview(buttonDeleteForFavorite)
            buttonAddToFavorite.translatesAutoresizingMaskIntoConstraints = false
            buttonAddToFavorite.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            buttonAddToFavorite.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            buttonAddToFavorite.setAttributedTitle(NSAttributedString(string: "Добавить в избранное"), for: .normal)
            
            buttonDeleteForFavorite.translatesAutoresizingMaskIntoConstraints = false
            buttonDeleteForFavorite.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            buttonDeleteForFavorite.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            buttonDeleteForFavorite.setAttributedTitle(NSAttributedString(string: "Убрать из избранного"), for: .normal)
            return cell
            
        default: return cell
        }
        
    }
    
    // Добавление в базу данных
    @objc func buttonAddToFavoriteAction(button: UIButton) {
        guard let addPhoto = currentPhoto else { return }
        StorageManager.saveObject(addPhoto)
        
        buttonAddToFavorite.isHidden = true
        buttonDeleteForFavorite.isHidden = false
        
        print("Добавление в БД")
    }
    
    // Удаление из базы данных
    @objc func buttonDeleteForFavoriteAction(button: UIButton) {
        guard let deletePhoto = currentPhoto else { return }
        StorageManager.deleteObject(deletePhoto)
        
        buttonAddToFavorite.isHidden = false
        buttonDeleteForFavorite.isHidden = true
        
        print("Удаление из БД")
    }
    
    // Размещение лейбла в ячейке
    func labelCenterInCell(label: UILabel, cell: UITableViewCell) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 20).isActive = true
        label.textAlignment = .center
    }
}

