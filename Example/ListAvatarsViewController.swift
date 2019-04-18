//
//  ListAvatarsViewController.swift
//  Example
//
//  Created by Pavlo Boiko on 4/2/19.
//  Copyright © 2019 Impulse. All rights reserved.
//

import UIKit
import AvatarHashView

class ListAvatarsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let users = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Eleven", "Ten"]
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ExampleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: indexPath) as! ExampleCell
        cell.avatarView.setUser(hash: users[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.size.width - 15) / 2
        return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ExampleCell
        let image = cell.avatarView.image
        let detail = storyboard?.instantiateViewController(withIdentifier: "AvatarDetailViewController") as! AvatarDetailViewController
        detail.image = image
        navigationController?.pushViewController(detail, animated: true)
    }
}
