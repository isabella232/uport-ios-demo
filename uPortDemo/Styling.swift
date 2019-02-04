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
    static let backgroundGrey = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)

    static func styleNavigationBars()
    {
        let appearance = UINavigationBar.appearance()

        appearance.tintColor = .white
        appearance.barTintColor = uPortPurple
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    static func addLogoBackground(to view: UIView)
    {
        guard let topView = UIApplication.shared.keyWindow?.rootViewController?.view else
        {
            return
        }

        let tag = 1111
        guard view.viewWithTag(tag) == nil else
        {
            return
        }

        let imageView = UIImageView(image: UIImage(named: "VerticalLogo"))
        imageView.tag = tag

        imageView.frame = view.convert(topView.frame, from: topView)

        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(white: 0.2, alpha: 0.05)
        imageView.transform = CGAffineTransform(scaleX: 0.618, y: 0.618)

        view.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]

        view.addSubview(imageView);
    }

    static func styleButton(_ button: UIButton)
    {
        assert(button.buttonType == .custom)

        let color = Styling.uPortPurple

        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = color.cgColor

        button.setTitleColor(color, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)

        UIGraphicsBeginImageContextWithOptions(button.frame.size, true, 0);
        let context = UIGraphicsGetCurrentContext()!
        color.setFill()
        context.fill(CGRect(x: 0, y: 0, width: button.frame.width, height: button.frame.height));
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        button.setBackgroundImage(image, for: .highlighted)
        button.backgroundColor = .white
    }
}
