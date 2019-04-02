//
//  AvatarHashView.swift
//  AvatarHashView
//
//  Created by Pavlo Boiko on 4/2/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import UIKit

public class AvatarHashView: UIView {
    let blockPerSide: Int = 9
    let oneBlockSize: CGSize
    let value: Data
    
    public init(size: CGSize, hash: String) {
        self.value = Data(hash.utf8).sha256
        self.oneBlockSize = CGSize(width: size.width / CGFloat(blockPerSide),
                                   height: size.height / CGFloat(blockPerSide))
        super.init(frame: CGRect(origin: .zero, size: size))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        let background =  UIColor(hex: String(value.hex.dropFirst(58)))
        let fill = UIColor(hex: String(value.hex.dropLast(58)))
        
        let backgroudPath = UIBezierPath(rect: rect)
        background.setFill()
        backgroudPath.fill()
        let halfBlocksCount = Int(ceil(Double(blockPerSide) / 2.0)) * blockPerSide
        var bits: [Bool] = []
        for i in 0..<halfBlocksCount {
            bits.append(true)
        }
        let halfWidthBlockCount = blockPerSide / 2
        let isEverNumber = blockPerSide * 2 == halfBlocksCount
        bits.enumerated().forEach { (offset, value) in
            let x = ((offset % halfWidthBlockCount))
            let y = ((offset - x) / halfWidthBlockCount)
            let point = CGPoint(x: x, y: y)
            let sholdDuplicate = !(!isEverNumber && x == 5)
    
            if value {
                drawBlock(x: Int(point.x), y: Int(point.y), blockSize: oneBlockSize, color: fill)
                
                if sholdDuplicate {
                    drawBlock(x: -Int(point.x), y: Int(point.y), blockSize: oneBlockSize, color: fill)
                }
            }
            
        }
        
    }
    
    private func drawBlock(x: Int, y: Int, blockSize: CGSize, color: UIColor) {
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
