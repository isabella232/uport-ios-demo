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
            "JWT" :
            [
                [ "Verification" : JWTVerificationViewController.self ]
            ]
        ],
        [
            "DID Resolving" :
            [
                [ "uPort DID Resolver" : UPortDIDResolverViewController.self ],
                [ "Eth DID Resolver" : EthDIDResolverViewController.self ],
                [ "Universal DID Resolver" : UniversalDIDResolverViewController.self ]
            ]
        ]
    ]

    required init()
    {
        super.init(style: .grouped)
        self.title = "uPort Demo Menu"
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table Data Source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return structure.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return structure[section].values.first!.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return structure[section].keys.first
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

        navigationController?.pushViewController(viewController, animated: true)
    }
}
