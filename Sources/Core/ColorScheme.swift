//
//  ColorScheme.swift
//  AvatarHashView
//
//  Created by Pavlo Boiko on 31.10.2020.
//  Copyright © 2020 Impulse. All rights reserved.
//

import UIKit

public enum ColorScheme {
    case fromName
    case direct(background: UIColor, foreground: UIColor)

    func colors(from value: String) -> (background: UIColor, foreground: UIColor) {
        switch self {
        case .fromName:
            let hexCount = value.count
            let itemsToCut = hexCount - 6
            guard itemsToCut > 0 else {
                fatalError("Wrong colors source value")
            }
            let background =  UIColor(hex: String(value.dropFirst(itemsToCut)))
            let foreground = UIColor(hex: String(value.dropLast(itemsToCut)))
            return (background, foreground)
        case .direct(let background, let foreground):
            return (background, foreground)
        }
    }
}
