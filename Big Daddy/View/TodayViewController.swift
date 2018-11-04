//
//  TodayViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var sizingView: UIView!
    var viewCount = 0
    
    // MARK:- Code for the Setup Popup
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet var setupPopup: UIView!
    @IBOutlet weak var mothersNameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBAction func skipPressed(_ sender: Any) {
       
       print("skip pressed")
        UserDefaults.standard.set("your partner", forKey: "mother")
        let calendar = Calendar.current
        var component = DateComponents()
        component.day = -280
        let calculatedDate = calendar.date(byAdding: component, to: Date())
        UserDefaults.standard.set(Date(), forKey: "DueDate")
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
            
            if weeksLeft >= 40 {
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
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
            
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDaysElapsed : Int = 7 - remainderDays
            if weeksLeft >= 40 {
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
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
    
    // Setup the arrays and dictionaries
    
    let babySizeImageArray = ["week0-3", "week4", "week5", "week6", "week7", "week8", "week9", "week10", "week11", "week12", "week13", "week14", "week15", "week16", "week17", "week18", "week19", "week20", "week21", "week22", "week23", "week24", "week25", "week26", "week27", "week28", "week29", "week30", "week31", "week32", "week33", "week34", "week35", "week36", "week37", "week38", "week39", "week40", "week41", "week42"]
    let babySizeLabelArray = ["still in beta", "the size of a grain of salt", "the size of a peppercorn", "the size of a snowflake", "the size of a peanut", "the size of a bee", "the size of an eyeball", "the size of a maki roll", "the size of a poker chip", "the size of a chicken nugget", "the size of a tennis ball", "the size of a deck of cards", "the size of a big mac", "the size of a can of coke", "the size of a pair of aviators", "the size of an iPhone 8", "the size of a pint", "the height of a beer bottle", "the length of a tube of pringles", "the size of a trowel", "the length of a sheet of A4", "the height of a bottle of wine", "the size of a hammer", "the size of a violin", "the weight of War and Peace", "the size of X", "the weight of a tomahawk steak", "the size of a steering wheel", "the weight of an adult brain", "the weight of a roast chicken", "the size of a vinyl player", "the size of a dartboard", "the size of a small octopus", "the size of a brick", "the height of a car tyre", "the size of X", "the length of a wood saw", "the length of a full rack of ribs"]
    let weightArray = ["week1to3", "0.01g", "0.2g", "0.4g", "0.8g", "1g", "2g", "4g", "8g", "14g", "23g", "45g", "70g", "100g", "140g", "190g", "240g", "300g", "360g", "430g", "500g", "600g", "660g", "760g", "875g", "1kg", "1.1kg", "1.3kg", "1.5kg", "1.7kg", "1.9kg", "2.1kg", "2.4kg", "2.6kg", "2.9kg", "3.1kg", "3.3kg", "3.5kg", "3.5kg", "3.5kg"]
    let lengthArray = ["week1to3", "1mm", "2mm", "4mm", "8mm", "1.6cm", "2.3cm", "3.4cm", "4.1cm", "5.4cm", "7.4cm", "8.5cm", "10.1cm", "11.6cm", "12.9cm", "14.2cm", "15cm", "25.6cm", "26.6cm", "27.8cm", "29cm", "30cm", "34.6cm", "35.6cm", "36.6cm", "37.6cm", "38.6cm", "39.9cm", "41.1cm", "42.4cm", "43.7cm", "45cm", "46.2cm", "47.4cm", "48.6cm", "49.8cm", "50.6cm", "51.2cm", "51.2cm", "51.2cm"]
  

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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return sizingView.frame.height
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
        
        let numberOfViews = UserDefaults.standard.object(forKey: "newViews") ?? 0
        //TODO:- Reinstate this to make viewcount work
        viewCount = numberOfViews as! Int
  
        
            
    if viewCount >= 2 {
                
        weeklyTableView.alpha = 1
//   datePicker.setValue(UIColor.white, forKeyPath: "textColor")
//        if mothersNameField.isEditing == true {
//            mothersNameField.becomeFirstResponder()
//        }
//        mothersNameField.delegate = self
//   weeklyTableView.allowsSelection = false
         //weeklyTableView?.decelerationRate = UIScrollViewDecelerationRateFast
      
            
            
         } else {
                
                
        
        //TODO:- Reinstate these 2 to make setup popup work
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
        super.viewWillAppear(animated)
        
    
        let dueDate = UserDefaults.standard.object(forKey: "DueDate") as? Date ?? Date()
        
        let now = Date()
        let diffInDays = Calendar.current.dateComponents([.day], from: now, to: dueDate).day
        
        let weeksLeft : Int = diffInDays!/7
        let remainderDays : Int = diffInDays!%7
        let weeksElapsed : Int = 40 - weeksLeft
        let remainderDaysElapsed : Int = 7 - remainderDays
    
//        weekCollectionView.reloadData()
        
        selectionTag = 0
     
        self.navigationController?.isNavigationBarHidden = true
        selectedPerson = ""

        let displayedWeeksElapsed = weeksElapsed - 3 ?? 0
        
        if displayedWeeksElapsed <= 40 && displayedWeeksElapsed >= 4 {
        let indexPath = IndexPath(row: displayedWeeksElapsed, section: 0)
   weeklyTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: false)
//       (at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
        } else if displayedWeeksElapsed <= 3 {
            let indexPath = IndexPath(row: 0, section: 0)
     weeklyTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: true)
        }
            }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is articlesForTodayViewController {
          
        } else {
            let tag = segue.destination as? ThisWeekViewController
            tag?.selectedTag = selectionTag
        }
    }


    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.centerTable()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.centerTable()
        }
    }

    func centerTable()
    {
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
        print(visibleCenterPositionOfScrollView)
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



extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("collection view is moving!")
    }
  
  
    func buttonFunction(sender: UIButton){
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 3
    }
   

  

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

     
        
