//
//  JMPairingVC.swift
//  MEMESample
//
//  Created by Shoya Ishimaru on 2015/11/09.
//  Copyright © 2015年 shoya140. All rights reserved.
//

import UIKit
import SVProgressHUD

class JMPairingVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MEMELibDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var _peripheralsFound: Array<CBPeripheral> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MEMELib.sharedInstance().delegate = self
        MEMELib.sharedInstance().disconnectPeripheral()
        MEMELib.sharedInstance().addObserver(self, forKeyPath: "centralManagerEnabled", options: NSKeyValueObservingOptions.New, context: nil)
        MEMELib.sharedInstance().startScanningPeripherals()
        
        _peripheralsFound = []
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "centralManagerEnabled" {
            MEMELib.sharedInstance().startScanningPeripherals()
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _peripheralsFound.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = _peripheralsFound[indexPath.row].identifier.UUIDString
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MEMELib.sharedInstance().connectPeripheral(_peripheralsFound[indexPath.row])
        SVProgressHUD.showWithStatus("Connecting")
    }

    // MARK: - MEMELib delegate
    
    func memePeripheralFound(peripheral: CBPeripheral!) {
        NSLog("MEME Peripheral Found %@", peripheral.identifier.UUIDString)
        _peripheralsFound.append(peripheral)
        tableView.reloadData()
    }
    
    func memePeripheralConnected(peripheral: CBPeripheral!) {
        NSLog("MEME Device Connected %@", peripheral.identifier.UUIDString)
        SVProgressHUD.dismiss()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func memePeripheralDisconnected(peripheral: CBPeripheral!) {
        NSLog("MEME Device Disconnected")
    }

}
