//
//  WebNavigationView.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

final class WebNavigationView: UIView {
    private static let buttonSize = CGSize(width: 40, height: 40)
    private let backButton: UIButton = {
        let button = UIButton(frame: .zero)
        let backImage = UIImage(named: "icon_webBack")
        
        button.backgroundColor = .clear
        button.setImage(backImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(WebNavigationView.pressedBackButton), for: .touchUpInside)
        button.isHidden = false
        
        button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        
        return button
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(frame: .zero)
        let refreshImage = UIImage(named: "icon_webRefresh")
        
        button.backgroundColor = .clear
        button.setImage(refreshImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(WebNavigationView.pressedRefreshButton), for: .touchUpInside)
        button.isHidden = false
        
        button.heightAnchor.constraint(equalToConstant: WebNavigationView.buttonSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton(frame: .zero)
        let forwardImage = UIImage(named: "icon_webForward")
        
        button.backgroundColor = .clear
        button.setImage(forwardImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(WebNavigationView.pressedForwardButton), for: .touchUpInside)
        button.isHidden = false
        
        button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        return button
    }()
    
    weak var delegate: WebNavigationViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupStyle()
    }
}


// MARK: - ViewSetupable protocol
extension WebNavigationView: ViewSetupable {
    
    func setup() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 12
        
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(refreshButton)
        stackView.addArrangedSubview(forwardButton)
        
        addSubview(stackView)
        stackView.constrainEdges(toMarginOf: self)
    }
    
    func setupStyle() {
        backgroundColor = .clear
    }
}


// MARK: - Actions
extension WebNavigationView {
    
    @objc func pressedBackButton() {
        delegate?.webNavigationView(self, didSelectBackButton: backButton)
    }
    
    @objc func pressedRefreshButton() {
        delegate?.webNavigationView(self, didSelectRefreshButton: refreshButton)
    }
    
    @objc func pressedForwardButton() {
        delegate?.webNavigationView(self, didSelectForwardButton: forwardButton)
    }
    
}

