//
//  TodayViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
import StoreKit
import UserNotifications

class TodayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITabBarControllerDelegate {

    // MARK:- Setup basic variables
    @IBOutlet weak var sizingView: UIView!
    var viewCount = 0
    var isDisplayingFirstCell = true
    var selectedPerson = ""
    var selectionTag = 0
    
    // MARK:- Setup the arrays and dictionaries
    let babySizeImageArray = ["week0-3", "week4", "week5", "week6", "week7", "week8", "week9", "week10", "week11", "week12", "week13", "week14", "week15", "week16", "week17", "week18", "week19", "week20", "week21", "week22", "week23", "week24", "week25", "week26", "week27", "week28", "week29", "week30", "week31", "week32", "week33", "week34", "week35", "week36", "week37", "week38", "week39", "week40", "week41", "week42"]
    let babySizeLabelArray = ["still in beta", "the size of a grain of salt", "the size of a peppercorn", "the size of a snowflake", "the size of a peanut", "the size of a bee", "the size of an eyeball", "the size of a maki roll", "the size of a poker chip", "the size of a chicken nugget", "the size of a tennis ball", "the size of a deck of cards", "the size of a big mac", "the size of a can of coke", "the size of a pair of aviators", "the size of an iPhone 8", "the size of a dry martini", "the height of a beer bottle", "the length of a tube of pringles", "the size of a trowel", "the length of a sheet of A4", "the height of a bottle of wine", "the size of a hammer", "the size of a rack of ribs", "the weight of War and Peace", "the height of a PC tower", "the weight of a tomahawk steak", "the weight of a cricket bat", "the weight of an adult brain", "the weight of a roast chicken", "the size of a vinyl player", "the size of a dartboard", "the size of a small octopus", "the weight of a brick", "the height of a car tyre", "the weight of a six-pack", "the length of a wood saw", "the size of a trumpet"]
    let babySizeImageArray2 = ["week0-3", "week4", "week5", "week6", "week7", "week8", "week9", "week10", "week11", "week12", "week13", "week14", "week15", "week16", "week17", "week18", "week19", "week20", "week21", "week22", "week23", "week24", "week25", "week26", "week27", "week28", "week29", "week30", "week31", "week32", "week33", "week34", "week35", "week36", "week37", "week38", "week39", "week40", "week41", "week42"]
    let babySizeLabelArray2 = ["still in beta", "the size of a grain of salt", "the size of a peppercorn", "the size of a snowflake", "the size of a peanut", "the size of a bee", "the size of an eyeball", "the size of a maki roll", "the size of a poker chip", "the size of a chicken nugget", "the size of a tennis ball", "the size of a deck of cards", "the size of a big mac", "the size of a can of coke", "the size of a pair of aviators", "the size of an iPhone 8", "the size of a dry martini", "the height of a beer bottle", "the length of a tube of pringles", "the size of a trowel", "the length of a sheet of A4", "the height of a bottle of wine", "the size of a hammer", "the size of a rack of ribs", "the weight of War and Peace", "the height of a PC tower", "the weight of a tomahawk steak", "the weight of a cricket bat", "the weight of an adult brain", "the weight of a roast chicken", "the size of a vinyl player", "the size of a dartboard", "the size of a small octopus", "the weight of a brick", "the height of a car tyre", "the weight of a six-pack", "the length of a wood saw", "the size of a trumpet"]
    let weightArray = ["week1to3", "0.01g", "0.2g", "0.4g", "0.8g", "1g", "2g", "4g", "8g", "14g", "23g", "45g", "70g", "100g", "140g", "190g", "240g", "300g", "360g", "430g", "500g", "600g", "660g", "760g", "875g", "1kg", "1.1kg", "1.3kg", "1.5kg", "1.7kg", "1.9kg", "2.1kg", "2.4kg", "2.6kg", "2.9kg", "3.1kg", "3.3kg", "3.5kg", "3.5kg", "3.5kg"]
    let lengthArray = ["week1to3", "1mm", "2mm", "4mm", "8mm", "1.6cm", "2.3cm", "3.4cm", "4.1cm", "5.4cm", "7.4cm", "8.5cm", "10.1cm", "11.6cm", "12.9cm", "14.2cm", "15cm", "25.6cm", "26.6cm", "27.8cm", "29cm", "30cm", "34.6cm", "35.6cm", "36.6cm", "37.6cm", "38.6cm", "39.9cm", "41.1cm", "42.4cm", "43.7cm", "45cm", "46.2cm", "47.4cm", "48.6cm", "49.8cm", "50.6cm", "51.2cm", "51.2cm", "51.2cm"]
  
    // MARK: Setup for the tableview
    @IBOutlet weak var weeklyTableView: UITableView!
    var storedOffsets = [Int: CGFloat]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 38
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? WeekTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sizingView.frame.height
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? WeekTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    // MARK:- viewDidLoad and viewWillAppear
    override var prefersStatusBarHidden: Bool {
       return true
    }
 
    @IBAction func handleTap(recognizer:UITapGestureRecognizer) {
        
        print("tapped")
        //            let translation = recognizer.translation(in: self.view)
        //            if let view = recognizer.view {
        //                view.center = CGPoint(x:view.center.x + translation.x,
        //                                      y:view.center.y + translation.y)
        //            }
        //            recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        
        if let viewCount = UserDefaults.standard.object(forKey: "newViews") {
            
            let numberOfViews = viewCount as! Int
            if numberOfViews == 5 {
                if #available( iOS 10.3,*){
                    SKStoreReviewController.requestReview()
                } else {
                    print("ratings displayed more than 3 times")
                }
            }
             print("this is view number: \(numberOfViews)")
        }
        
       
       
  
        // This is the code to calculate the current week of pregnancy
        let fortyWeeksInDays = 280
        let startDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = fortyWeeksInDays
        let defaultDueDate = Calendar.current.date(byAdding: dateComponent, to: startDate)
        let endDate = UserDefaults.standard.object(forKey: "DueDate") as? Date ?? defaultDueDate
        let diff = endDate!.interval(ofComponent: .day, fromDate: startDate)
        
        let weeksLeft : Int = diff/7
        var weeksElapsed : Int = 39 - weeksLeft
        let remainderDays : Int = diff%7
        let remainderDaysElapsed : Int = 7 - remainderDays
        if remainderDaysElapsed == 7 {
            weeksElapsed += 1
        }
        
        print("this is the difference in days \(diff), this is the number of elapsed weeks: \(weeksElapsed) and remainder days \(remainderDays) and remainder days elapsed \(remainderDaysElapsed)")
        
        // END OF CODE
        
        let displayedWeeksElapsed = weeksElapsed - 3

