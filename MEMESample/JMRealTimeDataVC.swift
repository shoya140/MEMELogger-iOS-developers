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
    
    private var _numberOfValuesToBeDisplayed: UInt = 20 * 10
    private var _blinkStrengths: [Double] = [0.0]
    private var _blinkSpeeds: [Double] = [0.0]
    private var _verticalEyeMovements: [Double] = [0.0]
    private var _horizontalEyeMovements: [Double] = [0.0]
    private var _accXValues: [Double] = [0.0]
    private var _accYValues: [Double] = [0.0]
    private var _accZValues: [Double] = [0.0]
    private var _gyroRValues: [Double] = [0.0]
    private var _gyroPValues: [Double] = [0.0]
    private var _gyroYValues: [Double] = [0.0]
    private var _isWalkings: [Double] = [0.0]
    private var _fitErrors: [Double] = [0.0]
    private var _powerLefts: [Double] = [0.0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        MEMELib.sharedInstance().delegate = self
        MEMELib.sharedInstance().changeDataMode(MEME_COM_REALTIME)
    }

    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 160
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("EyeCell", forIndexPath: indexPath)
            let eyeView = (cell.viewWithTag(1) as! EyeView)
            if _blinkStrengths.last! > 0 {
                eyeView.eyeOpened = false
            } else {
                eyeView.eyeOpened = true
            }
            eyeView.setNeedsDisplay()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Blink Strength"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", _blinkStrengths.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 200
            (cell.viewWithTag(3) as! GraphView).minimumValue = 0
            (cell.viewWithTag(3) as! GraphView).values = _blinkStrengths
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Blink Speed"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", _blinkSpeeds.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 200
            (cell.viewWithTag(3) as! GraphView).minimumValue = 0
            (cell.viewWithTag(3) as! GraphView).values = _blinkSpeeds
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Vertical Eye Movement"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", _verticalEyeMovements.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 10
            (cell.viewWithTag(3) as! GraphView).minimumValue = -10
            (cell.viewWithTag(3) as! GraphView).values = _verticalEyeMovements
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Horizonal Eye Movement"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", _horizontalEyeMovements.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 10
            (cell.viewWithTag(3) as! GraphView).minimumValue = -10
            (cell.viewWithTag(3) as! GraphView).values = _horizontalEyeMovements
            return cell
        case 5:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Acceleration X"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", _accXValues.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 50
            (cell.viewWithTag(3) as! GraphView).minimumValue = -50
            (cell.viewWithTag(3) as! GraphView).values = _accXValues
            return cell
        case 6:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Acceleration Y"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", _accYValues.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 50
            (cell.viewWithTag(3) as! GraphView).minimumValue = -50
            (cell.viewWithTag(3) as! GraphView).values = _accYValues
            return cell
        case 7:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Acceleration Z"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", _accZValues.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 50
            (cell.viewWithTag(3) as! GraphView).minimumValue = -50
            (cell.viewWithTag(3) as! GraphView).values = _accZValues
            return cell
        case 8:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Gyro Roll"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", _gyroRValues.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 90
            (cell.viewWithTag(3) as! GraphView).minimumValue = -90
            (cell.viewWithTag(3) as! GraphView).values = _gyroRValues
            return cell
        case 9:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Gyro Pitch"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", _gyroPValues.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 180
            (cell.viewWithTag(3) as! GraphView).minimumValue = -180
            (cell.viewWithTag(3) as! GraphView).values = _gyroPValues
            return cell
        case 10:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Gyro Yaw"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.2f", _gyroYValues.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 360
            (cell.viewWithTag(3) as! GraphView).minimumValue = 0
            (cell.viewWithTag(3) as! GraphView).values = _gyroYValues
            return cell
        case 11:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Walking Detection"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", _isWalkings.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 2
            (cell.viewWithTag(3) as! GraphView).minimumValue = -2
            (cell.viewWithTag(3) as! GraphView).values = _isWalkings
            return cell
        case 12:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Fit Error"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", _fitErrors.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 4
            (cell.viewWithTag(3) as! GraphView).minimumValue = 0
            (cell.viewWithTag(3) as! GraphView).values = _fitErrors
            return cell
        case 13:
            let cell = tableView.dequeueReusableCellWithIdentifier("GraphCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UILabel).text = "Power Left"
            (cell.viewWithTag(2) as! UILabel).text = String(format: "%.0f", _powerLefts.last!)
            (cell.viewWithTag(3) as! GraphView).maximumValue = 5
            (cell.viewWithTag(3) as! GraphView).minimumValue = 1
            (cell.viewWithTag(3) as! GraphView).values = _powerLefts
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            return cell
        }
    }
    
    // MARK: - MEMELib delegate
    
    func memeRealTimeModeDataReceived(data: MEMERealTimeData!) {
        _blinkStrengths.append(Double(data.blinkStrength))
        if _blinkStrengths.count > Int(self._numberOfValuesToBeDisplayed) {
            _blinkStrengths.removeRange(Range<Int>(
                start: 0,
                end: _blinkStrengths.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _blinkSpeeds.append(Double(data.blinkSpeed))
        if _blinkSpeeds.count > Int(self._numberOfValuesToBeDisplayed) {
            _blinkSpeeds.removeRange(Range<Int>(
                start: 0,
                end: _blinkSpeeds.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _verticalEyeMovements.append(Double(data.eyeMoveUp) - Double(data.eyeMoveDown))
        if _verticalEyeMovements.count > Int(self._numberOfValuesToBeDisplayed) {
            _verticalEyeMovements.removeRange(Range<Int>(
                start: 0,
                end: _verticalEyeMovements.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _horizontalEyeMovements.append(Double(data.eyeMoveLeft) - Double(data.eyeMoveRight))
        if _horizontalEyeMovements.count > Int(self._numberOfValuesToBeDisplayed) {
            _horizontalEyeMovements.removeRange(Range<Int>(
                start: 0,
                end: _horizontalEyeMovements.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _accXValues.append(Double(data.accX))
        if _accXValues.count > Int(self._numberOfValuesToBeDisplayed) {
            _accXValues.removeRange(Range<Int>(
                start: 0,
                end: _accXValues.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _accYValues.append(Double(data.accY))
        if _accYValues.count > Int(self._numberOfValuesToBeDisplayed) {
            _accYValues.removeRange(Range<Int>(
                start: 0,
                end: _accYValues.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _accZValues.append(Double(data.accZ))
        if _accZValues.count > Int(self._numberOfValuesToBeDisplayed) {
            _accZValues.removeRange(Range<Int>(
                start: 0,
                end: _accZValues.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _gyroRValues.append(Double(data.roll))
        if _gyroRValues.count > Int(self._numberOfValuesToBeDisplayed) {
            _gyroRValues.removeRange(Range<Int>(
                start: 0,
                end: _gyroRValues.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _gyroPValues.append(Double(data.pitch))
        if _gyroPValues.count > Int(self._numberOfValuesToBeDisplayed) {
            _gyroPValues.removeRange(Range<Int>(
                start: 0,
                end: _gyroPValues.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
            
        _gyroYValues.append(Double(data.yaw))
        if _gyroYValues.count > Int(self._numberOfValuesToBeDisplayed) {
            _gyroYValues.removeRange(Range<Int>(
                start: 0,
                end: _gyroYValues.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _isWalkings.append(Double(data.isWalking))
        if _isWalkings.count > Int(self._numberOfValuesToBeDisplayed) {
            _isWalkings.removeRange(Range<Int>(
                start: 0,
                end: _isWalkings.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _fitErrors.append(Double(data.fitError))
        if _fitErrors.count > Int(self._numberOfValuesToBeDisplayed) {
            _fitErrors.removeRange(Range<Int>(
                start: 0,
                end: _fitErrors.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        _powerLefts.append(Double(data.powerLeft))
        if _powerLefts.count > Int(self._numberOfValuesToBeDisplayed) {
            _powerLefts.removeRange(Range<Int>(
                start: 0,
                end: _powerLefts.count - Int(_numberOfValuesToBeDisplayed)
                ))
        }
        
        self.tableView.reloadData()
    }
    
}
