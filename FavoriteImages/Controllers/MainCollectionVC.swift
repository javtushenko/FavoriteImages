//
//  CollectionViewController.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 19.01.2022.
//

import UIKit
import Alamofire
import AlamofireImage

class MainCollectionVC: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let searchBar = UISearchBar()
    
    let itemPorRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    var randomPhotoArray = [FavoriteModel]()
    var networkManager = NetworkManager()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.fetchRandomImages()
        networkManager.delegate = self

        // Настройка Serch bar
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        searchBar.placeholder = "Найти изображение на Unsplash"
        
        // Настройка Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        
    }
    
    // MARK: Настройка ячеек View Collection
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return randomPhotoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        
        let randomImage = UIImageView()
        
        if indexPath.count != 0 {
            if let imageUrl = URL(string: randomPhotoArray[indexPath.item].imageUrl){
                randomImage.af.setImage(withURL: imageUrl)
            }
        }
        cell.addSubview(randomImage)
        randomImage.translatesAutoresizingMaskIntoConstraints = false
        randomImage.contentMode = .scaleAspectFill
        randomImage.clipsToBounds = true
        randomImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0).isActive = true
        randomImage.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0).isActive = true
        randomImage.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0).isActive = true
        randomImage.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true

        return cell
    }
    
    // MARK: Транспортируем массив из модели
    func newUpdateArray(with randomPhotoForDelegate: [FavoriteModel]) {
        DispatchQueue.main.async {
            self.randomPhotoArray = randomPhotoForDelegate
            self.collectionView.reloadData()
            print("Массив транспортирован в MainCollectionVC")
        }
    }
    
    // MARK: Навигация
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let identifier = segue.identifier else { return }
            if identifier == "infoRandom" {
                let infoVC = segue.destination as! InfoTableVC
                guard let indexPath = collectionView.indexPathsForSelectedItems?[0] else { return }
                infoVC.currentPhoto = self.randomPhotoArray[indexPath.item]
                infoVC.segueSourceFavorite = false
            }
    }
    
    // MARK: Вычисляем размеры ячейки в зависимости от экрана
    func calculationItemSize() -> CGSize {
        let paddingWidth = sectionInserts.left * (itemPorRow + 1)
        let avaibleWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = avaibleWidth / itemPorRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

