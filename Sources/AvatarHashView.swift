//
//  AvatarHashView.swift
//  AvatarHashView
//
//  Created by Pavlo Boiko on 4/2/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import UIKit

public var DEFAULT_BLOKS_COUNT: Int = 8

public class AvatarHashView: UIView {
    private var blockPerSide: Int
    private var value: Data
    
    // MARK: - Init
    public init(hash: String, frame: CGRect, blocksPerSide: Int = DEFAULT_BLOKS_COUNT) {
        self.value = Data(hash.utf8).sha256
        self.blockPerSide = blocksPerSide
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.value = Data([UInt8(arc4random() % UInt32(UInt8.max))]).sha256
        self.blockPerSide = 8
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public
    public func setUser(hash: String, blocksCount: Int = DEFAULT_BLOKS_COUNT) {
        self.value = Data(hash.utf8).sha256
        setNeedsDisplay()
    }
    
    public var image: UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { ctx in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
    
    override public func draw(_ rect: CGRect) {
        let valueHex = value.hex
        let itemsToCut = value.hex.count - 6
        let background =  UIColor(hex: String(valueHex.dropFirst(itemsToCut)))
        let fill = UIColor(hex: String(valueHex.dropLast(itemsToCut)))
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
    
    // MARK: - Private
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
