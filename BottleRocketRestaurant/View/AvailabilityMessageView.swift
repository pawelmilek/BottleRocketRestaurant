//
//  AvailabilityMessageView.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class AvailabilityMessageView: UIView, ViewSetupable {
    static private var parentView: UIView?
    static private let availabilityMessageViewTag = 0x1661316
    
    private var isVisible = false
    private var title: String?
    private var subtitle: String?
    private var labelHeight: CGFloat!
    
    private lazy var titleLabel: UILabel = {
        let xPos = CGFloat(0)
        let yPos = CGFloat(0)
        let width = self.frame.size.width
        
        let label = UILabel(frame: CGRect(x: xPos, y: yPos, width: width, height: self.labelHeight))
        label.text = self.title
        return label
    }()
    
    
    private lazy var subTitleLabel: UILabel = {
        let xPos = CGFloat(0)
        let yPos = self.titleLabel.frame.size.height
        let width = self.frame.size.width
        
        let label = UILabel(frame: CGRect(x: xPos, y: yPos, width: width, height: self.labelHeight))
        label.text = self.subtitle
        return label
    }()
    
    
    required init(frame: CGRect, titles: String ...) {
        super.init(frame: frame)
        self.title = titles.first
        self.subtitle = titles.count > 1 ? titles.last : nil
        self.labelHeight = frame.size.height / CGFloat(titles.count)
        setup()
        setupStyle()
        setupLayout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder aDecoder: NSCoder) not implemented")
    }
}



// MARK: - ViewSetupable protocol
extension AvailabilityMessageView {
    
    func setup() {
        tag = AvailabilityMessageView.availabilityMessageViewTag
    }
    
    
    func setupStyle() {
        typealias MessageStyle = Style.AvailabilityMessageView
        
        titleLabel.textAlignment = MessageStyle.titleLabelTextAlignment
        titleLabel.font = MessageStyle.titleLabelFont
        subTitleLabel.textAlignment = MessageStyle.subTitleLabelTextAlignment
        subTitleLabel.font = MessageStyle.subTitleLabelFont
    }
    
    
    func setupLayout() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 2
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)

        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}


// MARK: - Show/Hide view
extension AvailabilityMessageView {
    
    private static var isViewVisible: Bool {
        guard let _ = parentView?.viewWithTag(availabilityMessageViewTag) else {
            return false
        }
        
        return true
    }
    
    
    static func show(on view: UIView, title: String, subtitle: String? = nil) {
        parentView = view
        guard !isViewVisible else { return }
        
        let messageHeight = CGFloat(25)
        let xPos = CGFloat(0)
        let yPos = (view.frame.size.height - (messageHeight * 2)) / 2
        let width = view.frame.size.width
        
        let frame = CGRect(x: xPos, y: yPos, width: width, height: messageHeight * 2)
        let availabilityMessage = AvailabilityMessageView(frame: frame, titles: title, subtitle ?? "")
        view.addSubview(availabilityMessage)
    }
    
    static func hide() {
        guard isViewVisible else { return }
        let availabilityMessageView = parentView?.viewWithTag(availabilityMessageViewTag)
        availabilityMessageView?.removeFromSuperview()
    }
    
}

