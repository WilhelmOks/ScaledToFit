public enum Size<T: FloatingPoint> {
    public typealias S = (width: T, height: T)
    
    /// Returns a scaled version of the `orinigalSize` that fits the `size`, preserving the aspect ratio.
    public static func scaledToFit(orinigalSize: S, size: S) -> S {
        let originalRatio = orinigalSize.width / orinigalSize.height
        let sizeRatio = size.width / size.height
        
        if sizeRatio > originalRatio {
            return (width: size.height * originalRatio, height: size.height)
        } else {
            return (width: size.width, height: size.width / originalRatio)
        }
    }
    
    /// Returns a scaled down version of the `orinigalSize` that fits the `maxSize`, preserving the aspect ratio.
    /// Returns nil if no scaling is needed.
    public static func scaledDownToFit(orinigalSize: S, maxSize: S) -> S? {
        if orinigalSize.width > maxSize.width || orinigalSize.height > maxSize.height {
            return scaledToFit(orinigalSize: orinigalSize, size: maxSize)
        } else {
            return nil
        }
    }
    
    /// Returns a scaled up version of the `orinigalSize` that fits the `minSize`, preserving the aspect ratio.
    /// Returns nil if no scaling is needed.
    public static func scaledUpToFit(orinigalSize: S, minSize: S) -> S? {
        if orinigalSize.width < minSize.width && orinigalSize.height < minSize.height {
            return scaledToFit(orinigalSize: orinigalSize, size: minSize)
        } else {
            return nil
        }
    }
}
