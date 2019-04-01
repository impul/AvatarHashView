//
//  AvatarHashView.swift
//  AvatarHashView
//
//  Created by Pavlo Boiko on 4/2/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import UIKit

class AvatarHashView: UIView {
    let blockPerSide: Int = 10
    let oneBlockSize: CGSize
    let value: Data
    
    init(size: CGSize, hash: String) {
        self.value = Data(hash.utf8).sha256
        self.oneBlockSize = CGSize(width: size.width / CGFloat(blockPerSide),
                                   height: size.height / CGFloat(blockPerSide))
        super.init(frame: CGRect(origin: .zero, size: size))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let background =  UIColor(hex: String(value.hex.dropFirst(26)))
        let fill = UIColor(hex: String(value.hex.dropLast(26)))
        
        let backgroudPath = UIBezierPath(rect: rect)
        background.setFill()
        backgroudPath.fill()
        let halfBlocksCount = (blockPerSide * blockPerSide) / 2
        var bits: [Bool] = []
        for i in 0..<halfBlocksCount {
            bits.append(i % 2 == 0)
        }
        let halfWidthBlockCount = blockPerSide / 2
        bits.enumerated().forEach { (offset, value) in
            let x = ((offset % halfWidthBlockCount))
            let y = ((offset - x) / halfWidthBlockCount)
            let point = CGPoint(x: x, y: y)
            if value {
                drawBlock(x: Int(point.x), y: Int(point.y), blockSize: oneBlockSize, color: fill)
                drawBlock(x: -Int(point.x) - 1, y: Int(point.y), blockSize: oneBlockSize, color: fill)
            }
            
        }
        
    }
    
    func drawBlock(x: Int, y: Int, blockSize: CGSize, color: UIColor) {
        print("x: \(x), y: \(y)")
        let halfWidthBlockCount = blockPerSide / 2
        let halfWidth = blockSize.width * CGFloat(halfWidthBlockCount)
        let point = CGPoint(x: (CGFloat(x) * blockSize.width) + halfWidth ,
                            y: CGFloat(y) * blockSize.height)
        let path = UIBezierPath(rect: CGRect(origin: point, size: oneBlockSize))
        color.setFill()
        path.fill()
    }
}
