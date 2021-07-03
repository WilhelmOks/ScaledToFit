import CoreGraphics

public extension CGSize {
    /// Returns a scaled version of self that fits the specified `size`, preserving the aspect ratio.
    func scaledToFit(size: CGSize) -> CGSize {
        let s = Size.scaledToFit(
            orinigalSize: (width: self.width, height: self.height),
            size: (width: size.width, height: size.height)
        )
        return .init(width: s.width, height: s.height)
    }
    
    /// Returns a scaled down version of self that fits the specified `maxSize`, preserving the aspect ratio.
    /// Returns nil if no scaling is needed.
    func scaledDownToFit(maxSize: CGSize) -> CGSize? {
        let s = Size.scaledDownToFit(
            orinigalSize: (width: self.width, height: self.height),
            maxSize: (width: maxSize.width, height: maxSize.height)
        )
        return s.flatMap(Self.init)
    }
    
    /// Returns a scaled up version of self that fits the specified `minSize`, preserving the aspect ratio.
    /// Returns nil if no scaling is needed.
    func scaledUpToFit(minSize: CGSize) -> CGSize? {
        let s = Size.scaledUpToFit(
            orinigalSize: (width: self.width, height: self.height),
            minSize: (width: minSize.width, height: minSize.height)
        )
        return s.flatMap(Self.init)
    }
}
