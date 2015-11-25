//
//  FileUploader.swift
//  ReadingLifeLog
//
//  Created by Shoya Ishimaru on 2015/08/02.
//  Copyright (c) 2015年 shoya140. All rights reserved.
//

import UIKit
import Parse

class FileUploader: NSObject {
    
    private var lastDate: NSDate?
    private var dateFormatter = NSDateFormatter()
    
    override init() {
        super.init()
        
        let lastSavedFileName = NSUserDefaults.standardUserDefaults().objectForKey("last_saved_file_name") as! String
        
        let lastDateString = (lastSavedFileName as NSString).substringToIndex(19)
        dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        lastDate = dateFormatter.dateFromString(lastDateString)!
    }
    
    func uploadFiles() {
        let path = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)[0]
        if let files = try? NSFileManager.defaultManager().contentsOfDirectoryAtPath(path) {
            for file in files {
                let fileName = file
                if fileName.characters.count < 19 {
                    continue
                }
                let date = dateFormatter.dateFromString((fileName as NSString).substringToIndex(19))
                if date?.timeIntervalSinceDate(lastDate!) > 0 {
                    upload(fileName)
                }
            }
        }
    }
    
    private func upload(fileName: String) {
        let path = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)[0]
        let data = NSData(contentsOfFile: path+"/"+fileName)
        
        let fileSize = data!.length
        var offset = 0
        while offset < fileSize {
            let chunkLength = min(fileSize - offset, 10*1024*1024)
            let d = data?.subdataWithRange(NSMakeRange(offset, chunkLength))
            print(d?.length)
            offset += (10*1024*1024)
            
            let fileName_ = fileName.stringByReplacingOccurrencesOfString("+", withString: "_", options: [], range: nil)
            let file = PFFile(name:fileName_, data:d!)
            
            let rawData = PFObject(className: "RawData")
            rawData["file"] = file
            rawData["UUID"] = NSUserDefaults.standardUserDefaults().objectForKey("MEME_UUID") as! String
            file?.saveInBackgroundWithBlock({
                (succeeded: Bool, error: NSError?) -> Void in
                rawData.saveInBackground()
                if offset >= fileSize {
                    let ud = NSUserDefaults.standardUserDefaults()
                    print("uploaded \(fileName)")
                    ud.setObject(fileName, forKey: "last_saved_file_name")
                }
                }, progressBlock: {
                    (percentDone: Int32) -> Void in
                    // TODO: update parameters
            })
        }
    }
    
}
