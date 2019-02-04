//
//  UPortDIDResolverViewController.swift
//  uPortDemo
//
//  Created by Cornelis van der Bent on 31/01/2019.
//  Copyright © 2019 ConsenSys. All rights reserved.
//

import UIKit
import UPort

class UPortDIDResolverViewController: UIViewController
{
    @IBOutlet var didLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resolveButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    required init()
    {
        super.init(nibName: "UPortDIDResolverViewController", bundle: nil)
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

        Styling.styleButton(self.resolveButton)

        self.didLabel.text = "did:uport:2ozs2ntCXceKkAQKX4c9xp2zPS8pvkJhVqC"
        self.resultLabel.text = nil
    }

    @IBAction func resolveAction(button: UIButton)
    {
        guard let did = didLabel.text else
        {
            return
        }

        button.isEnabled = false
        button.alpha = 0.333
        activityIndicator.startAnimating()
        resultLabel.text = nil

        resolveAsync(did: did)
        { (document, error) in
            button.isEnabled = true
            button.alpha = 1
            self.activityIndicator.stopAnimating()

            if error == nil
            {
                self.resultLabel.text = "Public Key: \(document!.publicKey[0].publicKeyHex!)"
            }
            else
            {
                self.resultLabel.text = error?.localizedDescription
            }
        }
    }

    /// Encapsulates the synchronous uPort resolver function to make it asynchronous.
    public func resolveAsync(did: String,
                             completionHandler: @escaping (_ document: DIDDocument?, _ error: Error?) -> Void)
    {
        DispatchQueue.global(qos: .userInitiated).async
        {
            do
            {
                let document = try UPortDIDResolver().resolveSync(did: did)
                DispatchQueue.main.async
                {
                    completionHandler(document, nil)
                }
            }
            catch
            {
                DispatchQueue.main.async
                {
                    completionHandler(nil, error)
                }
            }
        }
    }
}