        if weeksElapsed <= 40 && weeksElapsed >= 4 {
            let indexPath = IndexPath(row: displayedWeeksElapsed, section: 0)
            weeklyTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: false)
        } else if weeksElapsed <= 3 {
            let indexPath = IndexPath(row: 0, section: 0)
            weeklyTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: true)
        }
    }
    
    // MARK:- TabBar Controller setup

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        // This is the code to calculate the current week of pregnancy
        let fortyWeeksInDays = 280
        let startDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = fortyWeeksInDays
        let defaultDueDate = Calendar.current.date(byAdding: dateComponent, to: startDate)
        let endDate = UserDefaults.standard.object(forKey: "DueDate") as? Date ?? defaultDueDate
        let diff = endDate!.interval(ofComponent: .day, fromDate: startDate)
        
        let weeksLeft : Int = diff/7
        var weeksElapsed : Int = 39 - weeksLeft
        let remainderDays : Int = diff%7
        let remainderDaysElapsed : Int = 7 - remainderDays
        if remainderDaysElapsed == 7 {
            weeksElapsed += 1
        }
        
        print("this is the difference in days \(diff), this is the number of elapsed weeks: \(weeksElapsed) and remainder days \(remainderDays) and remainder days elapsed \(remainderDaysElapsed)")
        
        // END OF CODE
        
            if weeksElapsed >= 1 && weeksElapsed <= 40 {
                var displayedWeeksElapsed = weeksElapsed - 3
                if displayedWeeksElapsed == -1 {
                    displayedWeeksElapsed = displayedWeeksElapsed + 1
                } else if displayedWeeksElapsed == -2 {
                    displayedWeeksElapsed = displayedWeeksElapsed + 2
                } else if displayedWeeksElapsed == -3 {
                    displayedWeeksElapsed = displayedWeeksElapsed + 3
                }
                let indexPath = IndexPath(row: displayedWeeksElapsed, section: 0)
                weeklyTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
            }
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        print("view displayed")
     let center = UNUserNotificationCenter.current()
        
       
        
        let fortyWeeksInDays = 280
        let startDate = Date()
        var dateComponent = DateComponents()
            dateComponent.day = fortyWeeksInDays
        let defaultDueDate = Calendar.current.date(byAdding: dateComponent, to: startDate)
        let endDate = UserDefaults.standard.object(forKey: "DueDate") as? Date ?? defaultDueDate
        let diff = endDate!.interval(ofComponent: .day, fromDate: startDate)
        let weeksLeft : Int = diff/7
        var weeksElapsed : Int = 39 - weeksLeft
        let remainderDays : Int = diff%7
        let remainderDaysElapsed : Int = 7 - remainderDays
                if remainderDaysElapsed == 7 {
                    weeksElapsed += 1
                }

        print("this is the difference in days \(diff), this is the number of elapsed weeks: \(weeksElapsed) and remainder days \(remainderDays) and remainder days elapsed \(remainderDaysElapsed)")
   
        var displayedWeeksElapsed = weeksElapsed - 3
        if displayedWeeksElapsed == -1 {
            displayedWeeksElapsed = displayedWeeksElapsed + 1
        } else if displayedWeeksElapsed == -2 {
            displayedWeeksElapsed = displayedWeeksElapsed + 2
        } else if displayedWeeksElapsed == -3 {
            displayedWeeksElapsed = displayedWeeksElapsed + 3
        }

        if diff < 0 {
            print("minuses")
            weeksElapsed = 40
            displayedWeeksElapsed = 37
        }
        
        if weeksElapsed <= 40 && weeksElapsed >= 4 {
        let indexPath = IndexPath(row: displayedWeeksElapsed, section: 0)
   weeklyTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: false)
        } else if weeksElapsed <= 3 {
            let indexPath = IndexPath(row: 0, section: 0)
     weeklyTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: true)
        }
        
        // MARK: Setup local notifications
      
        let date = Date()
        var dateArray : [Date] = []
        var calculatedDaysRemaining = Calendar.current.dateComponents([.day], from: date, to: endDate!).day ?? 0
        print(calculatedDaysRemaining)
    
        var newDate = endDate
       
        while calculatedDaysRemaining >= 0 {
            let daysToSubtract = 7
            var dateComponent = DateComponents()
            dateComponent.day = -(daysToSubtract)
            let newDate2 = Calendar.current.date(byAdding: dateComponent, to: newDate!)
            dateArray.append(newDate2!)
            calculatedDaysRemaining = calculatedDaysRemaining - 7
            let newDate3 = newDate
            newDate = Calendar.current.date(byAdding: dateComponent, to: newDate3!)
        }
        print(dateArray)
        
        var arrayValue = 36
        var triggerID = "trigger"
        var triggerInt = 0
       
        for i in dateArray {
            
            let baby = UserDefaults.standard.string(forKey: "baby") ?? "Your baby"
            var dateComps = Calendar.current.dateComponents([.year, .month, .day], from: i)
            dateComps.hour = 10
            dateComps.minute = 00
         let notificationContent  = UNMutableNotificationContent()
            notificationContent.title = "\(baby) is growing"
            //while arrayValue <= 36 {
            notificationContent.body = "Your baby has levelled up and is now \(babySizeLabelArray[arrayValue])!"
           // }
         notificationContent.sound = UNNotificationSound.default
         triggerID = String("trigger\(triggerInt)")
            
        triggerInt = triggerInt + 1
         let trigger = UNCalendarNotificationTrigger(dateMatching: dateComps, repeats: false)
         let request = UNNotificationRequest(identifier: triggerID, content: notificationContent, trigger: trigger)
         UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            print("old array value: \(arrayValue)")
        
            
            arrayValue = arrayValue - 1
            if arrayValue < 0 {
                arrayValue = 0
            }
            
              print("new array value: \(arrayValue)")
            print(notificationContent.body)
            print("this is dateComps: \(dateComps)")
            print(triggerID)
        }
 
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                print("These are the pending requests post-deletion: \(request)")
            }
        })
    }
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.centerTable()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.centerTable()
        }
    }

    func centerTable() {
        let midX:CGFloat = self.weeklyTableView.bounds.midX
        let midY:CGFloat = self.weeklyTableView.bounds.midY
        let midPoint:CGPoint = CGPoint(x: midX, y: midY)

        if let pathForCenterCell:IndexPath = self.weeklyTableView .indexPathForRow(at: midPoint)
        {
            self.weeklyTableView.scrollToRow(at: pathForCenterCell, at: .middle, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension UITableView {

    func scrollToNearestVisibleTableViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.height / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.height
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToRow(at: IndexPath(row:closestCellIndex, section: 0), at: .middle, animated: true)
        }
    }
   
}

extension UICollectionView {
    
    func stopScrolling() {
        // self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            // self.scrollToRow(at: IndexPath(row:closestCellIndex, section: 0), at: .middle, animated: true)
        }
    }
}

extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.sizingView.frame.width
        let height = self.sizingView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func buttonFunction(sender: UIButton){
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        }
        if indexPath.item == 0 {
            // weeklyTableView.isScrollEnabled = true
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeekCollectionViewCell
            cell.babyImage.image = UIImage(named:babySizeImageArray[collectionView.tag])
            let babyLength = lengthArray[collectionView.tag]
            let babyWeight = weightArray[collectionView.tag]
            let sizeComparison = babySizeLabelArray[collectionView.tag]
                    if collectionView.tag != 0 {
                        cell.weeksElapsed.text = String(collectionView.tag + 3)
                        cell.babyHeight.text = babyLength
                        cell.babyWeight.text = babyWeight
                    } else {
                        cell.weeksElapsed.text = "0-3"
                        cell.babyHeight.text = "0cm"
                        cell.babyWeight.text = "0g"
                    }
            let baby = UserDefaults.standard.string(forKey: "baby") ?? "your baby"
                    if baby.isEmpty == true {
                        cell.babySize.text = "Your baby is \(sizeComparison)"
                    } else {
                        cell.babySize.text = "\(baby) is \(sizeComparison)"
                    }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! WeekCollectionViewCell2
            if collectionView.tag != 0 {
                let weekNumber = String(collectionView.tag + 3)
                cell.weekLabel.text = "WEEK \(weekNumber)"
            } else {
                let weekNumber = "0-3"
                cell.weekLabel.text = "WEEK \(weekNumber)"
            }
            
            
            if indexPath.item == 1 {
                let babyStart : String = UserDefaults.standard.string(forKey: "baby") ?? "Your baby"
                let baby : String = UserDefaults.standard.string(forKey: "baby") ?? "your baby"
                let mother : String  = UserDefaults.standard.string(forKey: "mother") ?? "Your partner"
                let motherMiddle : String = UserDefaults.standard.string(forKey: "mother") ?? "your partner"
                cell.personIcon.image = #imageLiteral(resourceName: "babyIcon")
                // MARK:- Baby facts start here
                var babyWeeks : [Int : String] = [
                1 : "Baby is not yet in existence",
                2 : "Baby is not yet in existence",
                3 : """
                When men ejaculate, they release around 100 million sperm. Of these, only a few hundred actually reach the woman’s egg. On the surface of the egg are receptors which make sure only one sperm gets in.
                
                """,
                4 : """
                \(babyStart) is only just about real and you could only just about see them with the naked eye.
                
                """,
                5 : """
                Congratulations! You’re going to be a Big Daddy!
                    
                \(babyStart) may only be the size of a peppercorn, but he or she is doing some serious growing. Incredibly, their heart is already functioning and blood is starting to circulate around their body. Their brain and spinal cord are also developing, and a string of blood vessels – which will eventually become \(baby)’s umbilical cord – connects \(baby) to \(motherMiddle).  This umbilical cord is a lifeline which will deliver essential oxygen and nutrients from \(motherMiddle) to \(baby).

                """,
                6 : """
                Find yourself wondering whether \(baby) will inherit Uncle Tim’s unusually large ears? This week, \(baby)’s facial features are starting to develop and they have a thin layer of transparent skin. Having said that, don’t get too excited yet. With a bump for their head, buds for arms and legs and a tail, \(baby) still looks more like a tadpole than anything else.
                    
                \(babyStart)’s little heart is beating at around 100 beats per minute (our resting heart rate is usually between 60 and 80) and could even be seen on a vaginal ultrasound around now.

                """,
                7 :"""
                This week, your peanut is fast becoming a little brain box! Their head is growing faster than the Incredible Hulk to make room for their expanding and increasingly complex brain. It won’t be too long before their brain will start to process sounds and light from inside \(motherMiddle)’s uterus.
                    
                In other news, \(baby)’s inner ear is starting to develop and their arms and legs are getting longer. Their sex organs are also taking shape, but don’t start painting the nursery yet – it’s still too early to tell on a scan whether they’re a boy or a girl.
                
                """,
                8 : """
                Breaking news: this week, \(baby)’s tail has almost completely disappeared! Phew. Their tail will be replaced by their tailbone (coccyx), which is at the base of their spine. \(babyStart)’s limbs are getting longer still, and there are notches visible on their hands where tiny little fingers will develop. Their facial features are becoming more defined, and their eyes have tiny eyelids.
                
                """,
                9 : """
                This is a big week for your little eyeball: all their body parts are now present! Although \(baby) doesn’t look like a tadpole any more, their fingers and toes are still webbed, Kermit-style. \(babyStart)’s eyes are getting bigger and their mouth and tongue are developing quickly, with tiny tastebuds starting to appear. \(mother)’s placenta is almost fully functioning and will soon provide vital nutrients to \(baby).
                
                """,
                10 : """
                This week, \(baby) has got more moves than Jagger as they discover that they can wriggle their arms and legs. \(mother) won’t be able to feel these jerky movements quite yet, but it will only be a couple of months before those first flutters are felt.
                    
                Amazingly, \(baby)’s jawbones already contain all of their milk teeth. Their heart is fully developed and is beating at around 180 beats per minute – that’s up to three times the speed of yours.

                """,
                11 : """
                Good news: \(baby) now looks less like E.T. and more like a miniature human. They have developed almost all of their critical organs and body parts, and will spend the next six months getting bigger, stronger and ready for the outside world.
                
                \(babyStart)’s fingers and toes are no longer webbed, and they even have tiny fingernails. Their eyelids have grown, and their eyes will stay closed for another few months.
                
                """,
                12 : """
                This week, \(baby) is the size of a chicken nugget (or an average-sized human testicle, if you prefer). Their face is perfectly formed – their eyes have moved closer together and they even have tiny little lobes on their ears. \(babyStart) is busy practising their facial expressions, and can now open their mouth, yawn, hiccup and swallow. At the moment, their skeleton is made up of rubbery cartilage (like your own ear or nose), but will now start to harden into bone.
                
                """,
                13 :"""
                It’s still too early to be able to tell on a scan whether you’re having a little boy or girl, but \(baby)’s sex organs are now fully developed. Their toes are now fully formed and their unique fingerprints are starting to show. \(babyStart)’s head now accounts for around a third of its whole length, as the part of the brain responsible for problem solving and memory is starting to develop.
                
                """,
                14 : """
                This week, \(baby) is starting to drink their own urine. We know – is that really necessary? Actually, it is. \(babyStart) swallows the amniotic fluid and it passes out again as urine. And then they swallow it again. And again. This not only helps their lungs to develop, but also allows their newly functioning kidneys to start doing their job. (On the other hand, perhaps they just do it because it’s sterile and they like the taste).
                    
                \(babyStart) is also sprouting fine hairs all over their body and head. This hair is called lanugo and is thought to help regulate \(baby)’s temperature inside the womb.
                    
                """,
                15 : """
                Whether you’re into deep house or light opera, it’s time to put the music on – this week, \(baby) can hear muffled sounds from the outside world as well as the sound of \(motherMiddle)’s voice, heart and tummy. Even though \(baby)’s eyes are still closed, they are becoming sensitive to light shining on \(motherMiddle)’s bump. That’s right – get the disco lights on and start singing to \(baby).
                    
                \(babyStart)’s body parts are all now present, and they are practising inhaling and exhaling the amniotic fluid. Who are we kidding? It’s wee. They’re practising swallowing the wee.
                    
                """,
                16 : """
                This week, \(baby) is getting a big workout as they start to flex their muscles and build up strength in their limbs. Their hands can form a fist and their neck is strong enough to sit upright on their body. Over the next few weeks, \(baby) will have a massive growth spurt.
                
                """,
                17 : """
                \(babyStart) now weighs the same as an unladen swallow. A fatty substance known as myelin has started to cover \(baby)’s spinal cord. This is an important stage in their development, as it helps messages from the nerves to the brain to travel as quickly as possible. Their hearing is becoming more and more sensitive, and they may start to respond to loud noises in the outside world by kicking, wriggling or punching.
                    
                \(babyStart)’s facial features are becoming even more defined, and their eyebrows and eyelashes are starting to grow. Their eyes are moving around under those tightly shut eyelids.
                    
                """,
                18 : """
                Who ate all the pies? \(babyStart), apparently! This week, they’re piling on the pounds and now have a little layer of fat under their skin. They still look pretty wrinkly, although their ears have finally moved up from the jawline into a more usual position. Girl-babies now have immature eggs developing in their ovaries, and have a fully-formed vagina, womb and fallopian tubes. Boybies’ testicles are moving down and their tiny penis is fully formed. If you’re planning on finding out the sex of \(baby), those all-important details should now be visible on a scan.
                    
                """,
                19 : """
                This week, \(baby)’s eyes are in their final position and are making random movements under their eyelids. Their arms and legs are now in proportion to the rest of their body. If you (like many dads-to-be) are mourning the loss of your shiny locks, try not to be envious of the hairs sprouting from your \(baby)’s scalp this week. \(babyStart)’s brain is developing rapidly, and is starting to form distinct areas for processing different senses, from sight to smells.
                    
                """,
                20 : """
                At the moment, \(baby)’s skin is covered in a greasy, cheesy substance called vernix. This protects the \(baby)’s skin from the effects of spending months floating around in amniotic fluid and (you might want to look away now if you’re squeamish) acts as a lubricant during birth. Lovely. On a less gruesome note, \(baby)’s milk and adult teeth are now in place under their gums.
                    
                """,
                21 : """
                This is a milestone week for \(baby), as it’s the first time that they weigh more than \(motherMiddle)’s placenta. #babygoals. Both \(baby) and the placenta (and \(motherMiddle)) will keep growing throughout the pregnancy, but \(baby) will keep getting bigger and bigger than the placenta.
                    
                \(babyStart) is now also covered in downy hair, called lanugo. No-one really knows why babies grow lanugo, but it’s possible that it could be to keep \(baby)’s temperature just right. But before you start worrying that they’ll come out hairier than Chewbacca, rest assured that lanugo usually disappears before birth, although it might be visible in very premature babies.
                    
                """,
                22 : """
                This week, \(baby) is busy creating its first poo. This black, sticky poo (known as meconium) is made up of all the things \(baby) is eating in the womb – from amniotic fluid to dead skin cells. This milestone first poo will be stored in \(baby)’s bowels until they’re born.
                    
                In other news, \(baby) now looks like a miniature newborn as all their body parts are fully present and correct. Their bones contain bone marrow, which is crucial for producing blood cells. And like a baby POTUS, their tiny hands are moving constantly.
                    
                """,
                23 : """
                \(babyStart)’s hearing is getting better with every day. Now they can hear sounds from near and far – from the sound of your voice (and snores and farts) to the sound of fireworks. Their ears can now send signals to their brain whenever they hear a sound, and will soon start to respond to more sounds by kicking and wriggling. Once they do, you can have a competition with \(motherMiddle) to see whose music \(baby) prefers. (And if \(baby) wriggles more to her music, you can always say that kicking means they want it to stop).
                    
                \(babyStart)’s lungs still don’t work properly, and they are getting all the oxygen they need from the placenta. This doesn’t stop them practising their breathing movements by swallowing more amniotic fluid, though. Before now, \(baby)’s liver and spleen were producing their red blood cells; this job has now been taken over by their bone marrow.
                    
                """,
                24 : """
                It’s another milestone week for \(baby), as they may now be able to survive outside the womb with specialist care. Their skin is still pretty translucent, but is becoming more resilient every day. Their heart rate has slowed down a little, but at 140 beats per minute, it’s still a lot faster than yours. Their eyelids are still closed, and their bones are getting harder and harder.
                    
                """,
                25 : """
                This week, you might notice \(baby) becoming more responsive to noises and sensations from the outside world. Their hearing is now really acute, so loud noises might make them startle. They also might start turning their head to a light shining on the bump. Their head is still a bit too large for their body, but they’re making up for it by practising awesome facial expressions such as frowning.
                    
                """,
                26 : """
                We’re telling you now – there is almost nothing cuter (and more hilarious) than a baby with hiccups. Amazingly, babies in the womb get hiccups too. \(mother) will probably notice it first, but as her bump grows bigger you might even be able to see or feel the tiny twitches of hiccups.
                    
                This week, tiny air sacs are developing in \(baby)’s lungs – this will help them to absorb oxygen into their blood after they’re born. \(babyStart)’s hand-eye co-ordination is improving every day, and they often bring their hands and feet to their mouth. Incredibly, \(baby)’s tastebuds are now fully developed.
                    
                """,
                27 : """
                It’s the final week of the second trimester! This week, \(baby)’s eyes are finally open – not that there’s a lot for them to see at the moment. Soon, they’ll start learning how to blink. \(babyStart)’s lungs are still developing, and a substance called surfactant is starting to coat the inside of the lungs. This stops their airways from sticking together, so that the tiny air sacs can inflate properly once they’re born and take their first breaths.
                    
                \(babyStart) is now getting into a regular cycle or waking and sleeping, and may even begin to dream soon.
                    
                """,
                28 : """
                It’s a big week – welcome to the third (and final) trimester! \(babyStart) is now perfectly formed, and is taking up quite a lot of space inside \(motherMiddle). At around this stage, many babies start to turn head down in the womb, to get ready for birth. The midwife or GP will tell \(motherMiddle) at her antenatal appointments what position the baby is in, but don’t worry if they’re not head down yet – there’s still plenty of time (and room) for them to keep changing position over the next few weeks.
                    
                \(babyStart)’s eyebrows and eyelashes are growing longer every day, as is the hair on their head (don’t be jealous, now). Their lungs are still developing, but \(baby) has a rhythmic pattern of breathing the amniotic fluid in and out.
                    
                """,
                29 : """
                \(babyStart) is piling on the pounds at the moment, and doing regular HIIT workouts in their underwater studio. Their hearing is now excellent, and \(motherMiddle)’s voice and heartbeat is starting to become familiar to them. If you keep talking to the bump regularly, they may even recognize your voice and be soothed by it after they’re born.
                    
                Try putting your ear to \(motherMiddle)’s bump every now and then – if it’s in exactly the right position, you might be able to hear \(baby)’s heartbeat.
                    
                """,
                30 : """
                This week, \(baby)’s brain is growing rapidly and is developing into distinct areas. Each of these areas will be responsible for processing different things, from memories to movement and emotions.
                    
                The amniotic sac has now stopped growing, and will just keep on stretching as \(baby) gets bigger and bigger.
                    
                """,
                31 : """
                By now, 75% of babies are in a head down position. But don’t worry if \(baby) isn’t; a bit like Tom Daley mid-dive, there’s still time for them to turn.
                    
                \(babyStart) has now developed their sucking reflex, and is probably sucking away on their thumb and fingers. Their eyes can now focus, although it’s pretty dark and murky in there so there isn’t much by way of entertainment. \(babyStart)’s lungs are still developing, and although they still wouldn’t be able to breathe on their own if they were born now, they’re not far off.
                    
                """,
                32 : """
                A bit of good news this week: if \(baby) is born now, they have an excellent chance of thriving. Their vital organs are all in situ, and just need a little bit more time for fine tuning.
                    
                From now on, \(baby) is concentrating on chubbing up. They’ll still get a bit longer before they’re born, but the rate of length growth has slowed down. All this growing means there’s a lot less space to move around in. The vernix (that greasy, cheesy substance) and lanugo (the downy hair) have started to disappear, and their skin looks a lot less translucent as they put more and more weight on.
                    
                """,
                33 : """
                This week, \(baby)’s brain and nervous system is fully developed. All of their bones are continuing to harden except for the skull (which stays soft to help it squeeze through the birth canal. Sorry. TMI.). Their fingernails are growing well, and may even now reach the top of their fingers.
                
                """,
                34 : """
                Even better news this week – most babies born now are in rude health. Their lungs are still not completely developed, but any breathing problems they have after birth are usually easy to treat.
                    
                \(babyStart) is probably now in their final position for birth, and the amount of amniotic fluid around them won’t now increase any more. \(babyStart)’s hearing is more acute than ever, and they’re probably enjoying listening in on every conversation, Watergate-style, and picking up on familiar sounds.
                    
                """,
                35 : """
                From now on, \(baby) is focused on getting as chubby as possible before the big day. In fact, over the next few weeks, they’ll gain almost 30 grams per day. That’s more than the weight of an AA battery every day.
                    
                \(babyStart)’s eyes now dilate in the light, which will help them prepare for the dazzling world outside the abyss. They’re practising their sucking movements to help them feed in the big wide world, and are so short of room that they’re now curled up tightly. Try watching \(motherMiddle)’s bump when she says \(baby) is moving and you might even be able to see it.
                    
                """,
                36 : """
                This week, \(baby)’s lungs and digestive system are finally fully developed. This means they’ll be able to breathe and feed on their own whenever they’re born. There won’t be much of that downy lanugo and greasy vernix over their body, but there might still be patches visible now.
                    
                \(babyStart) doesn’t have much room left at all now, and their head may now have started to “engage” (when it drops into a lower position, ready for birth). If you’re having a boy, his testes are starting to descend into his scrotum.
                    
                """,
                37 : """
                This is a big week – even though the due date is still three weeks away, \(baby) is now full term! He or she is busily gaining weight, practising frowns and pouts and may even be turning towards familiar sounds.
                    
                \(babyStart)’s gut now contains plenty of meconium (that epic first poo), and the downy lanugo hair all over \(baby)’s body has almost all been replaced with very fine vellus hairs instead.
                    
                """,
                38 : """
                This week, \(baby)’s bones have all hardened and their organs are fully developed. They have a strong grasp reflex and might even be holding onto their own umbilical cord. It’s only a matter of days now until that tiny hand will be clutching your finger.
                
                """,
                39 : """
                Even though \(baby)’s eyes are completely developed, they won’t be able to see far at all until a few weeks after they are born.
                    
                Their lungs are working well and they are taking around forty rhythmical breaths every minute. \(babyStart) is ready to join the world (and \(motherMiddle) is probably more than ready to evict them).
                    
                """,
                40 : """
                This week, \(baby) is around the same length as its umbilical cord. Or a trumpet. Whichever you prefer. And even though their eviction notice has been served, they don’t have any intention of slowing down. Even their hair and fingernails are growing, and the chances of them coming out looking like the love child of Wolverine and Rapunzel are increasing every day.
                    
                """
                ]
                
                cell.textView.setContentOffset(CGPoint.zero, animated: false)
                cell.textView.isScrollEnabled = false
                cell.textView.text = babyWeeks[collectionView.tag + 3]
                cell.textView.isScrollEnabled = true
                
            } else if indexPath.item == 2 {
                let mother : String  = UserDefaults.standard.string(forKey: "mother") ?? "Your partner"
                let motherMiddle : String = UserDefaults.standard.string(forKey: "mother") ?? "your partner"
                // MARK:- Mother updates start here
                var motherWeeks : [Int : String] = [
                    1 : "Baby is not yet in existence",
                    2 : "Baby is not yet in existence",
                    3 : """
                    Even though the pregnancy clock is ticking, these first 3 weeks don't count for anything - the sperm and the egg are still very much living their own separate lives right up until week 4.
                    
                    """,
                    4 : """
                    This week, \(motherMiddle)’s period is due. And if there’s a bun in the oven, that period will be AWOL. Her body will be starting to produce a hormone called human chorionic gonadotrophin (hCG) – which is what triggers the positive result on a pregnancy test.
                    
                    \(mother) might be feeling a bit tired and moody which – confusingly – might be how she normally feels around this time of the month. It’s a bit of a waiting game until that all-important pregnancy test.
                    
                    Some pregnancy tests are highly sensitive, and claim to give a reliable reading on the first day of the missed period. But if the test is negative, it’s so early that it doesn’t necessarily mean she’s not pregnant.
                    
                    """,
                    5 : """
                    It just got real – \(motherMiddle)’s period is MIA and you’ve very likely got a positive result on a pregnancy test.
                    
                    \(mother) might be feeling a bit tired, and increased blood flow to her breasts could leave them feeling a bit sensitive or tender. It’s possible that she might notice a tiny bit of light bleeding when she goes to the toilet around now. It’s really important that \(motherMiddle) starts taking a folic acid supplement until she’s 12 weeks pregnant, as this will help the baby’s nervous system to develop properly and prevent defects such as spina bifida.

                    """,
                    6 : """
                    \(mother) doesn’t look pregnant at all, but she may be starting to feel different. Hormone changes and increased blood flow to her kidneys may mean more overnight trips to the toilet.
                    
                    Up to 9 out of 10 pregnant women suffer from morning sickness or nausea, so chances are \(motherMiddle) will start feeling a little green around the gills over the next few weeks. If she’s vomiting more than Regan-The-Exorcist-MacNeil, and can’t keep anything down, she should go to her GP. Around 1 in 100 pregnant women suffer from a condition called hypermeresis gravidarum (made famous by Kate of Kate’n’Wills), where they vomit so much that they may need hospital treatment. Even if it’s not that severe, if \(motherMiddle) is struggling with sickness or feeling nauseous, her GP may be able to help by prescribing anti-sickness tablets or suggesting ways to cope with the symptoms. Have a look at our morning sickness article for some tips.

                    """,
                    7 :"""
                    This week, \(motherMiddle) might start to feel some twinges in her belly, as her uterus begins to expand. If she feels any sort of pain in her tummy, or has more than a tiny amount of bleeding, she should go to her GP. Chances are, it’s nothing to worry about, but it’s better to get it checked as it can be an early sign of miscarriage.
                    
                    If she’s feeling greener than Slimer, try making her a cup of stomach-settling ginger tea. You can either buy ginger teabags, or just add boiling water to a tablespoon of chopped fresh ginger.
                    
                    """,
                    8 : """
                    Varicose veins are common in pregnancy, and \(motherMiddle) might start to notice one or two developing on her legs. Varicose veins are just where blood collects in veins and makes them bulge a bit. They usually don’t cause serious problems, but \(motherMiddle) should mention them to her midwife at her next appointment.
                    
                    Soon, \(motherMiddle) will be having her first antenatal appointment – called the Booking Appointment. At this appointment, a midwife will just ask her straightforward questions about her medical history and lifestyle, and will calculate the approximate due date of your baby (although this date won’t be confirmed until the first scan). The midwife will also measure \(motherMiddle)’s BMI, take her blood pressure and a urine sample, and do some blood tests. At the end of the appointment, the midwife will give \(motherMiddle) her all-important maternity notes – these should be kept safe as she’ll need to take them to every appointment, and eventually the birth.

                    """,
                    9 : """
                    You might notice \(motherMiddle)’s breasts are starting to get larger. This is because pregnancy hormones cause the fat in breasts to get thicker, and the milk ducts to multiply, ready for breastfeeding.
                    
                    This week, the combination of tiredness and nausea might be starting to get \(motherMiddle) down. If you think she might be feeling a bit low, why not suggest a date night? If she doesn’t feel like going out, you could surprise her with a night in with her favourite dinner (one that won’t make her retch at the smell) and a feel-good film.

                    """,
                    10 : """
                    Headaches and dizziness are really common in pregnancy, but \(motherMiddle) should make sure she doesn’t take ibuprofen (such as Nurofen) or aspirin. If she needs a painkiller, paracetamol should do the trick.
                    
                    \(mother)’s nausea and tiredness might be getting more intense. If she’s feeling down about it, reassure her that these symptoms should start getting much better soon. In fact, many women feel better than ever once they reach the second trimester – which is only a few weeks away!

                    """,
                    11 : """
                    Pelvic floor exercises: contrary to what one Big Daddy believed, these are not lying-on-the-floor exercises. “No,” he told her midwife. “My wife has NOT being doing her pelvic floor exercises because I haven’t seen her on the floor once!”
                    
                    Actually, they’re really important exercises which \(motherMiddle) should do throughout her pregnancy to help reduce the risk of stress incontinence. She should squeeze her pelvic floor muscles (the ones she uses when she’s bursting for the loo and has to hold it in) for ten seconds, ten times in a row, three or four times per day. It’s your job to remind her to do them. And when you say you can’t be bothered, do you really want to have to mop up every time she laughs? Thought not.

                    """,
                    12 : """
                    Pregnancy gingivitis: a phenomenon which causes pregnant women’s hair to turn a fiery shade of red, or a term for bleeding gums in pregnancy? Disappointingly, it’s the gums. We know: the hair thing would be way more exciting.
                    
                    Bleeding gums in pregnancy is really common, as hormonal changes lead to a build up of plaque on the teeth. But the good news is that pregnant women in the UK are entitled to free dental care on the NHS. So make sure \(motherMiddle) gets her mumma mitts on a maternity exemption card (through her GP) and books an appointment, stat.

                    """,
                    13 :"""
                    By now, you will probably have seen your baby on an ultrasound scan and things might be starting to feel more real for both of you. Although \(motherMiddle) might still not have a bump (especially if this is her first baby), you won’t have long to wait before she’s starting to show.
                    
                    If \(motherMiddle) is still suffering from nausea and tiredness, keep reminding her that this is the final week of the first trimester and that she’ll start to feel better any day. In the meantime, make her a nice cup of tea. She deserves it.
                    
                    """,
                    14 : """
                    It’s the start of the second trimester and \(motherMiddle) may be starting to feel a bit brighter. Even if she’s still spending most of her time looking at the inside of the toilet bowl, it won’t be long before these special vomit-tinged days are a distant memory.
                    
                    Incredibly, \(motherMiddle)’s body is now starting to make a substance called colostrum, which is the body's first breastmilk. In the final weeks of pregnancy, she might even start to leak colostrum from her nipples. Sorry. Was that too much information?

                    """,
                    15 : """
                    If \(motherMiddle) had trouble sleeping during the first trimester, she may now find it easier as her uterus is moving up and away from her bladder. Those midnight loo trips may also now be a thing of the past (for now). This is good news for you, as a well-rested pregnant lady is not nearly as terrifying as a sleep-deprived pregnant lady.
                    
                    """,
                    16 : """
                    Has \(motherMiddle) had any nosebleeds during her pregnancy? Weirdly, nosebleeds are really common in pregnant women. Pregnancy hormones will be making \(motherMiddle)’s blood vessels weaker, and increased blood flow in her body will be putting pressure on those vessels, which can cause nosebleeds. They’re nothing to be alarmed about, although they have a tendency to happen at the least convenient time possible. In fact, it’s pretty much guaranteed that they’ll happen during an important meeting or while \(motherMiddle) is wearing a white top, or both. Just remind \(motherMiddle) to drink plenty of water and try not to laugh.
                    
                    """,
                    17 : """
                    This is it. Any day now, \(motherMiddle) will feel the baby move. To start with, it may feel more like fluttering movements or bubbles popping, rather than full-on roundhouse kicks. And you may not be able to feel anything at all until the baby is a little bit bigger. It’s a big moment, though. Definitely a reason to celebrate with an extra-large glass of w...ater.
                    
                    """,
                    18 : """
                    It’s not your eyes; \(motherMiddle) is definitely looking a little more rounded. It’s best not to comment on it, though. If she’s feeling uncertain about her changing shape, remind her that her body is doing an amazing job of growing a tiny person, and she looks more beautiful than ever.
                    
                    \(mother) is going to get LOT bigger before the baby is born (again, perhaps don’t mention that), and that weight gain isn’t just the baby. By the time your baby is born, the amniotic fluid and placenta combined will weigh around 1.5kg, and all \(motherMiddle)’s extra blood, fluid, fat and increased breast size will weigh a whopping 7.7kg (that’s 17lb).
                    
                    """,
                    19 : """
                    Around now, \(motherMiddle) might notice that she’s developing a dark vertical line (called a linea nigra) on her stomach. She might also get some darker patches (called chloasma) on her hands, neck or face. Both are completely normal during pregnancy, and happen because \(motherMiddle)’s body will be producing more melanin (the pigment which tans skin) during pregnancy. If \(motherMiddle) is self-conscious about them, reassure her that they’re really common and will usually disappear once the baby is born.

                    """,
                    20 : """
                    This week, \(motherMiddle) might be feeling some aches or cramps in her lower belly. This is just her ligaments stretching to make room for the growing baby. If it feels painful at all, or if \(motherMiddle) is worried about it, she should get in touch with her midwife.
                    
                    Don’t forget to compliment \(motherMiddle)’s hair this week. Hair loss slows down in pregnancy, which means that her hair may start to look thicker and shinier than ever. Even if it doesn’t, why not tell her it looks great anyway? She’ll never know, and it’ll make her smile.
                    
                    """,
                    21 : """
                    As her bump grows, \(motherMiddle) might be struggling to get comfortable in bed and be starting to feel tired again. Help her to position pillows around her in bed – it might help to try one under the bump, one between her legs and even one by her back. We know – you’re going to need a bigger bed, chaps.
                    
                    Headaches are also really common around this time in pregnancy, but if \(motherMiddle) is getting severe or frequent headaches (or it’s accompanied by any pain, blurred vision or swelling in her hands and feet), she should see her GP or midwife as it could be a sign of pre-eclampsia.

                    """,
                    22 : """
                    \(mother) is now sporting a spectacular bump and is beginning to look properly pregnant. She might start getting some stretch marks around her breasts, bump or legs. If \(motherMiddle) is worried about these, you can reassure her that they are incredibly common and that they’ll fade to a silvery-grey colour after the baby is born. Reiterate that she’s doing an amazing job of growing a person and make her another cup of tea. Quickly.
                    
                    """,
                    23 : """
                    This week, you can compliment \(motherMiddle) on her radiant skin. “Wow!” you can say. “Your skin looks amazing at the moment!” Cue big smile. Now that she’s well over half way through her pregnancy, \(motherMiddle) has more blood pumping round her body and her skin is retaining more moisture. So, chances are her skin really does look great. What’s the harm, eh?
                    
                    \(mother)’s bump is getting bigger, and she might start to suffer from backache as her body adjusts to carrying half a kilo of baby. That’s a bit less than the weight of a basketball. Better not tell \(motherMiddle) just yet, but your baby could weigh around SEVEN times that by the time they’re born.

                    """,
                    24 : """
                    \(mother) might be suffering from indigestion or heartburn at the moment. This is partly because her pregnancy hormones will be relaxing all her muscles, slowing down her digestive system. And at the same time, the baby is pushing her stomach up higher which means that stomach acid (which causes heartburn) can cross into the gullet more easily.
                    
                    She (and you) can try eating smaller and more frequent meals, and steering clear of foods which are particularly rich or fatty. It might help her to sit up more after meals, and you could even try raising of the mattress in bed with cushions.
                    
                    If she’s spending ages in the loo, don’t even think about mentioning it. Again, constipation is really common in pregnancy so just push loads of fruit and vegetables in her direction and encourage her to drink plenty of water.

                    """,
                    25 : """
                    \(mother) might notice that her hands and feet are getting a little swollen lately. This is very common in pregnancy, so chances are it’s nothing to worry about. Do order her to put her feet up and make her a nice cool drink. Don’t tell her she’s looking less like a human and more like a balloon animal.
                    
                    Swollen hands and feet can be a symptom of a serious condition called pre-eclampsia. If the swelling comes on suddenly, or it doesn’t get better when resting, \(motherMiddle) should contact her GP or midwife right away.
                    
                    """,
                    26 : """
                    \(mother) might feel like her eyes are a bit dry at the moment, and this is another odd side effect of pregnancy. She can try massaging her eyelids, limiting screen time or using a humidifier. Or you could run her a nice warm bath. But if her eyes are really uncomfortable, she should mention it to her GP or optometrist. They’ll be able to rule out anything more serious and can recommend eye drops which are safe to use during pregnancy.
                    
                    """,
                    27 : """
                    Is \(motherMiddle) feeling hot, hot, hot at the moment? While it might be hard to keep your cool when she’s thrown the duvet out of the window and into the snow at 2am for the third night in a row, try to be sympathetic. Hot flushes can be really uncomfortable, and they’re very common in pregnancy because of all the hormones and increased blood flow. Suggest that \(motherMiddle) spritzes her face with cool water when she’s feeling warm, and keep an emergency sleeping bag on your side of the bed.
                    
                    """,
                    28 : """
                    Welcome to the third trimester! \(motherMiddle) could be starting to feel dizzier than a goat with vertigo on top of the Empire State Building. Pregnancy hormones cause blood vessels to relax so that more blood can flow through them to the baby, which can lower the blood pressure. As the baby grows, the amount of pressure on the blood vessels increases, which can lead to a feeling of dizziness. Other things which often cause dizziness in pregnancy are low blood sugar levels or low iron levels.
                    
                    If she has a dizzy spell, \(motherMiddle) should make sure she sits down and puts her head between her knees. Make sure she gets up slowly to avoid a head rush. She could also try eating smaller meals more regularly, to keep her blood sugar levels consistent. However, if the feeling of dizziness continues \(motherMiddle) should mention it to her midwife, and they’ll be able to check her iron levels.
                    
                    """,
                    29 : """
                    Has \(motherMiddle) got that itchy twitchy feeling at the moment? A quarter of pregnant women feel itchy (usually on their breasts and bump) and it can be really annoying for them (and you). \(mother) should avoid scratching, and try using soothing moisturisers or rubbing ice cubes or a cold wet flannel on the skin. The vast majority of the time, it’s just an irritating problem, but do make sure \(motherMiddle) mentions any itching to the midwife, as it can be a symptom of a rare liver disease called obstetric cholestasis.
                    
                    \(mother)’s appetite has probably increased significantly since before she was pregnant, and she may be having some serious red meat cravings. But as long as she doesn’t announce that she’s eating an old friend for dinner, there’s no  cause for alarm. It’s your job to try and encourage her to eat healthily, although if you remind her too many times that she should only be eating an extra 200 calories per day, you may get your finger bitten off. Literally.
                    
                    """,
                    30 : """
                    Have you been woken in the middle of the night a LOT during \(motherMiddle)’s pregnancy so far? First it was the loo trips. Then it was the hot flushes. Now, it’s leg cramps. Sorry, chaps – just see it as vital training for your future sleep deprived life with a newborn.
                    
                    And actually, leg cramps are the worst. So try to be nice. It might help \(motherMiddle) to put a pillow between her legs and a cushion under her bump.
                    
                    Around this time, \(motherMiddle) might also get some tingling, aching, numbness or pins and needles in her fingers. These could be symptoms of carpal tunnel syndrome. \(mother) should mention it at her next antenatal appointment and, in the meantime, she can try resting her hand in a raised position or even using a splint if it’s really noticeable.
                    
                    """,
                    31 : """
                    Around now, \(motherMiddle) might start feeling a bit breathless. During her pregnancy, \(motherMiddle)’s ribcage has been moving outwards and her body has been working more quickly to process the oxygen and carbon dioxide in each breath. This means that she’s able to take much deeper breaths, but also might make her feel a bit breathless sometimes. And as the baby gets bigger, they will be pushing up against \(motherMiddle)’s lungs, which will make her feel even more breathless. It’s usually nothing to worry about, but if \(motherMiddle) is also getting palpitations or dizziness, she should contact her GP.
                    
                    So don’t laugh at \(motherMiddle) next time you beat her when racing up the stairs to go to the toilet. Be a gentleman and let her go first.
                    
                    """,
                    32 : """
                    Has \(motherMiddle) felt any contractions yet? Don’t get too excited. These little tightenings of her bump are called Braxton Hicks contractions, and they’re bigger fakers than Truman’s neighbours on Seahaven Island. Unless they start increasing in intensity, or don’t ease off after a short while, Braxton Hicks contractions are just a way of \(motherMiddle)’s body preparing itself for labour.
                    
                    With her ever-growing bump and the return of the nightime loo trips, \(motherMiddle) might be finding it harder to sleep than Al Pacino in Alaska. She might also report having some crazy dreams around now. Whatever she tells you, just nod. And don’t take it personally if she dreams that the baby comes out looking like Bob in Accounts.
                    
                    """,
                    33 : """
                    This week, \(motherMiddle) might need to start slowing down a little bit. The baby now weighs nearly two kilograms, which might be making her feel tired and her back ache. To be fair, she’s carrying the weight of a small chihuahua. Cut her some slack and suggest a night in. If you want to earn dad points, why not make her favourite meal (or order a takeaway) and give her sole access to the remote for an evening?
                    
                    Oh, and her breasts may start leaking milk around now. We know you’re tempted to call her a human cow, but that joke has to come from her first. Trust us.
                    
                    """,
                    34 : """
                    \(mother)’s uterus is now sitting high up in her abdomen, and she might start to feel pressure under her ribs. This may make eating a full meal difficult, so encourage her to eat smaller meals more regularly. If you’re feeling kind, why not get some healthy snacks in? Preparing a few pots of Greek yoghurt, chopped fruit, or houmous and carrot sticks for her to snack on during the day will earn you serious dad points.
                    
                    """,
                    35 : """
                    Your baby has recently earned their black belt in kung fu, and \(motherMiddle) is feeling the effects. If she’s finding the kicks really uncomfortable, she can try moving around or going onto all fours to encourage the baby to change into a different position.
                    
                    As the baby gets bigger, the movements will feel different. However, \(motherMiddle) should be keeping track of the baby’s usual movements, and must let the midwife know straight away if she thinks the movements have changed.
                    
                    """,
                    36 : """
                    This week, it’s definitely time to pack the hospital bag. \(mother) is probably feeling tireder than everyone's favourite narcoleptic dog, so why not suggest that she puts her feet up while you pack the bag (under her close supervision). In the heat of labour, you’ll be the one searching through the bag so it’s a great way to make sure you know your maternity pads from your breast pads. As it were.
                    
                    """,
                    37 : """
                    Around now, the baby is moving down and away from \(motherMiddle)’s ribcage. This might help her to feel a bit more comfortable, but she might also need to wee more often. If it’s \(motherMiddle)’s first baby, she might not feel the bump move down until labour starts, so it’s nothing to worry about if it still feels high up.
                    
                    Don’t forget to remind her to do her pelvic floor exercises!
                    
                    """,
                    38 : """
                    The end is now in sight, and \(motherMiddle) might be starting to experience a few mood swings. When it starts to feel like you’re living with the Incredible Hulk, don’t forget that she’s carting around three kilograms of baby. That’s nearly as much as a roast turkey. Add a few sleepless nights, fake contractions, and ten million loo trips a day and you can hardly be surprised if she’s feeling a bit tense.
                    
                    \(mother) might also be starting to think about the birth, and could be worrying about what’s in store. Encourage her to talk about it, if that would help, and reassure her that you’ll be there throughout and that you’re so close now to finally meeting your baby.

                    """,
                    39 : """
                    By now, \(motherMiddle) is probably feeling a little like a whale. And she may be waddling a little, although you must never admit this or you might end up like Materazzi, and no one wants that.
                    
                    Now is the time to make the most of your time as a couple, before you become a family. Make her an offer she can’t refuse and suggest a date night at her favourite local restaurant, or a candlelit takeaway at home.
                    
                    """,
                    40 : """
                    The due date is finally here, but the baby might not make an appearance for another two weeks. During this time, \(motherMiddle) may be feeling even more tired and uncomfortable. Encourage her to take naps during the day, and make sure she’s getting lots of rest.
                    
                    If \(motherMiddle) is worrying about things that need to be done before the baby arrives, suggest that she writes down everything that needs to be done. Then you can divide up the most important tasks between you, and even draft in family members or friends to help out if you need. The most important thing is that \(motherMiddle) takes it easy, and the baby definitely won’t notice if the stairs haven't been hoovered.
                    
                    In the next two weeks you will have your baby. You'll have first smiles and first steps, sleepless nights and teething. This is your gift, your curse. Who are you? You’re a Big Daddy.
                    
                    """
                ]
                
                cell.textView.isScrollEnabled = false
                cell.textView.text = motherWeeks[collectionView.tag + 3]
                cell.textView.isScrollEnabled = true
                cell.personIcon.image = #imageLiteral(resourceName: "femaleIcon")
            } else if indexPath.item == 3 {
                let baby : String = UserDefaults.standard.string(forKey: "baby") ?? "your baby"
                let mother : String  = UserDefaults.standard.string(forKey: "mother") ?? "Your partner"
                let motherMiddle : String = UserDefaults.standard.string(forKey: "mother") ?? "your partner"
                // MARK :- Fun Facts start here
                var factWeeks : [Int : String] = [
                    1 : "Baby is not yet in existence",
                    2 : "Baby is not yet in existence",
                    3 : """
                    Around 84 in 100 couples will get pregnant within the first year of trying. Get on it; unlike your bed, your mother can’t make a baby for you.
                    
                    """,
                    4 : """
                    Doctors used to prescribe Guinness to pregnant women, as it was thought to be a valuable source of iron. Apparently, it only contains a tiny amount of iron. Drinking in pregnancy is best avoided, but perhaps dads could use it as an excuse for a pint?
                    
                    """,
                    5 : """
                    Eating for two is a myth! During the first six months of pregnancy, women don’t need to eat any additional calories at all. During the last three months, they only need an extra 200 calories per day. That’s barely half a jam doughnut!
                    
                    """,
                    6 : """
                    If \(motherMiddle) is feeling sick, she’s not alone. Around 70-80% of women suffer from nausea or vomiting during pregnancy.
                    
                    """,
                    7 :"""
                    Do you have a cat? Cat faeces can contain a parasite which causes a rare but dangerous infection called toxoplasmosis. This infection can cause stillbirth or miscarriage in pregnant women, so you’d better make it your job to clean the litter tray while \(motherMiddle) is pregnant.
                    
                    """,
                    8 : """
                    Around week 8, your baby’s tail has almost disappeared and will be replaced by their tailbone (coccyx). In very rare cases, the tail doesn’t disappear and the baby is born with it (although it can be easily removed after birth). The longest tail recorded in a human is 13 inches long.
                    
                    """,
                    9 : """
                    During pregnancy, \(motherMiddle)’s womb will increase in size by 500%.
                    
                    """,
                    10 : """
                    One in every 2,000 babies is born with a tooth.
                    
                    """,
                    11 : """
                    Soon, the baby may start sucking their thumb. Baby elephants suck their trunks. #toocute
                    
                    """,
                    12 : """
                    Around this stage, your baby’s bladder is so tiny that it fills and empties every 30 minutes.
                    
                    """,
                    13 :"""
                    A baby’s fingerprints are fully developed within the first three months of pregnancy.
                    
                    """,
                    14 : """
                    Female seahorses lay up to 1,500 eggs in the male seahorse's pouch. The male seahorse fertilises the eggs and is then pregnant for a few weeks before he gives birth to around 200 baby seahorses. Don't you just wish you were a seahorse now?
                    
                    """,
                    15 : """
                    When \(motherMiddle) eats, some of the nutrients in the food passes through the placenta and into the amniotic fluid. When \(baby) swallows the amniotic fluid, they experience a tiny taste of whatever \(motherMiddle) has been eating.
                    
                    """,
                    16 : """
                    Female lions often give birth at the same time as other lions in the pride, so baby lions have loads of playmates. Be more lion. Join an antenatal class.
                    
                    """,
                    17 : """
                    If the placenta is at the front of the womb, it acts as a cushion, so \(motherMiddle) may not feel \(baby) move until later in her pregnancy.
                    
                    """,
                    18 : """
                    Baby girls are born with all of their reproductive eggs already in their ovaries. So \(motherMiddle) is not only carrying your daughter, but also half of your future grandchild. Mind = blown.
                    
                    """,
                    19 : """
                    Before 14 weeks, gender predictions by ultrasound are only 75% accurate, but by the time your 20 week scan comes around, those clever ultrasonographers get it right almost all of the time.
                    
                    """,
                    20 : """
                    \(mother)'s womb isn't actually in the middle of her tummy. It will rotate to the right as \(baby) grows, so any aches and pains are more likely to be on the right hand side of her bump.
                    
                    """,
                    21 : """
                    The most babies ever born simultaneously to the same mother is eight. The most puppies ever born to the same dog is 24. 24! Cruella de Vil, eat your heart out.
                    
                    """,
                    22 : """
                    During pregnancy, \(motherMiddle)’s sense of smell actually gets stronger. Time to find a new home for those stinking socks before she vomits on you.
                    
                    """,
                    23 : """
                    Just keep brushing. Just keep brushing. Just keep brushing brushing brushing. \(mother)’s teeth and gums are especially vulnerable during pregnancy, and bleeding is common. Encourage her to make the most of free NHS dental care for pregnant women to keep those pearly whites shining!
                    
                    """,
                    24 : """
                    The world's youngest surviving premature baby was born in Florida at 21 weeks and 6 days.
                    
                    """,
                    25 : """
                    Pregnant women’s feet sometimes swell so much that they go up a shoe size. Offers to lend her your shoes may not be well received.
                    
                    """,
                    26 : """
                    Milk sometimes comes out of pregnant women’s breasts when they hear a baby crying. If that wasn't weird enough, around 5% of newborn babies produce breastmilk. Even boys. This is traditionally called witch's milk.
                    
                    """,
                    27 : """
                    Dads-to-be often have very vivid dreams during pregnancy. Some even dream that they are pregnant themselves.
                    
                    """,
                    28 : """
                    Feeling like you wish you could help \(mother) more with her pregnancy? Be careful what you wish for - male emperor penguins are responsible for keeping their partner’s egg warm, while she goes and has a nice meal. For several weeks.
                    
                    """,
                    29 : """
                    \(mother)’s blood may clot more easily during pregnancy. She should wear flight socks and try and break up long journeys with walks or exercises to keep the circulation going in her legs.
                    
                    """,
                    30 : """
                    Babies cry in the womb. Kind of wish we didn’t know that. Sorry.
                    
                    """,
                    31 : """
                    Women who suffer from heartburn during pregnancy are supposedly more likely to give birth to a baby with lots of hair.
                    
                    """,
                    32 : """
                    The word placenta means “flat cake” in Latin. Apparently it’s to do with the shape, rather than the taste. We hope.
                    
                    """,
                    33 : """
                    Around one in four babies in the UK are born by caesarian section. The Dominican Republic has the highest rate of c-sections in the world, topping 58%.
                    
                    """,
                    34 : """
                    Babies in the womb are able to hear deeper male voices more clearly than female ones.
                    
                    """,
                    35 : """
                    Baby giraffes can stand up and walk within only an hour of being born. We'll be honest: there's no way \(baby) is going to do that.
                    
                    """,
                    36 : """
                    Only 4% babies arrive on their due date. 80% come within the two weeks either side.
                    
                    """,
                    37 : """
                    Is \(motherMiddle) getting tired of being pregnant? Elephants are pregnant for nearly two years. Opossums, on the other hand, are only pregnant for 14 days.
                    
                    """,
                    38 : """
                    By the end of her pregnancy, the total amount of blood in \(motherMiddle)’s body has increased by 50%. So you can't really blame her if she sounds a bit out of breath on the stairs…
                    
                    """,
                    39 : """
                    Pregnancies last one week longer in France. Sacre bleu!
                    
                    """,
                    40 : """
                    The world record for the longest pregnancy was set by Beulah Hunter in 1945 at one year and 10 days. That’s 95 days more than the average!
                    
                    """
                ]
                
                cell.textView.isScrollEnabled = false
                cell.textView.text = factWeeks[collectionView.tag + 3]
                cell.textView.isScrollEnabled = true
                cell.personIcon.image = #imageLiteral(resourceName: "factIcon")
                
                
            } else {
                cell.textView.text = "screen4"
            }

            return cell
        }
     
    }

    }

extension Date {
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
}
