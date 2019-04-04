//
//  ViewController.swift
//  Example
//
//  Created by Pavlo Boiko on 4/2/19.
//  Copyright © 2019 Impulse. All rights reserved.
//

import UIKit
import AvatarHashView

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let users = ["One", "Two", "Three", "Four", "Five", "Six", "Seven"]
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: indexPath)
        cell.addSubview(AvatarHashView(hash: users[indexPath.row], frame: cell.bounds))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.size.width - 15) / 2
        return CGSize(width: size, height: size)
    }

}

