//
//  EthDIDResolverViewController.swift
//  uPortDemo
//
//  Created by Cornelis van der Bent on 31/01/2019.
//  Copyright © 2019 ConsenSys. All rights reserved.
//

import UIKit
import UPort

class EthDIDResolverViewController: UIViewController
{
    @IBOutlet var didLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resolveButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    required init()
    {
        super.init(nibName: "EthDIDResolverViewController", bundle: nil)
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

        self.didLabel.text = "0xb9c5714089478a327f09197987f16f9e5d936e8b" // Not a DID according to W3C spec.

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
        self.activityIndicator.startAnimating()
        self.resultLabel.text = nil

        resolveAsync(did: did)
        { (document, error) in
            button.isEnabled = true
            button.alpha = 1
            self.activityIndicator.stopAnimating()

            if error == nil
            {
                self.resultLabel.text = "ID: \(document!.publicKey[0].id)"
            }
            else
            {
                self.resultLabel.text = error?.localizedDescription
            }
        }
    }

    /// Encapsulates the synchronous Ethereum resolver function to make it asynchronous.
    public func resolveAsync(did: String,
                             completionHandler: @escaping (_ document: DIDDocument?, _ error: Error?) -> Void)
    {
        DispatchQueue.global(qos: .userInitiated).async
        {
            do
            {
                let ethrResolver = EthrDIDResolver(rpc: JsonRPC(rpcURL: Networks.shared.rinkeby.rpcUrl))
                let document = try ethrResolver.resolveSync(did: did)
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
