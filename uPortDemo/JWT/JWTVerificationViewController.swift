//
//  JWTVerificationViewController.swift
//  uPortDemo
//
//  Created by Cornelis van der Bent on 31/01/2019.
//  Copyright © 2019 ConsenSys. All rights reserved.
//

import UIKit
import UPort

class DateProvider: JWTToolsDateProvider
{
    var date: Date

    init(date: Date)
    {
        self.date = date
    }

    func now() -> Date
    {
        return date
    }
}

class JWTVerificationViewController : UIViewController
{
    @IBOutlet var incomingJwtLabel: UILabel!
    @IBOutlet var payloadLabel: UILabel!
    @IBOutlet var verifyButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    required init()
    {
        super.init(nibName: "JWTVerificationViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

        self.view.backgroundColor = Styling.backgroundGrey
        Styling.addLogoBackground(to: self.view)

        Styling.styleButton(self.verifyButton)

        self.incomingJwtLabel.text = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NksifQ.eyJpc3MiOiIyb21SSlpMMjNaQ1lnYzFyWnJG" +
                                     "VnBGWEpwV29hRUV1SlVjZiIsImlhdCI6MTUxOTM1MDI1NiwicGVybWlzc2lvbnMiOlsibm90aWZ" +
                                     "pY2F0aW9ucyJdLCJjYWxsYmFjayI6Imh0dHBzOi8vYXBpLnVwb3J0LnNwYWNlL29sb3J1bi9jcm" +
                                     "VhdGVJZGVudGl0eSIsIm5ldCI6IjB4MzAzOSIsImFjdCI6ImRldmljZWtleSIsImV4cCI6MTUyM" +
                                     "jU0MDgwMCwidHlwZSI6InNoYXJlUmVxIn0.EkqNUyrZhcDbTQl73XpL2tp470lCo2saMXzuOZ91" +
                                     "UI2y-XzpcBMzhhSeUORnoJXJhHnkGGpshZlESWUgrbuiVQ"
        self.payloadLabel.text = nil
    }

    @IBAction func resolveAction(button: UIButton)
    {
        guard let jwt = incomingJwtLabel.text else
        {
            return
        }

        button.isEnabled = false
        button.alpha = 0.333
        activityIndicator.startAnimating()
        payloadLabel.text = nil

        JWTTools.dateProvider = DateProvider(date: Date(timeIntervalSince1970: 1522540300))
        JWTTools.verify(jwt: jwt)
        { (payload, error) in
            button.isEnabled = true
            button.alpha = 1
            self.activityIndicator.stopAnimating()

            if error == nil
            {
                self.payloadLabel.text = "ISS: " + (payload?.iss ?? "")
            }
            else
            {
                self.payloadLabel.text = error?.localizedDescription
            }
        }
    }
}
