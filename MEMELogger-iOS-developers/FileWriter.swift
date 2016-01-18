//
//  FileWriter.swift
//  MEMELogger
//
//  Created by Shoya Ishimaru on 2015/07/29.
//  Copyright (c) 2015年 Katsuma Tanaka. All rights reserved.
//

import UIKit

class FileWriter: NSObject {
    
    static let sharedWriter = FileWriter()
    var isRecording = false
    var eventLabel:Int = 0
    var segmentLabel:Int = 0
    
    private var fileHandle: NSFileHandle?
    private var dateFormatter: NSDateFormatter!
    private let kISO8601Format: String = "yyyy-MM-dd_HH-mm-ss"
    
    override init() {
        super.init()
        
        // create date formatter
        dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = kISO8601Format
    }
    
    func startRecording() {
        self.isRecording = true
        
        // create file prefix
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        let currentFilePrefix = dateFormatter.stringFromDate(NSDate())
        
        // initialize EOG File
        let filePath = documentDirectory + "/" + currentFilePrefix + ".csv"
        let text = "date,epoch_time,blink_speed,blink_strength,eye_move_up,eye_move_down,eye_move_left,eye_move_right,acc_x,acc_y,acc_z,roll,pitch,yaw,is_walking,fit_error,power_left,event,segment,app_state\n"
        do {
            try text.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch _ {
        }
        fileHandle = NSFileHandle(forWritingAtPath: filePath)
        fileHandle?.seekToEndOfFile()
        
    }
    
    func stopRecording() {
        fileHandle?.closeFile()
        fileHandle = nil
        self.isRecording = false
    }
    
    func writeData(data: MEMERealTimeData) {
        if !self.isRecording {
            return
        }
        
        let date = NSDate()
        let dateString = dateFormatter.stringFromDate(date)
        let epochTime = date.timeIntervalSince1970
        let applicationState = UIApplication.sharedApplication().applicationState.rawValue
        
        if let handle = fileHandle {
            let text = NSString(format: "%@,%10.5f,%d,%d,%d,%d,%d,%d,%d,%d,%d,%f,%f,%f,%d,%d,%d,%d,%d,%d\n",
                dateString,
                epochTime,
                data.blinkSpeed,
                data.blinkStrength,
                data.eyeMoveUp,
                data.eyeMoveDown,
                data.eyeMoveLeft,
                data.eyeMoveRight,
                data.accX,
                data.accY,
                data.accZ,
                data.roll,
                data.pitch,
                data.yaw,
                data.isWalking,
                data.fitError,
                data.powerLeft,
                self.eventLabel,
                self.segmentLabel,
                applicationState
            )
            if let d = text.dataUsingEncoding(NSUTF8StringEncoding) {
                handle.writeData(d)
            }
        }
        self.eventLabel = 0
    }
    
}
