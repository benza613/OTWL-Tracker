//
//  StagesTableViewCell.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 16/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit

class StagesTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
}

extension StagesTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}

