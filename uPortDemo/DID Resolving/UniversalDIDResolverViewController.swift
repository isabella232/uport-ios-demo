//
//  UniversalDIDResolverViewController.swift
//  uPortDemo
//
//  Created by Cornelis van der Bent on 31/01/2019.
//  Copyright © 2019 ConsenSys. All rights reserved.
//

import UIKit
import UPort

class UniversalDIDResolverViewController: UIViewController
{
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var didLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resolveButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var resolver: UniversalDIDResolver

    required init()
    {
        self.resolver = UniversalDIDResolver()
        try? self.resolver.register(resolver: UPortDIDResolver())
        try? self.resolver.register(resolver: EthrDIDResolver(rpc: JsonRPC(rpcURL: Networks.shared.rinkeby.rpcUrl)))

        super.init(nibName: "UniversalDIDResolverViewController", bundle: nil)
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
        self.segmentedControl.tintColor = Styling.uPortPurple

        self.changeDidAction(segmentedControl: self.segmentedControl)
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

        self.resolver.resolveAsync(did: did)
        { (document, error) in
            button.isEnabled = true
            button.alpha = 1
            self.activityIndicator.stopAnimating()

            if error == nil
            {
                self.resultLabel.text = document!.publicKey[0].publicKeyHex ?? document!.publicKey[0].id
            }
            else
            {
                self.resultLabel.text = error?.localizedDescription
            }
        }
    }

    @IBAction func changeDidAction(segmentedControl: UISegmentedControl)
    {
        self.resultLabel.text = nil

        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            self.didLabel.text = "2ozs2ntCXceKkAQKX4c9xp2zPS8pvkJhVqC"
            self.resolveButton.setTitle("Resolve uPort ID", for: .normal)

        case 1:
            self.didLabel.text = "did:uport:2ozs2ntCXceKkAQKX4c9xp2zPS8pvkJhVqC"
            self.resolveButton.setTitle("Resolve uPort DID", for: .normal)

        case 2:
            self.didLabel.text = "0xb9c5714089478a327f09197987f16f9e5d936e8a"
            self.resolveButton.setTitle("Resolve Ethereum ID", for: .normal)

        case 3:
            self.didLabel.text = "did:ethr:0xb9c5714089478a327f09197987f16f9e5d936e8a"
            self.resolveButton.setTitle("Resolve Ethereum DID", for: .normal)

        default:
            fatalError()
        }
    }
}
