//
//  AvatarDetailViewController.swift
//  Example
//
//  Created by Pavlo Boiko on 4/6/19.
//  Copyright © 2019 Impulse. All rights reserved.
//

import UIKit

class AvatarDetailViewController: UIViewController {
    var image: UIImage?
    @IBOutlet weak var avatarView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarView.image = image
    }
}
