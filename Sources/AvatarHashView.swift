//
//  AvatarHashView.swift
//  AvatarHashView
//
//  Created by Pavlo Boiko on 4/2/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import UIKit

public var AVATAR_DEFAULT_BLOKS_COUNT: UInt8 = 10

public class AvatarHashView: UIView {
    private var blockPerSide: UInt8
    private var value: Data
    private var scheme: ColorScheme
    
    // MARK: - Init
    public init(hash: String, frame: CGRect, blocksPerSide: UInt8 = AVATAR_DEFAULT_BLOKS_COUNT, scheme: ColorScheme = .fromName) {
        self.scheme = scheme
        self.value = Data(hash.utf8).sha256
        self.blockPerSide = blocksPerSide
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.scheme = .fromName
        self.value = Data([UInt8(arc4random() % UInt32(UInt8.max))]).sha256
        self.blockPerSide = AVATAR_DEFAULT_BLOKS_COUNT
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public
    public func setUser(hash: String, blocksCount: UInt8 = AVATAR_DEFAULT_BLOKS_COUNT) {
        self.value = Data(hash.utf8).sha256
        setNeedsDisplay()
    }
    
    public var image: UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
    
    override public func draw(_ rect: CGRect) {
        let colors = scheme.colors(from: value.hex)
        let oneBlockSize = CGSize(width: rect.size.width / CGFloat(blockPerSide),
                                  height: rect.size.height / CGFloat(blockPerSide))
        
        let backgroudPath = UIBezierPath(rect: rect)
        colors.background.setFill()
        backgroudPath.fill()
        
        let halfOneSideBlocksCount = Int(ceil(Double(blockPerSide) / 2.0))
        let halfAllBlocsCount = halfOneSideBlocksCount * Int(blockPerSide)
        let isEverBlockCount = blockPerSide % 2 == 0
        let negativeBlocksAddition = isEverBlockCount ? 1 : 0
        
        for i in 0..<halfAllBlocsCount {
            let advanceValueBytes = Data("\(i)".utf8)
            let currentFullBytes = value + advanceValueBytes
            let currentBlockData = currentFullBytes.sha256.hex.prefix(5)
            let calculateBlockValue = currentBlockData.reduce(0, { return $0 + UInt64(Data("\($1)".utf8)[0]) })
            let currentValue = calculateBlockValue % 2 == 0
            if currentValue {
                let x = ((i % halfOneSideBlocksCount))
                let y = (i / halfOneSideBlocksCount)
                drawBlock(x: x, y: y, blockSize: oneBlockSize, color: colors.foreground)
                drawBlock(x: -(x + negativeBlocksAddition), y: y, blockSize: oneBlockSize, color: colors.foreground)
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
