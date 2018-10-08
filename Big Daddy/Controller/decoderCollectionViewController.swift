//
//  decoderCollectionViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 01/09/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class decoderCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var decoderCollectionView: UICollectionView!
    
    var arrayOfImages = [UIImage]()
    var arrayOfItems = [String]()
    var arrayOfDescriptions = [String]()
var itemArray = [Item]()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemArray = [
            Item(itemName:"Sleepsuit", isEssential: true, itemDescription:"The most-used baby garment out there. With no sleeves or legs, a baby vest is ideal for keeping that nappy in place. If it’s cold, layer under a sleepsuit or outfit. If it’s warm, wear on its own. You’ll need at least seven of these."),
        Item(itemName:"Short-sleeved vest", isEssential: true, itemDescription:"A onesie for babies, with long arms and legs, as well as feet. Some sleepsuits have built-in scratch mitts, where the ends of the arms can be pulled over the baby’s hands to stop them from scratching themselves. If it’s cold, layer over a short sleeved vest. If you’re having a winter baby, you’ll need at least seven of these."), Item(itemName:"Long-sleeved vest", isEssential: true, itemDescription:"A handy halfway house between short sleeved vests and sleepsuits. With long sleeves but no legs, these are also great at keeping that pesky nappy securely in place. They also look great under dungarees. Depending on the season, you’ll probably want half a dozen of these."),
            Item(itemName:"Romper", isEssential: true, itemDescription:"A bit like a short sleeved vest, but with slightly longer legs. This is more of an daytime outfit than a comfy sleeping option. This is a must for summer babies."), Item(itemName:"Muslin", isEssential: true, itemDescription:"A fancy word for a bit of cotton cloth. Great for catching baby sick during and after feeding. Make sure you have at least ten in stock."),
            Item(itemName:"Swaddle", isEssential: true, itemDescription:"Newborn babies like to be snugly wrapped (or swaddled) when they sleep. Apparently it helps them feel secure, and it’s safe as long as the swaddle is below their shoulders and isn’t too tight. Make sure the baby is placed on their back to sleep, and stop swaddling once they start to roll. You can use a bog standard blanket or large muslin, or you can buy special baby swaddles."),
            Item(itemName:"Sleeping Bag", isEssential: true, itemDescription:"An alternative to (or follow-on from) swaddles. With handy holes for heads and arms, baby sleeping bags come in different weights depending on the weather. 0.5 tog is great for warmer temperatures, while 2.5 tog is perfect for chilly winter nights. We wish they did these in adult sizes."),
        Item(itemName:"Nappy", isEssential: true, itemDescription:"These are non-negotiable. Newborn nappies come in size 0 (for tiny babies) and size 1. Some even come with a handy yellow stripe which turns blue when the baby has done a wee. We’d recommend buying size 1s in bulk to get you through the early days. If you’re environmentally conscious, there’s a whole world of reusable or biodegradable nappies out there too."),
        ]
        
        
      //  self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        decoderCollectionView.delegate = self
        decoderCollectionView.dataSource = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemArray.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! decoderCollectionViewCell
    
        let item: Item
        item = itemArray[indexPath.row]
        cell.itemImage.image = #imageLiteral(resourceName: "seahorse")
  cell.itemName.text = item.itemName
        cell.itemDescription.text = item.itemDescription
       
        return cell
    }
    
    
 

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension decoderCollectionViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.decoderCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
}

extension decoderCollectionViewController: UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let cellWidth = decoderCollectionView.frame.width
    let cellHeight = decoderCollectionView.frame.height
    
    return CGSize(width: cellWidth, height: cellHeight)
}
}
