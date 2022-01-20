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
    
    func transportParseArray(_: NetworkManager, with randomPhoto: [FavoriteModel]) {
        newUpdateArray(with: randomPhoto)
    }
}

 
