//
//  JMStandardDataVC.swift
//  MEMESample
//
//  Created by Shoya Ishimaru on 2015/11/10.
//  Copyright © 2015年 shoya140. All rights reserved.
//

import UIKit

class JMStandardDataVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MEMELibDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var _lastData: MEMEStandardData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        MEMELib.sharedInstance().delegate = self
        MEMELib.sharedInstance().changeDataMode(MEME_COM_STANDARD)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 9
        case 2:
            return 31
        case 3:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Summary"
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if _lastData == nil {
            return cell
        }
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Sleepy"
                cell.detailTextLabel?.text = String(format:"%d", _lastData!.sleepy.rawValue)
            case 1:
                cell.textLabel?.text = "Focus"
                cell.detailTextLabel?.text = String(format:"%d", _lastData!.focus.rawValue)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Blink count"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numBlinks)
            case 1:
                cell.textLabel?.text = "Bursted blink count"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numBlinksBurst)
            case 2:
                cell.textLabel?.text = "Blink speed"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.blinkSpeed)
            case 3:
                cell.textLabel?.text = "Blink strength"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.blinkStrength)
            case 4:
                cell.textLabel?.text = "Blink interval"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.blinkIntervalAvg)
            case 5:
                cell.textLabel?.text = "Vertical eye movement (large)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.eyeMoveBigVertical)
            case 6:
                cell.textLabel?.text = "Vertical eye movement (small)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.eyeMoveVertical)
            case 7:
                cell.textLabel?.text = "Horizontal eye movement (large)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.eyeMoveBigHorizontal)
            case 8:
                cell.textLabel?.text = "Vertical eye movement (small)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.eyeMoveHorizontal)
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Average of roll"
                cell.detailTextLabel?.text = String(format:"%.2f",_lastData!.rollAvg)
            case 1:
                cell.textLabel?.text = "Diff of roll"
                cell.detailTextLabel?.text = String(format:"%.2f",_lastData!.rollDiff)
            case 2:
                cell.textLabel?.text = "Average of pitch"
                cell.detailTextLabel?.text = String(format:"%.2f",_lastData!.pitchAvg)
            case 3:
                cell.textLabel?.text = "Diff of putch"
                cell.detailTextLabel?.text = String(format:"%.2f",_lastData!.pitchDiff)
            case 4:
                cell.textLabel?.text = "Foot hold left"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.footholdLeft)
            case 5:
                cell.textLabel?.text = "Foot hold right"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.footholdRight)
            case 6:
                cell.textLabel?.text = "Sitting posture indices"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.sittingPostureIndices)
            case 7:
                cell.textLabel?.text = "Step count (all)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps)
            case 8:
                cell.textLabel?.text = "Step count (280)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps280)
            case 9:
                cell.textLabel?.text = "Step count (310)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps310)
            case 10:
                cell.textLabel?.text = "Step count (340)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps340)
            case 11:
                cell.textLabel?.text = "Step count (370)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps370)
            case 12:
                cell.textLabel?.text = "Step count (400)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps400)
            case 13:
                cell.textLabel?.text = "Step count (430)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps430)
            case 14:
                cell.textLabel?.text = "Step count (460)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps460)
            case 15:
                cell.textLabel?.text = "Step count (500)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps500)
            case 16:
                cell.textLabel?.text = "Step count (530)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps530)
            case 17:
                cell.textLabel?.text = "Step count (560)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps560)
            case 18:
                cell.textLabel?.text = "Step count (590)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps590)
            case 19:
                cell.textLabel?.text = "Step count (620)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps620)
            case 20:
                cell.textLabel?.text = "Step count (650)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps650)
            case 21:
                cell.textLabel?.text = "Step count (680)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps680)
            case 22:
                cell.textLabel?.text = "Step count (710)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps710)
            case 23:
                cell.textLabel?.text = "Step count (750)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps750)
            case 24:
                cell.textLabel?.text = "Step count (780)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps780)
            case 25:
                cell.textLabel?.text = "Step count (810)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps810)
            case 26:
                cell.textLabel?.text = "Step count (840)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps840)
            case 27:
                cell.textLabel?.text = "Step count (900)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps900)
            case 28:
                cell.textLabel?.text = "Step count (930)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps930)
            case 29:
                cell.textLabel?.text = "Step count (960)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps960)
            case 30:
                cell.textLabel?.text = "Step count (1000)"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.numSteps1000)
            default:
                break
            }
        case 3:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "EOG noise duration"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.EOGNoiseDuration)
            case 1:
                cell.textLabel?.text = "Power left"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.powerLeft)
            case 2:
                cell.textLabel?.text = "Fit error"
                cell.detailTextLabel?.text = String(format:"%d",_lastData!.fitError)
            default:
                break
            }
        default:
            break
        }

        return cell
    }
    
    // MARK: - MEMELib delegate
    
    func memeStandardModeDataReceived(data: MEMEStandardData!) {
        NSLog("%@", data.description)
        _lastData = data
        tableView.reloadData()
    }

}