//        if indexPath.item == 0 {
//            weeklyTableView.isScrollEnabled = true
//        } else {
//            weeklyTableView.isScrollEnabled = false
//        }
        
        if indexPath.item == 0 {
        // weeklyTableView.isScrollEnabled = true
            //print("this is the indexPath: \(indexPath.item)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeekCollectionViewCell
  
            print("this is the cell position: \(cell.contentView.frame.midX)")
            
                
          //  print("this is the visible index path: \(collectionView.indexPathsForVisibleItems)")

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
                        cell.babyHeight.text = "0cm"
                        cell.babyWeight.text = "0g"
                    }
            
            
            let baby = UserDefaults.standard.string(forKey: "baby") ?? "your baby"

                    if baby.isEmpty == true {
                        cell.babySize.text = "your baby is \(sizeComparison)"
                    } else {
                    cell.babySize.text = "\(baby) is \(sizeComparison)"
                    }
            
            return cell

        } else {
            
         
            
            
            //print("this is the visible index path: \(collectionView.indexPathsForVisibleItems)")
                   //   print("this is the indexPath: \(indexPath.item)")
     //  weeklyTableView.isScrollEnabled = false
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! WeekCollectionViewCell2

            
            
            
//            let mother : String  = UserDefaults.standard.string(forKey: "mother") ?? "Your partner"
           // let baby : String = UserDefaults.standard.string(forKey: "baby") ?? "Your baby"

            if collectionView.tag != 0 {
                let weekNumber = String(collectionView.tag + 3)
                cell.weekLabel.text = "WEEK \(weekNumber)"
            } else {
                let weekNumber = "0-3"
                cell.weekLabel.text = "WEEK \(weekNumber)"
                
            }
            
            
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
                Your baby is only just about real and you could only just about see it with the naked eye.
                """,
                5 : """
                Congratulations! You’re going to be a Big Daddy!
                    
                Your baby may only be the size of a peppercorn, but he or she is doing some serious growing. Incredibly, their heart is already functioning and blood is starting to circulate around their body. Their brain and spinal cord are also developing, and a string of blood vessels – which will eventually become the baby’s umbilical cord – connects the baby to \(mother).  This umbilical cord is a life line which will deliver essential oxygen and nutrients from \(mother) to baby.

                """,
                6 : """
                Find yourself wondering whether your baby will inherit Uncle Tim’s unusually large ears? This week, your baby’s facial features are starting to develop and they have a thin layer of transparent skin. Having said that, don’t get too excited yet. With a bump for their head, buds for arms and legs and a tail, your baby still looks more like a tadpole than anything else.
                    
                Your baby’s little heart is beating at around 100 beats per minute (our resting heart rate is usually between 60 and 80) and could even be seen on a vaginal ultrasound around now.

                """,
                7 :"""
                This week, your peanut is fast becoming a little brain box! Their head is growing faster than [X] to make room for their expanding and increasingly complex brain. It won’t be too long before their brain will start to process sounds and light from inside \(mother)’s uterus. In other news, your baby’s inner ear is starting to develop and their arms and legs are getting longer. Their sex organs are also taking shape, but don’t start painting the nursery yet – it’s still too early to tell on a scan whether they’re a boy or a girl.
                """,
                8 : """
                Breaking news: this week, your baby’s tail has almost completely disappeared! Phew. Their tail will be replaced by their tailbone (coccyx), which is at the base of their spine. Your baby’s limbs are getting longer still, and there are notches visible on their hands where tiny little fingers will develop. Their facial features are becoming more defined, and their eyes have tiny eyelids.
                """,
                9 : """
                This is a big week for your little eyeball: all their body parts are now present! Although your baby doesn’t look like a tadpole any more, their fingers and toes are still webbed, Kermit-style. Your baby’s eyes are getting bigger and their mouth and tongue are developing quickly, with tiny tastebuds starting to appear. \(mother)’s placenta is almost fully functioning and will soon provide vital nutrients to your baby.
                """,
                10 : """
                This week, your baby has got more moves than Jagger as they discover that they can wriggle their arms and legs. \(mother) won't be able to feel these jerky movements quite yet, but it will only be a couple of months before those first flutters are felt.
                    
                Amazingly, your baby’s jawbones already contain all of their milk teeth. Their heart is fully developed and is beating at around 180 beats per minute – that’s up to three times the speed of yours.

                """,
                11 : """
                Good news: your baby now looks less like E.T. and more like a miniature human. They have developed almost all of their critical organs and body parts, and will spend the next six months getting bigger, stronger and ready for the outside world. Your baby’s fingers and toes are no longer webbed, and they even have tiny fingernails. Their eyelids have grown, and their eyes will stay closed for another few months.
                """,
                12 : """
                This week, your baby is the size of a chicken nugget (or an average-sized human testicle, if you prefer). Their face is perfectly formed – their eyes have moved closer together and they even have tiny little lobes on their ears. Your baby is busy practising their facial expressions, and can even now open their mouth, yawn, hiccup and swallow. At the moment, their skeleton is made up of rubbery cartilage (like your own ear or nose), but will now start to harden into bone.
                """,
                13 :"""
                    It’s still way too early to be able to tell on a scan whether you’re having a little boy or girl, but your baby’s sex organs are now fully developed. Their toes are now fully formed and their unique fingerprints are starting to show. Your baby’s head now accounts for around a third of its whole length, as the part of the brain responsible for problem solving and memory is starting to develop.
                    """,
                14 : """
                    This week, your baby is starting to drink their own urine. We know – is that really necessary? Actually, it is. Your baby swallows the amniotic fluid and it passes out again as urine. And then they swallow it again. And again. This not only helps their lungs to develop, but also allows their newly functioning kidneys to start doing their job. (On the other hand, perhaps they just do it because it’s sterile and they like the taste).
                    
                    Your baby is also sprouting fine hairs all over their body and head. This hair is called lanugo and is thought to help regulate your baby’s temperature inside the womb.
                    
                """,
                15 : """
                    Whether you’re into deep house or light opera, it’s time to put the music on – this week, your baby can hear muffled sounds from the outside world as well as the sound of \(mother)’s voice, heart and tummy. Even though your baby’s eyes are still closed, they are becoming sensitive to light shining on \(mother)’s bump. That’s right – get the disco lights on and start singing to your baby.
                    
                    Your baby’s body parts are all now present, and they are practising inhaling and exhaling the amniotic fluid. Who are we kidding? It’s wee. They’re practising swallowing the wee.
                    
                """,
                16 : """
                This week, your baby is getting a big workout as they start to flex their muscles and build up strength in their limbs. Their hands can form a fist and their neck is strong enough to sit upright on their body. Over the next few weeks, your baby will have a massive growth spurt.
                """,
                17 : """
                A fatty substance known as myelin has started to cover your baby’s spinal cord. This is an important stage in their development, as it helps messages from the nerves to the brain to travel as quickly as possible. Their hearing is becoming more and more sensitive, and they may start to respond to loud noises in the outside world by kicking, wriggling or punching. Your baby’s facial features are becoming even more defined, and their eyebrows and eyelashes are starting to grow. Their eyes are moving around under those tightly shut eyelids.
                """,
                18 : """
                Who ate all the pies? \(baby), apparently! This week, they’re piling on the pounds and now have a little layer of fat under their skin. They still look pretty wrinkly, although their ears have finally moved up from the jawline into a more usual position. Girl-babies now have immature eggs developing in their ovaries, and have a fully-formed vagina, womb and fallopian tubes. Boybies’ testicles are moving down and their tiny penis is fully formed. If you’re planning on finding out the sex of your baby, those all-important details should now be visible on a scan.
                """,
                19 : """
                This week, your baby’s eyes are in their final position and are making random movements under their eyelids. Their arms and legs are now in proportion to the rest of their body. If you (like many dads-to-be) are mourning the loss of your shiny locks, try not to be envious of the hairs sprouting from your baby’s scalp this week. Your baby’s brain is developing rapidly, and is starting to form distinct areas for processing different senses, from sight to smells.
                """,
                20 : """
                    At the moment, your baby’s skin is covered in a greasy, cheesy substance called vernix. This protects the baby’s skin from the effects of spending months floating around in amniotic fluid and (you might want to look away now if you’re squeamish) acts as a lubricant during birth. Lovely. On a less gruesome note, your baby’s milk and adult teeth are now in place under their gums.
                    
                """,
                21 : """
                    This is a milestone week for your baby, as it’s the first time that they weigh more than \(mother)’s placenta. #babygoals. Both baby and placenta (and \(mother)) will keep growing throughout the pregnancy, but the baby will keep getting bigger and bigger than the placenta.
                    
                    Your baby is now also covered in downy hair, called lanugo. No-one really knows why babies grow lanugo, but it’s possible that it could be to keep the baby’s temperature just right. But before you start worrying that they’ll come out hairier than Chewbacca, rest assured that lanugo usually disappears before birth, although it might be visible in very premature babies.
                """,
                22 : """
                    This week, your baby is busy creating its first poo. This black, sticky poo (known as meconium) is made up of all the things your baby is eating in the womb – from amniotic fluid to dead skin cells. This milestone first poo will be stored in the baby’s bowels until they’re born.
                    
                    In other news, your baby now looks like a miniature newborn as all their body parts are fully present and correct. Their bones contain bone marrow, which is crucial for producing blood cells. And like a baby POTUS, their tiny hands are moving constantly.
                    
                    """,
                23 : """
                    Your baby’s hearing is getting better with every day. Now they can hear sounds from near and far – from the sound of your voice (and snores and farts) to the sound of fireworks. Their ears can now send signals to their brain whenever they hear a sound, and will soon start to respond to more sounds by kicking and wriggling. Once they do, you can have a competition with \(mother) to see whose music your baby prefers. (And if the baby wriggles more to her music, you can always say that kicking means they want it to stop).
                    
                    Your baby’s lungs still don’t work properly, and they are getting all the oxygen they need from the placenta. This doesn’t stop them practising their breathing movements by swallowing more amniotic fluid, though. Before now, your baby’s liver and spleen were producing their red blood cells; this job has now been taken over by their bone marrow.
                    
                    """,
                24 : """
                    It’s another milestone week for your baby, as they may now be able to survive outside the womb with specialist care. Their skin is still pretty translucent, but is becoming more resilient every day. Their heart rate has slowed down a little, but at 140 beats per minute, it’s still a lot faster than yours. Their eyelids are still closed, and their bones are getting harder and harder.
                    """,
                25 : """
                    This week, you might notice your baby becoming more responsive to noises and sensations from the outside world. Their hearing is now really acute, so loud noises might make them startle. They also might start turning their head to a light shining on the bump. Their head is still a bit too large for their body, but they’re making up for it by practising awesome facial expressions such as frowning.
                    """,
                26 : """
                    
                    We’re telling you now – there is almost nothing cuter (and more hilarious) than a baby with hiccups. Amazingly, babies in the womb get hiccups too. \(mother) will probably notice it first, but as her bump grows bigger you might even be able to see or feel the tiny twitches of hiccups.
                    
                    This week, tiny air sacs are developing in your baby’s lungs – this will help them to absorb oxygen into their blood after they’re born. Your baby’s hand-eye co-ordination is improving every day, and they often bring their hands and feet to their mouth. Incredibly, your baby’s tastebuds are now fully developed.
                    
                    """,
                27 : """
                    It’s the final week of the second trimester! This week, your baby’s eyes are finally open – not that there’s a lot for them to see at the moment. Soon, they’ll start learning how to blink. Your baby’s lungs are still developing, and a substance called surfactant is starting to coat the inside of the lungs. This stops their airways from sticking together, so that the tiny air sacs can inflate properly once they’re born and take their first breaths.
                    
                    Your baby is now getting into a regular cycle or waking and sleeping, and may even begin to dream soon.
                    
                    """,
                28 : """
                    It’s a big week – welcome to the third (and final) trimester! Your baby is now perfectly formed, and is taking up quite a lot of space inside \(mother). At around this stage, many babies start to turn head down in the womb, to get ready for birth. The midwife or GP will tell \(mother) at her antenatal appointments what position the baby is in, but don’t worry if they’re not head down yet – there’s still plenty of time (and room) for them to keep changing position over the next few weeks.
                    
                    Your baby’s eyebrows and eyelashes are growing longer every day, as is the hair on their head (don’t be jealous, now). Their lungs are still developing, but your baby has a rhythmic pattern of breathing the amniotic fluid in and out.
                    
                    """,
                29 : """
                    Your baby is piling on the pounds at the moment, and is probably being very active. Their hearing is now excellent, and \(mother)’s voice and heartbeat is starting to become familiar to them. If you keep talking to the bump regularly, they may even recognize your voice and be soothed by it after they’re born.
                    
                    Try putting your ear to \(mother)’s bump every now and then – if it’s in exactly the right position, you might be able to hear your baby’s heartbeat.
                    
                    """,
                30 : """
                    This week, your baby’s brain is growing rapidly and is developing into distinct areas. Each of these areas will be responsible for processing different things, from memories to movement and emotions. The amniotic sac has now stopped growing, and will just keep on stretching as the baby gets bigger and bigger.
                    """,
                31 : """
                    By now, 75% of babies are in a head down position. But don’t worry if your baby isn’t; a bit like Tom Daley mid-dive, there’s still time for them to turn.
                    
                    Your baby has now developed their sucking reflex, and is probably sucking away on their thumb and fingers. Their eyes can now focus, although it’s pretty dark and murky in there so there isn’t much by way of entertainment. Your baby’s lungs are still developing, and although they still wouldn’t be able to breathe on their own if they were born now, they’re not far off.
                    
                    """,
                32 : """
                    A bit of good news this week: if your baby is born now, they have an excellent chance of thriving. Their vital organs are all in situ, and just need a little bit more time for fine tuning.
                    
                    From now on, your baby is concentrating on chubbing up. They’ll still get a bit longer before they’re born, but the rate of length growth has slowed down. All this growing means there’s a lot less space to move around in. The vernix (that greasy, cheesy substance) and lanugo (the downy hair) have started to disappear, and their skin looks a lot less translucent as they put more and more weight on.
                    
                    """,
                33 : """
                    This week, your baby’s brain and nervous system is fully developed. All of their bones are continuing to harden except for the skull (which stays soft to help it squeeze through the birth canal. Sorry. TMI.). Their fingernails are growing well, and may even now reach the top of their fingers.
                    """,
                34 : """
                    Even better news this week – most babies born now are in rude health. Their lungs are still not completely developed, but any breathing problems they have after birth are usually easy to treat.
                    
                    Your baby is probably now in their final position for birth, and the amount of amniotic fluid around them won’t now increase any more. Your baby’s hearing is more acute than ever, and they’re probably enjoying listening in on every conversation, Watergate-style, and picking up on familiar sounds.
                    
                    """,
                35 : """
                    From now on, your baby is focused on getting as chubby as possible before the big day. In fact, over the next few weeks, they’ll gain almost 30 grams per day. That’s more than the weight of an AA battery every day.
                    
                    Your baby’s eyes now dilate in the light, which will help them prepare for the dazzling world outside the abyss. They’re practising their sucking movements to help them feed in the big wide world, and are so short of room that they’re now curled up tightly. Try watching \(mother)’s bump when she says the baby is moving and you might even be able to see it.
                    
                    """,
                36 : """
                    This week, your baby’s lungs and digestive system are finally fully developed. This means they’ll be able to breathe and feed on their own whenever they’re born. There won’t be much of that downy lanugo and greasy vernix over their body, but there might still be patches visible now.
                    
                    Your baby doesn’t have much room left at all now, and their head may now have started to “engage” (when it drops into a lower position, ready for birth). If you’re having a boy, his testes are starting to descend into his scrotum.
                    
                    """,
                37 : """
                    This is a big week – even though the due date is still three weeks away, your baby is now full term! He or she is busily gaining weight, practising frowns and pouts and may even be turning towards familiar sounds.
                    
                    Your baby’s gut now contains plenty of meconium (that epic first poo), and the downy lanugo hair all over your baby’s body has almost all been replaced with very fine vellus hairs instead.
                    
                    """,
                38 : """
                    This week, your baby’s bones have all hardened and their organs are fully developed. They have a strong grasp reflex and might even be holding onto their own umbilical cord. It’s only a matter of days now until that tiny hand will be clutching your finger.
                    """,
                39 : """
                    Even though your baby’s eyes are completely developed, they won’t be able to see far at all until a few weeks after they are born. [REF – LIVING IN A BLURRY WORLD].
                    
                    Their lungs are working well and they are taking around forty rhythmical breaths every minute. This baby is ready to join the world (and \(mother) is probably more than ready to evict them).
                    
                    """,
                40 : """
                    This week, your baby is around the same length as its umbilical cord. Or a rack of ribs. Whichever you prefer. And even though their eviction notice has been served, they don’t have any intention of slowing down. Even their hair and fingernails are growing, and the chances of them coming out looking like the love child of Wolverine and Rapunzel are increasing every day.
                    """
                ]
                
                cell.textView.setContentOffset(CGPoint.zero, animated: false)
           
                
                 cell.textView.isScrollEnabled = false
                cell.textView.text = babyWeeks[collectionView.tag + 3]
                 cell.textView.isScrollEnabled = true
                
            } else if indexPath.item == 2 {
                   let mother : String  = UserDefaults.standard.string(forKey: "mother") ?? "Your partner"
                var motherWeeks : [Int : String] = [
                    1 : "Baby is not yet in existence",
                    2 :"""
                    Baby is not yet in existence
                    """,
                    3 : """
                    Even though the pregnancy clock is ticking, these first 3 weeks don't count for anything - the sperm and the egg are still very much living their own separate lives right up until week 4.
                    """,
                    4 : """
                    This week, \(mother)’s period is due. And if there’s a bun in the oven, that period will be AWOL. Her body will be starting to produce a hormone called human chorionic gonadotrophin (hCG) – which is what triggers the positive result on a pregnancy test.
                    
                    \(mother) might be feeling a bit tired and moody which – confusingly – might be how she normally feels around this time of the month. It’s a bit of waiting game until that all-important pregnancy test.
                    
                    Some pregnancy tests are highly sensitive, and claim to give a reliable reading on the first day of the missed period. But if the test is negative, it’s so early that it doesn’t necessarily mean she’s not pregnant.
                    """,
                    5 : """
                    Shit just got real – \(mother)’s period is MIA and you’ve very likely got a positive result on a pregnancy test.
                    
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
                    
                    Soon, \(mother) will be having her first antenatal appointment – called the Booking Appointment. At this appointment, a midwife will just ask her straightforward questions about her medical history and lifestyle, and will calculate the approximate due date of your baby (although this date won’t be confirmed until the first scan). The midwife will also measure \(mother)’s BMI, take her blood pressure and a urine sample, and do some blood tests. At the end of the appointment, the midwife will give \(mother) her all-important maternity notes – these should be kept safe as she’ll need to take them to every appointment, and eventually the birth!

                    """,
                    9 : """
                    You might notice \(mother)’s breasts are starting to get larger. This is because pregnancy hormones cause the fat in breasts to get thicker, and the milk ducts to multiply, ready for breastfeeding.
                    
                    This week, the combination of tiredness and nausea might be starting to get \(mother) down. If you think she might be feeling a bit low, why not suggest a date night. If she doesn’t feel like going out, you could surprise her with a night in with her favourite dinner (one that won’t make her retch at the smell) and a feel-good film.

                    """,
                    10 : """
                    Headaches and dizziness are really common in pregnancy, but \(mother) should make sure she doesn’t take ibuprofen (such as Nurofen) or aspirin. If she needs a painkiller, paracetamol should do the trick.
                    
                    \(mother)’s nausea and tiredness might be getting more intense. If she’s feeling down about it, reassure her that these symptoms should start getting much better soon. In fact, many women feel better than ever once they reach the second trimester – which is only a few weeks away!

                    """,
                    11 : """
                    Pelvic floor exercises: contrary to what one BigDaddy believed, these are not lying-on-the-floor exercises. “No,” he told her midwife. “My wife has NOT being doing her pelvic floor exercises because I haven’t seen her on the floor once!”
                    
                    Actually, they’re really important exercises which \(mother) should do throughout her pregnancy to help reduce the risk of stress incontinence. She should squeeze her pelvic floor muscles (the ones she uses when she’s bursting for the loo and has to hold it in) for ten seconds, ten times in a row, three or four times per day. It’s your job to remind her to do them. And when you say you can’t be bothered, do you really want to have to mop up every time she laughs? Thought not.

                    """,
                    12 : """
                    Pregnancy gingivitis: a phenomenon which causes pregnant women’s hair to turn a fiery shade of red, or a term for bleeding gums in pregnancy? Disappointingly, it’s the gums. We know: the hair thing would be way more exciting.
                    
                    Bleeding gums in pregnancy is really common, as hormonal changes lead to a build up of plaque on the teeth. But the good news is that pregnant women in the UK are entitled to free dental care on the NHS. So make sure \(mother) gets her mumma mitts on a maternity exemption card (through her GP) and books an appointment, stat.

                    """,
                    13 :"""
                    By now, you will probably have seen your baby on an ultrasound scan and things might be starting to feel more real for both of you. Although \(mother) might still not have a bump (especially if this is her first baby), you won’t have long to wait before she’s starting to show.
                    
                    If \(mother) is still suffering from nausea and tiredness, keep reminding her that this is the final week of the first trimester and that she’ll start to feel better any day. In the meantime, make her a nice cup of tea. She deserves it.
                    """,
                    14 : """
                    This week, it’s the start of the second trimester and \(mother) may be starting to feel a bit brighter. Even if she’s still spending more time looking at the inside of the toilet bowl than you, it won’t be long before these special vomit-tinged days are a distant memory.
                    
                    Incredibly, \(mother)’s body is now starting to make a substance called colostrum, which is the baby’s first breastmilk. In the final weeks of pregnancy, she might even start to leak colostrum from her nipples. Sorry. Was that too much information?

                    """,
                    15 : """
                    Finally, those midnight loo trips may be a thing of the past for \(mother) as her uterus is moving up and away from her bladder. If she had trouble sleeping during the first trimester, she may now find it easier. This is good news for you, as a well-rested pregnant lady is not nearly as terrifying as a sleep-deprived pregnant lady.
                    """,
                    16 : """
                    Has \(mother) had any nosebleeds during her pregnancy? Weirdly, nosebleeds are really common in pregnant women. Pregnancy hormones will be making \(mother)’s blood vessels weaker, and increased blood flow in her body will be putting pressure on those vessels, which can cause nosebleeds. They’re nothing to be alarmed about, although they have a tendency to happen at the least convenient time possible. In fact, it’s pretty much guaranteed that they’ll happen during an important meeting or while \(mother) is wearing a white top, or both. Remind \(mother) to drink plenty of water!
                    """,
                    17 : """
                    This is it. Any day now, \(mother) will feel the baby move. To start with, it may feel more like fluttering movements or bubbles popping, rather than full-on roundhouse kicks. And you may not be able to feel anything at all until the baby is a little bit bigger. It’s a big moment, though. Definitely a reason to celebrate with an extra-large bar of chocolate.
                    """,
                    18 : """
                    It’s not your eyes; \(mother) is definitely looking a little more rounded. It’s best not to comment on it, though. If she’s feeling uncertain about her changing shape, remind her that her body is doing an amazing job of growing a tiny person, and she looks more beautiful than ever.
                    
                    \(mother) is going to get LOT bigger before the baby is born (again, perhaps don’t mention that), and that weight gain isn’t just the baby. By the time your baby is born, the amniotic fluid and placenta combined will weigh around 1.5kg, and all \(mother)’s extra blood, fluid, fat and increased breast size will weigh a whopping 7.7kg (that’s 17lb).
                    """,
                    19 : """
                    Around now, \(mother) might notice that she’s developing a dark vertical line (called a linea nigra) on her stomach. She might also get some darker patches (called chloasma) on her hands, neck or face. Both are completely normal during pregnancy, and happen because \(mother)’s body will be producing more melanin (the hormone which tans skin) during pregnancy. If \(mother) is self-conscious about them, reassure her that they’re really common and will usually disappear once the baby is born.

                    """,
                    20 : """
                    This week, \(mother) might be feeling some aches or cramps in her lower belly. This is just her ligaments stretching to make room for the growing baby. If it feels painful at all, or if \(mother) is worried about it, she should get in touch with her midwife.
                    
                    Don’t forget to compliment \(mother)’s hair this week. Hair loss slows down in pregnancy, which means that her hair may start to look thicker and shinier than ever. Even if it doesn’t, why not tell her it looks great anyway? She’ll never know, and it’ll make her smile.
                    """,
                    21 : """
                    As her bump grows, \(mother) might be struggling to get comfortable in bed and be starting to feel tired again. Help her to position pillows around her in bed – it might help to try one under the bump, one between her legs and even one by her back. We know – you’re going to need a bigger bed, chaps.
                    
                    Headaches are also really common around this time in pregnancy, but if \(mother) is getting severe or frequent headaches (or it’s accompanied by any pain, blurred vision or swelling in her hands and feet), she should see her GP or midwife as it could be a sign of pre-eclampsia.

                    """,
                    22 : """
                    \(mother) is now sporting a spectacular bump and is beginning to look properly pregnant. She might start getting some stretch marks around her breasts, bump or legs. If \(mother) is worried about these, you can reassure her that they are incredibly common and that they’ll fade to a silvery-grey colour after the baby is born. Reiterate that she’s doing an amazing job of growing a person and make her another cup of tea. Quickly.
                    """,
                    23 : """
                    This week, you can compliment \(mother) on her radiant skin. “Wow!” you can say. “Your skin looks amazing at the moment!” Cue big smile. Now that she’s well over half way through her pregnancy, \(mother) has more blood pumping round her body and her skin is retaining more moisture. So, chances are her skin really does look great. What’s the harm, eh?
                    
                    \(mother)’s bump is getting bigger, and she might start to suffer from backache as her body adjusts to carrying half a kilo of baby. That’s a bit less than the weight of a basketball. Better not tell \(mother) just yet, but your baby could weigh around SEVEN times that by the time they’re born.

                    """,
                    24 : """
                    \(mother) might be suffering from indigestion or heartburn at the moment. This is partly because her pregnancy hormones will be relaxing all her muscles, slowing down her digestive system. And at the same time, the baby is pushing her stomach up higher which means that stomach acid (which causes heartburn) can cross into the gullet more easily.
                    
                    She (and you) can try eating smaller and more frequent meals, and steering clear of foods which are particularly rich or fatty. It might help her to sit up more after meals, and you could even try raising of the mattress in bed with cushions.
                    
                    If she’s spending ages in the loo, don’t even think about mentioning it. Again, constipation is really common in pregnancy so just push loads of fruit and vegetables in her direction and encourage her to drink plenty of water.

                    """,
                    25 : """
                    
                    \(mother) might notice that her hands and feet are getting a little swollen lately. This is very common in pregnancy, so chances are it’s nothing to worry about. Do order her to put her feet up and make her a nice cool drink. Don’t tell her she’s looking less like a human and more like a balloon animal.
                    
                    Swollen hands and feet can be a symptom of a serious condition called pre-eclampsia. If the swelling comes on suddenly, or it doesn’t get better when resting, \(mother) should contact her GP or midwife right away.
                    """,
                    26 : """
                    \(mother) might feel like her eyes are a bit dry at the moment, and this is another odd side effect of pregnancy. She can try massaging her eyelids, limiting screen time or using a humidifier. But if her eyes are really uncomfortable, she should mention it to her GP or optometrist. They’ll be able to rule out anything more serious and can recommend eye drops which are safe to use during pregnancy.
                    """,
                    27 : """
                    Is \(mother) feeling hot, hot, hot at the moment? While it might be hard to keep your cool when she’s thrown the duvet out of the window and into the snow at 2am for the third night in a row, try to be sympathetic. Hot flushes can be really uncomfortable, and they’re very common in pregnancy because of all the hormones and increased blood flow. Suggest that \(mother) spritzes her face with cool water when she’s feeling warm, and keep an emergency sleeping bag on your side of the bed.
                    """,
                    28 : """
                    Welcome to the third trimester! \(mother) could be starting to feel dizzier than a goat with vertigo on top of the Empire State Building. Pregnancy hormones cause blood vessels to relax so that more blood can flow through them to the baby, which can lower the blood pressure. As the baby grows, the amount of pressure on the blood vessels increases, which can lead to a feeling of dizziness. Other things which often cause dizziness in pregnancy are low blood sugar levels or low iron levels.
                    
                    If she has a dizzy spell, \(mother) should make sure she sits down and puts her head between her knees. Make sure she gets up slowly to avoid a head rush. She could also try eating smaller meals more regularly, to keep her blood sugar levels consistent. However, if the feeling of dizziness continues \(mother) should mention it to her midwife, and they’ll be able to check her iron levels.
                    """,
                    29 : """
                    Has \(mother) got that itchy twitchy feeling at the moment? A quarter of pregnant women feel itchy (usually on their breasts and bump) and it can be really annoying for them (and you). \(mother) should avoid scratching, and try using soothing moisturisers or rubbing ice cubes or a cold wet flannel on the skin. The vast majority of the time, it’s just an irritating problem, but do make sure \(mother) mentions any itching to the midwife, as it can be a symptom of a rare liver disease called obstetric cholestasis.
                    
                    \(mother)’s appetite has probably increased significantly since before she was pregnant, and she may be having some serious red meat cravings. But as long as she doesn’t announce that she’s eating an old friend for dinner, there’s no  cause for alarm. It’s your job to try and encourage her to eat healthily, although if you remind her too many times that she should only be eating an extra 500 calories per day, you may get your finger bitten off. Literally.
                    """,
                    30 : """
                    Have you been woken in the middle of the night a LOT during \(mother)’s pregnancy so far? First it was the loo trips. Then it was the hot flushes. Now, it’s leg cramps. Sorry, chaps – just see it as vital training for your future sleep deprived life with a newborn.
                    
                    And actually, leg cramps are the worst. So try to be nice. It might help \(mother) to put a pillow between her legs and a cushion under her bump.
                    
                    Around this time, \(mother) might also get some tingling, aching, numbness or pins and needles in her fingers. These could be symptoms of carpal tunnel syndrome. \(mother) should mention it at her next antenatal appointment and, in the meantime, she can try resting her hand in a raised position or even using a splint if it’s really noticeable.
                    """,
                    31 : """
                    Around now, \(mother) might start feeling a bit breathless. During her pregnancy, \(mother)’s ribcage has been moving outwards and her body has been working more quickly to process the oxygen and carbon dioxide in each breath. This means that she’s able to take much deeper breaths, but also might make her feel a bit breathless sometimes. And as the baby gets bigger, they will be pushing up against \(mother)’s lungs, which will make her feel even more breathless. It’s usually nothing to worry about, but if \(mother) is also getting palpitations or dizziness, she should contact her GP.
                    
                    So don’t laugh at \(mother) next time you beat her when racing up the stairs to go to the toilet. Be a gentleman and let her go first.
                    """,
                    32 : """
                    Has \(mother) felt any contractions yet? Don’t get too excited. These little tightenings of her bump are called Braxton Hicks contractions, and they’re bigger fakers than Truman’s neighbours on Seahaven Island. Unless they start increasing in intensity, or don’t ease off after a short while, Braxton Hicks contractions are just a way of \(mother)’s body preparing itself for labour.
                    
                    With her ever-growing bump and the return of the mid-night loo trips, \(mother) might be finding it harder to sleep than Al Pacino in Alaska. She might also report having some crazy dreams around now. Whatever she tells you, just nod. And don’t take it personally if she dreams that the baby comes out looking like Bob in Accounts.
                    """,
                    33 : """
                    This week, \(mother) might need to start slowing down a little bit. The baby now weighs nearly 2 kilograms, which might be making her feel tired and her back ache. To be fair, she’s carrying the weight of a small chihuahua. Cut her some slack and suggest a night in. If you want to earn Dad points, why not make her favourite meal (or order a takeaway) and give her sole access to the remote for an evening?
                    
                    Oh, and her breasts may start leaking milk around now. We know you’re tempted to call her a human cow, but that joke has to come from her first. Trust us.
                    """,
                    34 : """
                    \(mother)’s uterus is now sitting high up in her abdomen, and she might start to feel pressure under her ribs. This might make eating a full meal difficult, so encourage her to eat smaller meals more regularly. If you’re feeling kind, why not get some healthy snacks in? Preparing a few pots of Greek yoghurt, chopped fruit, or houmous and carrot sticks for her to snack on during the day will earn you serious Dad points.
                    """,
                    35 : """
                    Your baby has recently earned their black belt in kung fu, and \(mother) is feeling the effects. If she’s finding the kicks really uncomfortable, she can try moving around or going onto all fours to encourage the baby to change into a different position.
                    
                    As the baby gets bigger, the movements will feel different. However, \(mother) should be keeping track of the baby’s usual movements, and should let the midwife know straight away if she thinks the movements have become less frequent.
                    """,
                    36 : """
                    This week, it’s definitely time to pack the hospital bag. \(mother) is probably feeling tireder than THAT narcoleptic dog, so why not suggest that she puts her feet up while you pack the bag (under her close supervision). In the heat of labour, you’ll be the one searching through the bag so it’s a great way to make sure you know your maternity pads from your breast pads. As it were.
                    """,
                    37 : """
                    Around now, the baby is moving down and away from \(mother)’s ribcage. This might help her to feel a bit more comfortable, but she might also need to wee more often. If it’s \(mother)’s first baby, she might not feel the bump move down until labour starts, so it’s nothing to worry about if it still feels high up.
                    
                    Don’t forget to remind her to do her pelvic floor exercises!
                    """,
                    38 : """
                    The end is now in sight, and \(mother) might be starting to experience a few mood swings. When it starts to feel like you’re living with the Incredible Hulk, don’t forget that she’s carting around 3 kilograms of baby. That’s nearly as much as a roast turkey. Add a few sleepless nights, fake contractions, and ten million loo trips a day and you can hardly be surprised if she’s feeling a bit tense.
                    
                    \(mother) might also be starting to think about the birth, and could be worrying about what’s in store. Encourage her to talk about it, if that would help, and reassure her that you’ll be there throughout and that you’re so close now to finally meeting your baby.

                    """,
                    39 : """
                    By now, \(mother) is probably feeling a little like a whale. And she may be waddling a little, although you must never admit this or you might end up like Materazzi, and no one wants that.
                    
                    Now is the time to make the most of your time as a couple, before you become a family. Make her an offer she can’t refuse and suggest a date night at her favourite local restaurant, or a candlelit takeaway at home.
                    """,
                    40 : """
                    
                    The due date is finally here, but the baby might not make an appearance for another two weeks! During this time, \(mother) may be feeling even more tired and uncomfortable. Encourage her to take naps during the day, and make sure she’s getting lots of rest.
                    
                    If \(mother) is worrying about things that need to be done before the baby arrives, suggest that she writes down everything that needs to be done. Then you can divide up the most important tasks between you, and even draft in family members or friends to help out if you need. The most important thing is that \(mother) takes it easy, and the baby definitely won’t notice if the stairs need to be hoovered.
                    """
                ]
                
                cell.textView.isScrollEnabled = false
                cell.textView.text = motherWeeks[collectionView.tag + 3]
                cell.textView.isScrollEnabled = true
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


extension TodayViewController: UICollectionViewDelegateFlowLayout {
    
    func animateIn() {
        self.tabBarController?.tabBar.isHidden = true
        self.view.addSubview(setupPopup)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.weeklyTableView.alpha = 0.0
        }, completion: nil)
     
        self.tabBarItem.isEnabled = false
        setupPopup.frame.size.height = self.view.frame.height + 90
        setupPopup.frame.size.width = self.view.frame.width
        
        setupPopup.frame.origin.y = 0
        setupPopup.frame.origin.x = self.view.frame.width - setupPopup.frame.width
        setupPopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        setupPopup.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.setupPopup.alpha = 1
            self.setupPopup.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        
         self.tabBarController?.tabBar.isHidden = true
        self.setupPopup.removeFromSuperview()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.weeklyTableView.alpha = 1.0
        }, completion: nil)
        let dueDate = UserDefaults.standard.object(forKey: "DueDate") as? Date ?? Date()
        
        let now = Date()
        let diffInDays = Calendar.current.dateComponents([.day], from: now, to: dueDate).day
        
        let weeksLeft : Int = diffInDays!/7
        let remainderDays : Int = diffInDays!%7
        let weeksElapsed : Int = 40 - weeksLeft
        let remainderDaysElapsed : Int = 7 - remainderDays
        
        //        weekCollectionView.reloadData()
//
//        selectionTag = 0
//
//        self.navigationController?.isNavigationBarHidden = true
//        selectedPerson = ""
         let displayedWeeksElapsed = weeksElapsed - 3 ?? 0
        let indexPath = IndexPath(row: displayedWeeksElapsed, section: 0)
//        weeklyTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
//        (at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
// 
     //   mothersNameField.resignFirstResponder()
    }
    
    // MARK:- Collection View cell size extension
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = sizingView.frame.width
        let cellHeight = sizingView.frame.height
        
    return CGSize(width: cellWidth, height: cellHeight)
    }
}



