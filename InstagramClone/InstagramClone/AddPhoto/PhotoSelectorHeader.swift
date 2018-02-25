//
//  PhotoSelectorHeader.swift
//  InstagramClone
//
//  Created by Monika Koschel on 25/02/2018.
//  Copyright © 2018 Monika Koschel. All rights reserved.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func set(photo: UIImage) {
        photoImageView.image = photo
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
