//
//  MenuViewController.swift
//  uPortDemo
//
//  Created by Cornelis van der Bent on 31/01/2019.
//  Copyright © 2019 ConsenSys. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UITableViewController
{
    private var structure =
    [
        [
            "JSON Web Tokens" :
            [
                [ "JWT Verification" : JWTVerificationViewController.self ]
            ]
        ],
        [
            "Resolving DIDs" :
            [
                [ "uPort DID Resolver" : UPortDIDResolverViewController.self ],
                [ "Eth DID Resolver" : EthDIDResolverViewController.self ],
                [ "Universal DID Resolver" : UniversalDIDResolverViewController.self ]
            ]
        ],
        [
            "Crypto" :
            [
                [ "Encrypt / Decrypt" : EncryptDecryptViewController.self ]
            ]
        ]
    ]

    required init()
    {
        super.init(style: .grouped)
        self.title = "Menu"
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

        if self.tableView.backgroundView == nil
        {
            self.tableView.backgroundView = UIView(frame: tableView.frame)
        }
        
        Styling.addLogoBackground(to: tableView.backgroundView!)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table Data Source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.structure.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.structure[section].values.first!.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return self.structure[section].keys.first
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "MenuCell"
        var cell: UITableViewCell!

        cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }

        let items = structure[indexPath.section].values.first!
        cell.textLabel?.text = items[indexPath.row].keys.first

        return cell
    }

    // MARK: - Table Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let items = structure[indexPath.section].values.first!
        let viewController = items[indexPath.row].values.first!.init()
        viewController.title = items[indexPath.row].keys.first

        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
