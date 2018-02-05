//
//  ImageCacheView.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit
import Foundation

class ImageCacheView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeholderImageView: UIImageView!

    
    private var cachedImage: UIImage? {
        guard let key = imageURL?.absoluteString else { return nil }
        return ImageCache.sharedCache.object(forKey: key as NSString)
    }
    

    private var imageURL: URL? {
        didSet {
            guard let imageURL = imageURL else {
                Logger.log(message: "Image URL not available", event: .error)
                return
            }
            
            if let cachedImage = cachedImage {
                placeholderImageView.alpha = 0
                imageView.alpha = 1
                imageView.image = cachedImage
                
            } else {
                placeholderImageView.alpha = 1
                imageView.alpha = 0
                
                ImageCache.fetchImage(with: imageURL, completionHandler: { image in
                    self.imageView.image = self.cachedImage
                    
                    UIView.animate(withDuration: 0.4) {
                        self.placeholderImageView.alpha = 0
                        self.imageView.alpha = 1
                    }
                })
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.setupStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
        self.setupStyle()
    }
    
}


// MARK: - ViewSetupable protocol
extension ImageCacheView: ViewSetupable {
    
    func setup() {
        loadViewFromNib()
        setPlaceHolderImage()
    }
    
    func setupStyle() {
        imageView.alpha = 0
        placeholderImageView.alpha = 1
    }
}


// MARK: - Set view
private extension ImageCacheView {
    
    func loadViewFromNib() {
        Bundle.main.loadNibNamed(ImageCacheView.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.constrainEdges(toMarginOf: self)
    }

    func setPlaceHolderImage() {
        placeholderImageView.image = UIImage(named: "cellPlaceholder")
        placeholderImageView.contentMode = .scaleAspectFill
    }
}


// MARK: - Setup image view
extension ImageCacheView {
    
    func loadImage(from url: URL) {
        self.imageURL = url
    }
    
}
