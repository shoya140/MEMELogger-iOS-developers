//
//  JMStandardDataVC.swift
//  MEMESample
//
//  Created by Shoya Ishimaru on 2015/11/10.
//  Copyright © 2015年 shoya140. All rights reserved.
//

import UIKit

class JMStandardDataVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MEMELibDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        MEMELib.sharedInstance().delegate = self
        MEMELib.sharedInstance().changeDataMode(MEME_COM_STANDARD)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        return cell
    }
    
    // MARK: - MEMELib delegate
    
    func memeStandardModeDataReceived(data: MEMEStandardData!) {
        NSLog("%@", data)
    }

}
