//
//  JWTVerificationViewController.swift
//  uPortDemo
//
//  Created by Cornelis van der Bent on 31/01/2019.
//  Copyright © 2019 ConsenSys. All rights reserved.
//

import UIKit
import UPort

class JWTVerificationViewController : UIViewController
{
    required init()
    {
        super.init(nibName: "JWTVerificationViewController", bundle: nil)
        print("called")
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
