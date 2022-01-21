//
//  MainCollectionVC_Extensions.swift
//  FavoriteImages
//
//  Created by Николай Явтушенко on 20.01.2022.
//

import UIKit

// MARK: UICollectionView Delegate Flow Layout
extension MainCollectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculationItemSize()
    }
}

// MARK: NetworkManager Delegate
extension MainCollectionVC: NetworkManagerDelegate {
    
    func transportParseArray(_: NetworkManager, with randomPhoto: [UnitedDataModel]) {
        newUpdateArray(with: randomPhoto)
    }
}


extension MainCollectionVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text != nil {
            let request = searchBar.text
            print(request!)
            networkManager.fetchSearchResult(request: request!)
            self.collectionView.reloadData()
            self.searchPerformed = true
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        if searchPerformed {
            networkManager.fetchRandomImages()
        }
    }
    
}
