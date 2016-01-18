//
//  JMRealTimeDataVC.swift
//  MEMESample
//
//  Created by Shoya Ishimaru on 2015/11/10.
//  Copyright © 2015年 shoya140. All rights reserved.
//

import UIKit

class JMRealTimeDataVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MEMELibDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var numberOfValuesToBeDisplayed: UInt = 20 * 10
    private var blinkStrengths: [Double] = [0.0]
    private var blinkSpeeds: [Double] = [0.0]
    private var verticalEyeMovements: [Double] = [0.0]
    private var horizontalEyeMovements: [Double] = [0.0]
    private var accXValues: [Double] = [0.0]
    private var accYValues: [Double] = [0.0]
    private var accZValues: [Double] = [0.0]
    private var gyroRValues: [Double] = [0.0]
    private var gyroPValues: [Double] = [0.0]
    private var gyroYValues: [Double] = [0.0]
    private var isWalkings: [Double] = [0.0]
    private var fitErrors: [Double] = [0.0]
    private var powerLefts: [Double] = [0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        MEMELib.sharedInstance().delegate = self
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        case 2:
            return 6
        case 3:
            return 3
        default:
            break
        }
        return 14
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 100
        } else {
            return 160
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Blink Detection"
        case 1:
            return "Eye Movement"
        case 2:
            return "Head Movement"
        case 3:
            return "Utility"
        default:
            return ""
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("EyeCell", forIndexPath: indexPath)
                let eyeView = (cell.viewWithTag(1) as! EyeView)
                if blinkStrengths.last! > 0 {
                    eyeView.eyeOpened = false
                } else {
                    eyeView.eyeOpened = true
                }
                eyeView.setNeedsDisplay()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Blink Strength"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", blinkStrengths.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 200
                (cell.viewWithTag(3) as! GraphView).minimumValue = 0
                (cell.viewWithTag(3) as! GraphView).values = blinkStrengths
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Blink Speed"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", blinkSpeeds.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 200
                (cell.viewWithTag(3) as! GraphView).minimumValue = 0
                (cell.viewWithTag(3) as! GraphView).values = blinkSpeeds
                return cell
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Vertical Eye Movement"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", verticalEyeMovements.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 3
                (cell.viewWithTag(3) as! GraphView).minimumValue = -3
                (cell.viewWithTag(3) as! GraphView).values = verticalEyeMovements
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Horizonal Eye Movement"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", horizontalEyeMovements.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 3
                (cell.viewWithTag(3) as! GraphView).minimumValue = -3
                (cell.viewWithTag(3) as! GraphView).values = horizontalEyeMovements
                return cell
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Acceleration X"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", accXValues.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 50
                (cell.viewWithTag(3) as! GraphView).minimumValue = -50
                (cell.viewWithTag(3) as! GraphView).values = accXValues
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Acceleration Y"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", accYValues.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 50
                (cell.viewWithTag(3) as! GraphView).minimumValue = -50
                (cell.viewWithTag(3) as! GraphView).values = accYValues
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Acceleration Z"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", accZValues.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 50
                (cell.viewWithTag(3) as! GraphView).minimumValue = -50
                (cell.viewWithTag(3) as! GraphView).values = accZValues
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Rotation Roll"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", gyroRValues.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 90
                (cell.viewWithTag(3) as! GraphView).minimumValue = -90
                (cell.viewWithTag(3) as! GraphView).values = gyroRValues
                return cell
            case 4:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Rotation Pitch"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", gyroPValues.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 180
                (cell.viewWithTag(3) as! GraphView).minimumValue = -180
                (cell.viewWithTag(3) as! GraphView).values = gyroPValues
                return cell
            case 5:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Rotation Yaw"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", gyroYValues.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 360
                (cell.viewWithTag(3) as! GraphView).minimumValue = 0
                (cell.viewWithTag(3) as! GraphView).values = gyroYValues
                return cell
            default:
                break
            }
        case 3:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Walking Detection"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", isWalkings.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 4
                (cell.viewWithTag(3) as! GraphView).minimumValue = 0
                (cell.viewWithTag(3) as! GraphView).values = isWalkings
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Fit Error"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", fitErrors.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 4
                (cell.viewWithTag(3) as! GraphView).minimumValue = 0
                (cell.viewWithTag(3) as! GraphView).values = fitErrors
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = "Power Left"
                (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", powerLefts.last!)
                (cell.viewWithTag(3) as! GraphView).maximumValue = 5
                (cell.viewWithTag(3) as! GraphView).minimumValue = 1
                (cell.viewWithTag(3) as! GraphView).values = powerLefts
                return cell
            default:
                break
            }
        default:
            break
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        return cell
    }
    
    // MARK: - MEMELib delegate
    
    func memeRealTimeModeDataReceived(data: MEMERealTimeData!) {
        if FileWriter.sharedWriter.isRecording{
            FileWriter.sharedWriter.writeData(data)
        }
        
        blinkStrengths.append(Double(data.blinkStrength))
        if blinkStrengths.count > Int(self.numberOfValuesToBeDisplayed) {
            blinkStrengths.removeRange(Range<Int>(
                start: 0,
                end: blinkStrengths.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        blinkSpeeds.append(Double(data.blinkSpeed))
        if blinkSpeeds.count > Int(self.numberOfValuesToBeDisplayed) {
            blinkSpeeds.removeRange(Range<Int>(
                start: 0,
                end: blinkSpeeds.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        verticalEyeMovements.append(Double(data.eyeMoveUp) - Double(data.eyeMoveDown))
        if verticalEyeMovements.count > Int(self.numberOfValuesToBeDisplayed) {
            verticalEyeMovements.removeRange(Range<Int>(
                start: 0,
                end: verticalEyeMovements.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        horizontalEyeMovements.append(Double(data.eyeMoveLeft) - Double(data.eyeMoveRight))
        if horizontalEyeMovements.count > Int(self.numberOfValuesToBeDisplayed) {
            horizontalEyeMovements.removeRange(Range<Int>(
                start: 0,
                end: horizontalEyeMovements.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        accXValues.append(Double(data.accX))
        if accXValues.count > Int(self.numberOfValuesToBeDisplayed) {
            accXValues.removeRange(Range<Int>(
                start: 0,
                end: accXValues.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        accYValues.append(Double(data.accY))
        if accYValues.count > Int(self.numberOfValuesToBeDisplayed) {
            accYValues.removeRange(Range<Int>(
                start: 0,
                end: accYValues.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        accZValues.append(Double(data.accZ))
        if accZValues.count > Int(self.numberOfValuesToBeDisplayed) {
            accZValues.removeRange(Range<Int>(
                start: 0,
                end: accZValues.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        gyroRValues.append(Double(data.roll))
        if gyroRValues.count > Int(self.numberOfValuesToBeDisplayed) {
            gyroRValues.removeRange(Range<Int>(
                start: 0,
                end: gyroRValues.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        gyroPValues.append(Double(data.pitch))
        if gyroPValues.count > Int(self.numberOfValuesToBeDisplayed) {
            gyroPValues.removeRange(Range<Int>(
                start: 0,
                end: gyroPValues.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        gyroYValues.append(Double(data.yaw))
        if gyroYValues.count > Int(self.numberOfValuesToBeDisplayed) {
            gyroYValues.removeRange(Range<Int>(
                start: 0,
                end: gyroYValues.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        isWalkings.append(Double(data.isWalking))
        if isWalkings.count > Int(self.numberOfValuesToBeDisplayed) {
            isWalkings.removeRange(Range<Int>(
                start: 0,
                end: isWalkings.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        fitErrors.append(Double(data.fitError))
        if fitErrors.count > Int(self.numberOfValuesToBeDisplayed) {
            fitErrors.removeRange(Range<Int>(
                start: 0,
                end: fitErrors.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        powerLefts.append(Double(data.powerLeft))
        if powerLefts.count > Int(self.numberOfValuesToBeDisplayed) {
            powerLefts.removeRange(Range<Int>(
                start: 0,
                end: powerLefts.count - Int(numberOfValuesToBeDisplayed)
                ))
        }
        
        self.tableView.reloadData()
    }
    
}
