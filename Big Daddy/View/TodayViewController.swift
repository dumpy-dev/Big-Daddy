//
//  TodayViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

   // Code for the Setup Popup
    
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet var setupPopup: UIView!
    @IBOutlet weak var mothersNameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBAction func skipPressed(_ sender: Any) {
         UserDefaults.standard.set("your partner", forKey: "mother")
        
        let calendar = Calendar.current
        var component = DateComponents()
        component.day = -280
       let calculatedDate = calendar.date(byAdding: component, to: Date())
        
        print(calculatedDate)
        
        UserDefaults.standard.set(Date(), forKey: "DueDate")
        //UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
        animateOut()
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mothersNameField.resignFirstResponder()
        return true
    }
    
    @IBAction func donePressed(_ sender: Any) {
    
        UserDefaults.standard.set(mothersNameField.text, forKey: "mother")
        if dateSwitch.isOn {
            datePicker.minimumDate = nil
            let daysToAdd = 280
            let calculatedDueDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: datePicker.date)
            let now = Date()
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate!).day
            let weeksLeft : Int = diffInDays!/7
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDays : Int = diffInDays!%7
            let remainderDaysElapsed : Int = 7 - remainderDays
            
            print("\(mothersNameField.text)'s due date is \(calculatedDueDate!) which means she is \(weeksElapsed) weeks along")
            
            if weeksLeft >= 40 {
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                self.datePicker.setDate(Date() as Date, animated: true)
            } else {
                let dateEntered = datePicker.date
                UserDefaults.standard.set(dateEntered, forKey: "dateEntered")
                UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
                UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
                UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
            }
        } else {
            datePicker.minimumDate = Date()
            let now = Date()
            let calculatedDueDate = datePicker.date
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate).day
            let weeksLeft : Int = diffInDays!/7
            let remainderDays : Int = diffInDays!%7
            print("You have \(weeksLeft) weeks and \(remainderDays) days to go!")
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDaysElapsed : Int = 7 - remainderDays
            if weeksLeft >= 40 {
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                self.datePicker.setDate(Date() as Date, animated: true)
            } else {
                let dateEntered = datePicker.date
                UserDefaults.standard.set(dateEntered, forKey: "dateEntered")
                UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
                UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
                UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
            }
        }
        animateOut()
    }
    
    // MARK - code for remaining functionality

    
    @IBOutlet weak var babyAgeLabel: UILabel!
    var selectedPerson = ""
    var selectionTag = 0
    
    //Setup the arrays and dictionaries
    
    let babySizeImageArray = ["week0-3", "week4", "week5", "week6", "week7", "week8", "week9", "week10", "week11", "week12", "week13", "week14", "week15", "week16", "week17", "week18", "week19", "week20", "week21", "week22", "week23", "week24", "week25", "week26", "week27", "week28", "week29", "week30", "week31", "week32", "week33", "week34", "week35", "week36", "week37", "week38", "week39", "week40", "week41", "week42"]
    let babySizeLabelArray = ["still in beta", "the size of a grain of salt", "the size of a peppercorn", "the size of a snowflake", "the size of a peanut", "the size of a bee", "the size of an eyeball", "the size of a maki roll", "the size of a poker chip", "the size of a chicken nugget", "the size of a tennis ball", "the size of a deck of cards", "the size of a big mac", "the size of a can of coke", "the size of a pair of aviators", "the size of an iPhone 8", "the size of a pint", "the height of a beer bottle", "the length of a tube of pringes", "the size of a trowel", "the length of a sheet of A4", "the height of a bottle of wine", "the size of a hammer", "the size of a violin", "the weight of War and Peace", "the size of X", "the weight of a tomahawk steak", "the size of a steering wheel", "the weight of an adult brain", "the weight of a roast chicken", "the size of a vinyl player", "the size of a dartboard", "the size of a small octopus", "the size of a brick", "the height of a car tyre", "the size of X", "the length of a wood saw", "the length of a full rack of ribs"]
    let weightArray = ["week1to3", "0.01g", "0.2g", "0.4g", "0.8g", "1g", "2g", "4g", "8g", "14g", "23g", "45g", "70g", "100g", "140g", "190g", "240g", "300g", "360g", "430g", "500g", "600g", "660g", "760g", "875g", "1kg", "1.1kg", "1.3kg", "1.5kg", "1.7kg", "1.9kg", "2.1kg", "2.4kg", "2.6kg", "2.9kg", "3.1kg", "3.3kg", "3.5kg", "3.5kg", "3.5kg"]
    let lengthArray = ["week1to3", "1mm", "2mm", "4mm", "8mm", "1.6cm", "2.3cm", "3.4cm", "4.1cm", "5.4cm", "7.4cm", "8.5cm", "10.1cm", "11.6cm", "12.9cm", "14.2cm", "15cm", "25.6cm", "26.6cm", "27.8cm", "29cm", "30cm", "34.6cm", "35.6cm", "36.6cm", "37.6cm", "38.6cm", "39.9cm", "41.1cm", "42.4cm", "43.7cm", "45cm", "46.2cm", "47.4cm", "48.6cm", "49.8cm", "50.6cm", "51.2cm", "51.2cm", "51.2cm"]
  
    var babyWeeks : [Int : String] = [
        
        1 : "Baby is not yet in existence",
        2 : """
Baby is still not in existence
""",
        3 : "Baby is still not in existence",
        4 : "Baby is possibly just about in existence",
        5 : "Baby is in existence",
        6 : "Baby is getting bigger",
        7 : "Baby is getting bigger",
        8 : "Baby is getting bigger",
        9 : "Baby is getting bigger",
        10 : "Baby is getting bigger",
        11 : "Baby is getting bigger",
        12 : "Baby is getting bigger",
        13 : "At 13 weeks,Baby is getting bigger",
        14 : "At 14 weeks, Baby is getting bigger",
        15 : "At 15 weeks,Baby is getting bigger",
        16 : "At 16 weeks, Baby is getting bigger",
        17 : "Baby is getting bigger",
        18 : "Baby is getting bigger",
        19 : "Baby is getting bigger",
        20 : "Baby is getting bigger",
        21 : "At 21 weeks, Baby is getting bigger",
        22 : "Baby is getting bigger",
        23 : "Baby is getting bigger",
        24 : "Baby is getting bigger",
        25 : "Baby is getting bigger",
        26 : "Baby is getting bigger",
        27 : "Baby is getting bigger",
        28 : "Baby is getting bigger",
        29 : "Baby is getting bigger",
        30 : "Baby is getting bigger",
        31 : "At 31 weeks, Baby is getting bigger",
        32 : "Baby is getting bigger",
        33 : "Baby is getting bigger",
        34 : "Baby is getting bigger",
        35 : "Baby is getting bigger",
        36 : "Baby is getting bigger",
        37 : "Baby is getting bigger",
        38 : "Baby is getting bigger",
        39 : "Baby is getting bigger",
        40 : "Baby is getting bigger",
        41 : "Baby is getting bigger",
        42 : "Baby is getting bigger"
    ]
    
    
    
    var factWeeks : [Int : String] = [
        1 : "Baby is not yet in existence",
        2 : "Baby is still not in existence",
        3 : "Baby is still not in existence",
        4 : "Baby is possibly just about in existence",
        5 : "Baby is in existence",
        6 : "Baby is getting bigger",
        7 : "Baby is getting bigger",
        8 : "Baby is getting bigger",
        9 : "Baby is getting bigger",
        10 : "Baby is getting bigger",
        11 : "Baby is getting bigger",
        12 : "Baby is getting bigger",
        13 : "Baby is getting bigger",
        14 : "Baby is getting bigger",
        15 : "Baby is getting bigger",
        16 : "Baby is getting bigger",
        17 : "Baby is getting bigger",
        18 : "Baby is getting bigger",
        19 : "Baby is getting bigger",
        20 : "Baby is getting bigger",
        21 : "Baby is getting bigger",
        22 : "Baby is getting bigger",
        23 : "Baby is getting bigger",
        24 : "Baby is getting bigger",
        25 : "Baby is getting bigger",
        26 : "Baby is getting bigger",
        27 : "Baby is getting bigger",
        28 : "Baby is getting bigger",
        29 : "Baby is getting bigger",
        30 : "Baby is getting bigger",
        31 : "Baby is getting bigger",
        32 : "Baby is getting bigger",
        33 : "Baby is getting bigger",
        34 : "Baby is getting bigger",
        35 : "Baby is getting bigger",
        36 : "Baby is getting bigger",
        37 : "Baby is getting bigger",
        38 : "Baby is getting bigger",
        39 : "Baby is getting bigger",
        40 : "Baby is getting bigger",
        41 : "Baby is getting bigger",
        42 : "Baby is getting bigger"
    ]
    
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
    
     func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? WeekTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    // viewDidLoad and viewWillAppear
 override var prefersStatusBarHidden: Bool {
       return true
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tabBar.isEnabled = false
        
        
        
        weeklyTableView.alpha = 0
        animateIn()
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        if mothersNameField.isEditing == true {
            mothersNameField.becomeFirstResponder()
        }
        mothersNameField.delegate = self
   weeklyTableView.allowsSelection = false
         //weeklyTableView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    
        let dueDate = UserDefaults.standard.object(forKey: "DueDate") as? Date ?? Date()
        
        let now = Date()
        let diffInDays = Calendar.current.dateComponents([.day], from: now, to: dueDate).day
        
        let weeksLeft : Int = diffInDays!/7
        let remainderDays : Int = diffInDays!%7
        let weeksElapsed : Int = 40 - weeksLeft
        let remainderDaysElapsed : Int = 7 - remainderDays
        print("Your partner is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
        print("this is the due date: \(dueDate)")
//        weekCollectionView.reloadData()
        
        selectionTag = 0
        print("the new selection tag = \(selectionTag)")
        self.navigationController?.isNavigationBarHidden = true
        selectedPerson = ""

        let displayedWeeksElapsed = weeksElapsed - 3 ?? 0
        
        if displayedWeeksElapsed <= 40 && displayedWeeksElapsed >= 4 {
        let indexPath = IndexPath(row: displayedWeeksElapsed, section: 0)
       weeklyTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
       (at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
        } else if displayedWeeksElapsed <= 3 {
            let indexPath = IndexPath(row: 0, section: 0)
           weeklyTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
        }
            }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is articlesForTodayViewController {
            print("to articles")
        } else {
            let tag = segue.destination as? ThisWeekViewController
            tag?.selectedTag = selectionTag
        }
    }

   
  
    
    
    
    
    
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        self.centerTable()
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            self.centerTable()
//        }
//    }
//
//    func centerTable()
//    {
//        let midX:CGFloat = self.weeklyTableView.bounds.midX
//        let midY:CGFloat = self.weeklyTableView.bounds.midY
//        let midPoint:CGPoint = CGPoint(x: midX, y: midY)
//
//        if let pathForCenterCell:IndexPath = self.weeklyTableView .indexPathForRow(at: midPoint)
//        {
//            self.weeklyTableView.scrollToRow(at: pathForCenterCell, at: .middle, animated: true)
//        }
//    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//extension decoderCollectionViewController: UIScrollViewDelegate {
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.decoderCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        let roundedIndex = round(index)
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//    }

//}
//extension UITableView {
//    func scrollToNearestVisibleTableViewCell() {
//        self.decelerationRate = UIScrollViewDecelerationRateNormal
//        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.height / 2))
//        var closestCellIndex = -1
//        var closestDistance: Float = .greatestFiniteMagnitude
//        for i in 0..<self.visibleCells.count {
//            let cell = self.visibleCells[i]
//            let cellWidth = cell.bounds.size.height
//            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
//
//            // Now calculate closest cell
//            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
//            if distance < closestDistance {
//                closestDistance = distance
//                closestCellIndex = self.indexPath(for: cell)!.row
//            }
//        }
//        if closestCellIndex != -1 {
//            self.scrollToRow(at: IndexPath(row:closestCellIndex, section: 0), at: .middle, animated: true)
//        }
//    }
//}

extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func buttonFunction(sender: UIButton){
        print(sender.tag)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 5
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if indexPath.item == 0 {
//            weeklyTableView.isScrollEnabled = true
            print("this is the collection view tag: \(collectionView.tag)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeekCollectionViewCell

          

//                        cell.rightArrow.tag = indexPath.row
//                        cell.rightArrow.addTarget(self,
//                                                  action: #selector(self.buttonFunction(_:)),
//                                                  for: .touchUpInside)
//            

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
                        cell.babyHeight.text = "0g/0oz"
                        cell.babyWeight.text = "0cm/0in"
                    }
            
            
            let baby = UserDefaults.standard.string(forKey: "baby") ?? "your baby"

                    if baby.isEmpty == true {
                        cell.babySize.text = "your baby is \(sizeComparison)"
                    } else {
                    cell.babySize.text = "\(baby) is \(sizeComparison)"
                    }
            
            return cell

        } else {
//            weeklyTableView.isScrollEnabled = false
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! WeekCollectionViewCell2

//            let mother : String  = UserDefaults.standard.string(forKey: "mother") ?? "Your partner"
           // let baby : String = UserDefaults.standard.string(forKey: "baby") ?? "Your baby"

            if indexPath.item == 1 {
                  let baby : String = UserDefaults.standard.string(forKey: "baby") ?? "Your baby"
                let mother : String  = UserDefaults.standard.string(forKey: "mother") ?? "Your partner"
                
                cell.personIcon.image = #imageLiteral(resourceName: "fetusIcon")

                 var babyWeeks : [Int : String] = [
                1 : "Baby is not yet in existence",
                2 :"""
                Baby is not yet in existence
                """,
                3 : """
                When men ejaculate, they release around 100 million sperm. Of these, only a few hundred actually reach the woman’s egg. On the surface of the egg are receptors which make sure only one sperm gets in.
                """,
                4 : """
                Your baby is only just about real and you could only just about see it with the naked eye
                """,
                5 : """
                Congratulations! You’re going to be a Big Daddy!
                    
                Your baby may only be the size of a peppercorn, but he or she is doing some serious growing. Incredibly, their heart is already functioning and blood is starting to circulate around their body. Their brain and spinal cord are also developing, and a string of blood vessels – which will eventually become the baby’s umbilical cord – connects the baby to \(mother).  This umbilical cord is a life line which will deliver essential oxygen and nutrients from \(mother) to baby.

                """,
                6 : """
                Find yourself wondering whether your baby will inherit Uncle Tim’s unusually large ears? This week, your baby’s facial features are starting to develop and they have a thin layer of transparent skin. Having said that, don’t get too excited yet. With a bump for their head, buds for arms and legs and a tail, your baby still looks more like a tadpole than anything else.
                    
                The baby’s little heart is beating at around 100 beats per minute (our resting heart rate is usually between 60 and 80) and could even be seen on a vaginal ultrasound around now.

                """,
                7 :"""
                This week, your peanut is fast becoming a little brain box! Their head is growing faster than [X] to make room for their expanding and increasingly complex brain. It won’t be too long before their brain will start to process sounds and light from inside \(mother)’s uterus. In other news, your baby’s inner ear is starting to develop and their arms and legs are getting longer. Their sex organs are also taking shape, but don’t start painting the nursery yet - it’s still too early to tell on a scan whether they’re a boy or a girl.
                """,
                8 : """
                Breaking news: this week, your baby’s tail has almost completely disappeared! Phew. Their tail will be replaced by their tailbone (coccyx), which is at the base of their spine. Your baby’s limbs are getting longer still, and there are notches visible on their hands where tiny little fingers will develop. Their facial features are becoming more defined, and their eyes have tiny eyelids.
                """,
                9 : """
                This is a big week for your little [X]: all their body parts are now present! Although your baby doesn’t look like a tadpole any more, their fingers and toes are still webbed, Kermit-style. Your baby’s eyes are getting bigger and their mouth and tongue are developing quickly, with tiny tastebuds starting to appear. \(mother)’s placenta is almost fully functioning and will soon provide vital nutrients to your baby.
                """,
                10 : """
                This week, your little chilli pepper has got more moves than Jagger as they discover that they can wriggle their arms and legs. Your baby is too small for \(mother) to feel these jerky movements quite yet, but it will only be a couple of months before those first flutters are felt.
                    
                Amazingly, your baby’s jawbones already contain all of their milk teeth. Their heart is fully developed and is beating at around 180 beats per minute – that’s up to three times the speed of yours.

                """,
                11 : """
                Good news: your baby now looks less like E.T. and more like a miniature human. They have developed almost all of their critical organs and body parts, and will spend the next six months getting bigger, stronger and ready for the outside world. Your baby’s fingers and toes are no longer webbed, and they even have tiny fingernails. Their eyelids have grown, and their eyes will stay closed for another few months.
                """,
                12 : """
                Baby is not yet in existence
                """,
                13 :"""
                Baby is not yet in existence
                """,
                14 : """
                Baby is not yet in existence
                """,
                15 : """
                Baby is not yet in existence
                """,
                16 : """
                Baby is not yet in existence
                """,
                17 : """
                Baby is not yet in existence
                """,
                18 : """
                Baby is not yet in existence
                """,
                19 : """
                Baby is not yet in existence
                """,
                20 : """
                Baby is not yet in existence
                """,
                21 : """
                Baby is not yet in existence
                """,
                22 : "Baby is getting bigger",
                23 : "Baby is getting bigger",
                24 : "Baby is getting bigger",
                25 : "Baby is getting bigger",
                26 : "Baby is getting bigger",
                27 : "Baby is getting bigger",
                28 : "Baby is getting bigger",
                29 : "Baby is getting bigger",
                30 : "Baby is getting bigger",
                31 : "Baby is getting bigger",
                32 : "Baby is getting bigger",
                33 : "Baby is getting bigger",
                34 : "Baby is getting bigger",
                35 : "Baby is getting bigger",
                36 : "Baby is getting bigger",
                37 : "Baby is getting bigger",
                38 : "Baby is getting bigger",
                39 : "Baby is getting bigger",
                40 : "Baby is getting bigger",
                41 : "Baby is getting bigger",
                42 : "Baby is getting bigger"
                ]
                
                
                
                cell.textView.text = babyWeeks[collectionView.tag + 3]
            } else if indexPath.item == 2 {
                   let mother : String  = UserDefaults.standard.string(forKey: "mother") ?? "Your partner"
                var motherWeeks : [Int : String] = [
                    1 : "Baby is not yet in existence",
                    2 :"""
                    Baby is not yet in existence
                    """,
                    3 : """
                    Sorry, but your baby isn't even in existence yet...
                    """,
                    4 : """
                    This week, \(mother)’s period is due. And if there’s a bun in the oven, that period will be AWOL. Her body will be starting to produce a hormone called human chorionic gonadotrophin (hCG) - which is what triggers the positive result on a pregnancy test.
                    
                    \(mother) might be feeling a bit tired and moody which - confusingly - might be how she normally feels around this time of the month. It’s a bit of waiting game until that all-important pregnancy test.
                    
                    Some pregnancy tests are highly sensitive, and claim to give a reliable reading on the first day of the missed period. But if the test is negative, it’s so early that it doesn’t necessarily mean she’s not pregnant.
                    """,
                    5 : """
                    Shit just got real - \(mother)’s period is MIA and you’ve very likely got a positive result on a pregnancy test.
                    
                    \(mother) might be feeling a bit tired, and increased blood flow to her breasts could leave them feeling a bit sensitive or tender. It’s possible that she might notice a tiny bit of light bleeding when she goes to the toilet around now. It’s really important that \(mother) starts taking a folic acid supplement until she’s 12 weeks pregnant, as this will help the baby’s nervous system to develop properly and prevent defects such as spina bifida.

                    """,
                    6 : """
                    \(mother) doesn’t look pregnant at all, but she may be starting to feel different. Hormone changes and increased blood flow to her kidneys may mean more overnight trips to the toilet.
                    
                    Up to 9 out of 10 pregnant women suffer from morning sickness or nausea, so chances are \(mother) will start feeling a little green around the gills over the next few weeks. If she’s vomiting more than Regan-The-Exorcist-MacNeil, and can’t keep anything down, she should go to her GP. Around 1 in 100 pregnant women suffer from a condition called hypermeresis gravidarum (made famous by Kate of Kate’n’Wills), where they vomit so much that they may need hospital treatment. Even if it’s not that severe, if \(mother) is struggling with sickness or feeling nauseous, her GP may be able to help by prescribing anti-sickness tablets or suggesting ways to cope with the symptoms. Have a look at our morning sickness article for some tips.

                    """,
                    7 :"""
                    This week, \(mother) might start to feel some twinges in her belly, as her uterus begins to expand. If she feels any sort of pain in her tummy, or has more than a tiny amount of bleeding, she should go to her GP. Chances are, it’s nothing to worry about, but it’s better to get it checked as it can be an early sign of miscarriage.
                    
                    If she’s feeling greener than Slimer, try making her a cup of stomach-settling ginger tea. You can either buy ginger teabags, or just add boiling water to a tablespoon of chopped fresh ginger.
                    """,
                    8 : """
                    Varicose veins are common in pregnancy, and \(mother) might start to notice one or two developing on her legs. Varicose veins are just where blood collects in veins and makes them bulge a bit. They usually don’t cause serious problems, but \(mother) should mention them to her midwife at her next appointment.
                    
                    Soon, \(mother) will be having her first antenatal appointment - called the Booking Appointment. At this appointment, a midwife will just ask her straightforward questions about her medical history and lifestyle, and will calculate the approximate due date of your baby (although this date won’t be confirmed until the first scan). The midwife will also measure \(mother)’s BMI, take her blood pressure and a urine sample, and do some blood tests. At the end of the appointment, the midwife will give \(mother) her all-important maternity notes - these need to be kept safe as she’ll need to take them to every appointment, and eventually the birth!

                    """,
                    9 : """
                    You might notice \(mother)’s breasts are starting to get larger. This is because pregnancy hormones cause the fat in breasts to get thicker, and the milk ducts to multiply, ready for breastfeeding.
                    
                    This week, the combination of tiredness and nausea might be starting to get \(mother) down. If you think she might be feeling a bit low, why not suggest a date night. If she doesn’t feel like going out, you could surprise her with a night in with her favourite dinner (one that won’t make her retch at the smell) and a feel-good film.

                    """,
                    10 : """
                    Headaches and dizziness are really common in pregnancy, but \(mother) should make sure she doesn’t take ibuprofen (such as Nurofen) or aspirin. If she needs a painkiller, paracetamol should do the trick.
                    
                    \(mother)’s nausea and tiredness might be getting more intense. If she’s feeling down about it, reassure her that these symptoms should start getting much better soon. In fact, many women feel better than ever once they reach the second trimester - which is only a few weeks away!

                    """,
                    11 : """
                    Baby is not yet in existence
                    """,
                    12 : """
                    Baby is not yet in existence
                    """,
                    13 :"""
                    Baby is not yet in existence
                    """,
                    14 : """
                    Baby is not yet in existence
                    """,
                    15 : """
                    Baby is not yet in existence
                    """,
                    16 : """
                    Baby is not yet in existence
                    """,
                    17 : """
                    Baby is not yet in existence
                    """,
                    18 : """
                    Baby is not yet in existence
                    """,
                    19 : """
                    Baby is not yet in existence
                    """,
                    20 : """
                    Baby is not yet in existence
                    """,
                    21 : """
                    Baby is not yet in existence
                    """,
                    22 : "Baby is getting bigger",
                    23 : "Baby is getting bigger",
                    24 : "Baby is getting bigger",
                    25 : "Baby is getting bigger",
                    26 : "Baby is getting bigger",
                    27 : "Baby is getting bigger",
                    28 : "Baby is getting bigger",
                    29 : "Baby is getting bigger",
                    30 : "Baby is getting bigger",
                    31 : "Baby is getting bigger",
                    32 : "Baby is getting bigger",
                    33 : "Baby is getting bigger",
                    34 : "Baby is getting bigger",
                    35 : "Baby is getting bigger",
                    36 : "Baby is getting bigger",
                    37 : "Baby is getting bigger",
                    38 : "Baby is getting bigger",
                    39 : "Baby is getting bigger",
                    40 : "Baby is getting bigger",
                    41 : "Baby is getting bigger",
                    42 : "Baby is getting bigger"
                ]
                
                
                cell.textView.text = motherWeeks[collectionView.tag + 3]
                     cell.personIcon.image = #imageLiteral(resourceName: "femaleIcon")
            } else if indexPath.item == 3 {
                cell.textView.text = factWeeks[collectionView.tag + 3]
            } else {
                cell.textView.text = "screen4"
            }

            return cell
        }
     
    }

    }


