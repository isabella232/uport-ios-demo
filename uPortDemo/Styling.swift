//
//  Styling.swift
//  uPortDemo
//
//  Created by Cornelis van der Bent on 31/01/2019.
//  Copyright © 2019 ConsenSys. All rights reserved.
//

import UIKit

/// General UI properties.
class Styling
{
    static let uPortPurple = UIColor(red: 0.36, green: 0.31, blue: 0.79, alpha: 1.0)

    static func styleNavigationBars()
    {
        let appearance = UINavigationBar.appearance()

        appearance.tintColor = .white
        appearance.barTintColor = uPortPurple
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    static func addLogoBackground(to tableView: UITableView)
    {
        let imageView = UIImageView(image: UIImage(named: "VerticalLogo"))
        
        imageView.frame = tableView.frame
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(white: 0.2, alpha: 0.02)
        imageView.transform = CGAffineTransform(scaleX: 0.618, y: 0.618)

        tableView.backgroundView = UIView(frame: tableView.frame)
        tableView.backgroundView?.addSubview(imageView);
    }
}
