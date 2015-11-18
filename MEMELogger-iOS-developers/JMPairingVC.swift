//
//  JMParingVC.swift
//  MEMESample
//
//  Created by Shoya Ishimaru on 2015/11/09.
//  Copyright © 2015年 shoya140. All rights reserved.
//

import UIKit

class JMPairingVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MEMELibDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var _peripheralsFound: Array<CBPeripheral> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _peripheralsFound = []
        tableView.dataSource = self
        tableView.delegate = self

        MEMELib.sharedInstance().delegate = self
        checkMEMEStatus(MEMELib.sharedInstance().startScanningPeripherals())
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Utility
    
    func checkMEMEStatus(status: MEMEStatus) {
        if status == MEME_ERROR_APP_AUTH {
            UIAlertView(title: "App Auth Failed", message: "Invalid Application ID or Client Secret", delegate: nil, cancelButtonTitle: "OK").show()
        } else if status == MEME_ERROR_SDK_AUTH {
            UIAlertView(title: "SDK Auth Failed", message: "Invalid SDK. Please update to the latest SDK.", delegate: nil, cancelButtonTitle: "OK").show()
        } else if status == MEME_ERROR_SDK_AUTH {
            UIAlertView(title: "SDK_ERROR", message: "Invalid Command", delegate: nil, cancelButtonTitle: "OK").show()
        } else if status == MEME_ERROR_SDK_AUTH {
            UIAlertView(title: "Error", message: "Bluetooth is off.", delegate: nil, cancelButtonTitle: "OK").show()
        } else {
            NSLog("Status: MEME_OK")
        }
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
    
    func memePeripheralFound(peripheral: CBPeripheral!, withDeviceAddress address: String!) {
        NSLog("found")
        for p in _peripheralsFound {
            if p.identifier.isEqual(peripheral.identifier){
                return
            }
        }
        
        NSLog("MEME Peripheral Found %@", peripheral.identifier.UUIDString)
        _peripheralsFound.append(peripheral)
        tableView.reloadData()
    }
    
    func memePeripheralConnected(peripheral: CBPeripheral!) {
        NSLog("MEME Device Connected %@", peripheral.identifier.UUIDString)
        MEMELib.sharedInstance().startDataReport()
        
        SVProgressHUD.dismiss()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func memePeripheralDisconnected(peripheral: CBPeripheral!) {
        NSLog("MEME Device Disconnected")
    }
    
    func memeAppAuthorized(status: MEMEStatus) {
        checkMEMEStatus(status)
    }
    
    func memeCommandResponse(response: MEMEResponse) {
        NSLog("Command Response - eventCode: 0x%02x - commandResult: %d", response.eventCode, response.commandResult.boolValue);
        switch response.eventCode {
        case 0x02:
            NSLog("Data Report Started")
        case 0x04:
            NSLog("Data Report Stopped");
        default:
            break
        }
    }

}