extension TodayViewController {
    
    func animateIn() {
        
        self.view.addSubview(setupPopup)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.weeklyTableView.alpha = 0.0
        }, completion: nil)
      //  mothersNameField.becomeFirstResponder()
        self.tabBarItem.isEnabled = false
        setupPopup.center.x = self.view.center.x
        setupPopup.frame.origin.y = self.view.frame.height / 4
        setupPopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        setupPopup.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.setupPopup.alpha = 1
            self.setupPopup.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        
        self.setupPopup.removeFromSuperview()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.weeklyTableView.alpha = 1.0
        }, completion: nil)
        let dueDate = UserDefaults.standard.object(forKey: "DueDate") as? Date ?? Date()
        
        let now = Date()
        let diffInDays = Calendar.current.dateComponents([.day], from: now, to: dueDate).day
        
        let weeksLeft : Int = diffInDays!/7
        let remainderDays : Int = diffInDays!%7
        let weeksElapsed : Int = 40 - weeksLeft
        let remainderDaysElapsed : Int = 7 - remainderDays
        print("Your partner is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
        print("this is the due date: \(dueDate)")
        //        weekCollectionView.reloadData()
//
//        selectionTag = 0
//        print("the new selection tag = \(selectionTag)")
//        self.navigationController?.isNavigationBarHidden = true
//        selectedPerson = ""
         let displayedWeeksElapsed = weeksElapsed - 3 ?? 0
        let indexPath = IndexPath(row: displayedWeeksElapsed, section: 0)
        weeklyTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
        (at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
 
     //   mothersNameField.resignFirstResponder()
    }
}



