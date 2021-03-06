//
//  IndicatorViewCell.swift
//  Ubiquity
//
//  Created by sagesse on 16/03/2017.
//  Copyright © 2017 SAGESSE. All rights reserved.
//

import UIKit

internal class IndicatorViewCell: TilingViewCell {
    
    override init(frame: CGRect) {
        let viewClass = ((type(of: self).contentViewClass as? UIView.Type) ?? UIView.self)
        _contentView = viewClass.init()
        super.init(frame: frame)
        _setup()
    }
    required init?(coder aDecoder: NSCoder) {
        let viewClass = ((type(of: self).contentViewClass as? UIView.Type) ?? UIView.self)
        _contentView = viewClass.init()
        super.init(coder: aDecoder)
        _setup()
    }
    
    
    var contentView: UIView {
        return _contentView
    }
    
    var contentSize: CGSize? {
        willSet {
            setNeedsLayout()
        }
    }
    
    private func _setup() {
        
        _contentView.frame = bounds
        _contentView.clipsToBounds = true
        
        clipsToBounds = true
        addSubview(_contentView)
    }
    
//
//    var asset: Browseable? {
//        willSet {
//            
//            _imageView.image = newValue?.browseImage
//            _imageView.backgroundColor = newValue?.backgroundColor
//            
//            _contentSize = newValue?.browseContentSize
//        }
//    }
//    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let contentSize = contentSize else {
            return
        }
        
        var nframe = CGRect(origin: .zero, size: _fitContentSize ?? .zero)
        if _cacheContentSize != contentSize || _fitContentSize == nil {
            let fit = _convert(contentSize, from: bounds)
            nframe.size = fit
            _fitContentSize = fit
            _cacheContentSize = contentSize
            _cacheBounds = nil
        }
        if _cacheBounds != bounds {
            
            nframe.size.width = min(nframe.width, bounds.width)
            nframe.size.height = min(nframe.height, bounds.height)
            nframe.origin.x = (bounds.width - nframe.width) / 2
            nframe.origin.y = (bounds.height - nframe.height) / 2
            
            contentView.frame = nframe
            
            _cacheBounds = bounds
        }
    }
    
    private func _convert(_ size: CGSize, from rect: CGRect) -> CGSize {
        guard size.height > 0 && rect.height > 0 else {
            return .zero
        }
        let scale = rect.height / size.height
        return CGSize(width: size.width * scale, height: size.height * scale)
    }

    private var _cacheBounds: CGRect?
    private var _cacheContentSize: CGSize?
    private var _fitContentSize: CGSize?
    
    private var _contentView: UIView
}

/// Add dynamic class support
extension IndicatorViewCell {
    // with `conetntClass` generates a new class
    dynamic class func `class`(with conetntClass: AnyClass) -> AnyClass {
        // if the class has been registered, ignore
        let name = "\(NSStringFromClass(self))<\(NSStringFromClass(conetntClass))>"
        if let newClass = objc_getClass(name) as? AnyClass {
            return newClass
        }
        // if you have not registered this, dynamically generate it
        let newClass: AnyClass = objc_allocateClassPair(self, name, 0)
        let method: Method = class_getClassMethod(self, #selector(getter: contentViewClass))
        objc_registerClassPair(newClass)
        // because it is a class method, it can not used class, need to use meta class
        guard let metaClass = objc_getMetaClass(name) as? AnyClass else {
            return newClass
        }
        let getter: @convention(block) () -> AnyClass = {
            return conetntClass
        }
        // add class method
        class_addMethod(metaClass, #selector(getter: contentViewClass), imp_implementationWithBlock(unsafeBitCast(getter, to: AnyObject.self)), method_getTypeEncoding(method))
        return newClass
    }
    // provide content view of class
    dynamic class var contentViewClass: AnyClass {
        return UIView.self
    }
}
