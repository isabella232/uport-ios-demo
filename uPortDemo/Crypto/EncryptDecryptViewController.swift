//
//  EncryptDecryptViewController.swift
//  uPortDemo
//
//  Created by Cornelis van der Bent on 05/02/2019.
//  Copyright © 2019 ConsenSys. All rights reserved.
//

import UIKit
import UPort

class EncryptDecryptViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var sourceTextField: UITextField!
    @IBOutlet var encryptButton: UIButton!
    @IBOutlet var encryptedLabel: UILabel!
    @IBOutlet var decryptButton: UIButton!
    @IBOutlet var targetLabel: UILabel!

    var encryptedMessage: Crypto.EncryptedMessage?

    required init()
    {
        super.init(nibName: "EncryptDecryptViewController", bundle: nil)
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

        self.sourceTextField.delegate = self

        Styling.styleButton(self.encryptButton)
        Styling.styleButton(self.decryptButton)

        self.sourceTextField.text = nil
        self.clear()
    }

    func clear()
    {
        self.encryptedLabel.text = nil
        self.targetLabel.text = nil
        self.decryptButton.isHidden = true

        self.encryptButton.isHidden = self.sourceTextField.text?.isEmpty ?? true
    }

    @IBAction func sourceTextChangedAction(textField: UITextField)
    {
        self.clear()
    }

    @IBAction func encryptAction(button: UIButton)
    {
        let boxPub = "oGZhZ0cvwgLKslgiPEQpBkRoE+CbWEdi738efvQBsH0="

        self.encryptedMessage = Crypto.encrypt(message: self.sourceTextField.text ?? "", boxPub: boxPub)
        self.encryptedLabel.text = try! String(data: (self.encryptedMessage?.toJson())!, encoding: .utf8)

        self.decryptButton.isHidden = false
        self.targetLabel.text = nil
    }

    @IBAction func decryptAction(button: UIButton)
    {
        let boxSecret = Array<UInt8>(base64: "Qgigj54O7CsQOhR5vLTfqSQyD3zmq/Gb8ukID7XvC3o=")

        self.targetLabel.isHidden = false
        self.targetLabel.text = Crypto.decrypt(encrypted: self.encryptedMessage!, secretKey: boxSecret)
    }

    // MARK: - Text Field Delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()

        return true
    }
}
