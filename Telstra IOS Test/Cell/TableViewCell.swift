//
//  TableViewCell.swift
//  Telstra IOS Test
//
//  Created by M Himanshu on 4/20/20.
//  Copyright © 2020 com.himanshu. All rights reserved.
//

import UIKit
import Foundation

class TableViewCell: UITableViewCell {
    //Mark: Cell components
    let padding: CGFloat = 20
    let tvTitle = UILabel()
    let tvDesc = UITextView()
    let ivThumbImg = UIImageView(image: UIImage(named: "defaultImage"))
    
    //MARK: Cell initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupTableViewCellConstraints()
    }
    
     //MARK: Cell constraints
    func setupTableViewCellConstraints() {
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 130).isActive = true
        ivThumbImg.translatesAutoresizingMaskIntoConstraints = false
        ivThumbImg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ivThumbImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        ivThumbImg.heightAnchor.constraint(equalToConstant: 130).isActive = true
        ivThumbImg.widthAnchor.constraint(equalToConstant: 130).isActive = true
        ivThumbImg.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
        tvTitle.translatesAutoresizingMaskIntoConstraints = false
        tvTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        tvTitle.leadingAnchor.constraint(equalTo: ivThumbImg.trailingAnchor, constant: padding).isActive = true
        tvTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tvDesc.translatesAutoresizingMaskIntoConstraints = false
        tvDesc.topAnchor.constraint(equalTo: tvTitle.bottomAnchor, constant: (padding/4)).isActive = true
        tvDesc.leadingAnchor.constraint(equalTo: tvTitle.leadingAnchor).isActive = true
        tvDesc.trailingAnchor.constraint(equalTo: tvTitle.trailingAnchor).isActive = true
        tvDesc.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -(padding/2)).isActive = true
    }
    
    //MARK: Cell setup
    func setupUI() {
        tvDesc.font = UIFont.systemFont(ofSize: 16)
        tvDesc.isEditable = false
        tvDesc.isSelectable = false
        tvDesc.isScrollEnabled = false
        
        ivThumbImg.contentMode = .scaleAspectFit
        ivThumbImg.clipsToBounds = true
        ivThumbImg.layer.masksToBounds = true
        
        addSubview(tvTitle)
        addSubview(tvDesc)
        addSubview(ivThumbImg)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
