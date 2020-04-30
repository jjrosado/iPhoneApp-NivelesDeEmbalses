//
//  PlacesTableViewCell.swift
//  Niveles de Embalses
//
//  Created by JRo....... on 9/14/15.
//  Copyright (c) 2015 Javier Rosado. All rights reserved.
//
import UIKit
import Foundation

class PlacesTableViewCell: UITableViewCell {
    
    let padding: CGFloat = 5
    var lblDam: UILabel!
    var lblDif: UILabel!
    var lblAverage: UILabel!
    var lblOptimun: UILabel!
    
    var dams: Dam? {
        didSet {
            if let s = dams {
                lblDam.text = s.dam
                lblDam.backgroundColor = s.damColor
                lblDif.text = s.dif
                lblDif.backgroundColor = s.difLabelBgColor
                lblDif.textColor = s.difLabeltextColor
                lblAverage.text = s.average
                lblOptimun.text = s.optimun
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        lblDam = UILabel(frame: CGRectZero)
        lblDam.textAlignment = .Left
        lblDam.textColor = UIColor.grayColor()
        lblDam.font = UIFont(name: lblDam.font.fontName, size: 18)
        //lblDam.font = UIFont.boldSystemFontOfSize(12)
        contentView.addSubview(lblDam)
        
        lblDif = UILabel(frame: CGRectZero)
        lblDif.textAlignment = .Left
        lblDif.font = UIFont(name: lblDif.font.fontName, size: 12)
        lblDif.font = UIFont.boldSystemFontOfSize(12)
        contentView.addSubview(lblDif)
        
        lblAverage = UILabel(frame: CGRectZero)
        lblAverage.textAlignment = .Left
        lblAverage.textColor = UIColor.grayColor()
        lblAverage.font = UIFont(name: lblAverage.font.fontName, size: 12)
        contentView.addSubview(lblAverage)
        
        lblOptimun = UILabel(frame: CGRectZero)
        lblOptimun.textAlignment = .Left
        lblOptimun.textColor = UIColor.grayColor()
        lblOptimun.font = UIFont(name: lblOptimun.font.fontName, size: 12)
        contentView.addSubview(lblOptimun)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lblDam.frame = CGRectMake(10, 0, frame.width/2, 25)
        lblDif.frame = CGRectMake(frame.width/2, 0, frame.width/2, 25)
        lblAverage.frame = CGRectMake(frame.width/2, 25, frame.width/2, 25)
        lblOptimun.frame = CGRectMake(10, 25, frame.width - 25, 25)
    }
}