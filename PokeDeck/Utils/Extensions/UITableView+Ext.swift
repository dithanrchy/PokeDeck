//
//  UITableView+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 26/01/23.
//

import UIKit

extension UITableView {
    func setEmptyMessage(
        image: UIImage,
        title: String,
        message: String,
        centerYAnchorConstant: CGFloat = 0
    ) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let imageEmpty = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        imageEmpty.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(imageEmpty)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)

        imageEmpty.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: centerYAnchorConstant).isActive = true
        imageEmpty.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageEmpty.bottomAnchor, constant: 15).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        imageEmpty.image = image
        titleLabel.text = title
        titleLabel.textAlignment = .center
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
