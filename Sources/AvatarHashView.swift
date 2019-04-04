//
//  AvatarHashView.swift
//  AvatarHashView
//
//  Created by Pavlo Boiko on 4/2/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import UIKit

public class AvatarHashView: UIView {
    let blockPerSide: Int = 8
    let value: Data
    
    
    public init(hash: String, frame: CGRect) {
        self.value = Data(hash.utf8).sha256
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        let background =  UIColor(hex: String(value.hex.dropFirst(58)))
        let fill = UIColor(hex: String(value.hex.dropLast(58)))
        let oneBlockSize = CGSize(width: rect.size.width / CGFloat(blockPerSide),
                                  height: rect.size.height / CGFloat(blockPerSide))
        
        let backgroudPath = UIBezierPath(rect: rect)
        background.setFill()
        backgroudPath.fill()
        
        let halfBlocksCount = Int(ceil(Double(blockPerSide) / 2.0))
        let halfAllBlocsCount = halfBlocksCount * blockPerSide
        let isEverBlockCount = blockPerSide % 2 == 0
        let negativeBlocksAddition = isEverBlockCount ? 1 : 0
        
        for i in 0..<halfAllBlocsCount {
            let currentBlockData = value.advanced(by: i).sha256.map { return UInt64($0) }
            let currentValue = currentBlockData.reduce(0, +) % 2 == 0
            if currentValue {
                let x = ((i % halfBlocksCount))
                let y = (i / halfBlocksCount)
                drawBlock(x: x, y: y, blockSize: oneBlockSize, color: fill)
                drawBlock(x: -(x + negativeBlocksAddition), y: y, blockSize: oneBlockSize, color: fill)
            }
        }
    }
    
    private func drawBlock(x: Int, y: Int, blockSize: CGSize, color: UIColor) {
        let halfWidthBlockCount = blockPerSide / 2
        let halfWidth = blockSize.width * CGFloat(halfWidthBlockCount)
        let point = CGPoint(x: (CGFloat(x) * blockSize.width) + halfWidth ,
                            y: CGFloat(y) * blockSize.height)
        let path = UIBezierPath(rect: CGRect(origin: point, size: blockSize))
        color.setFill()
        path.fill()
    }
}
