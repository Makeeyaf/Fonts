//  Copyright © 2019 Makeeyaf. All rights reserved

import UIKit

protocol CollectionViewDelegate: class {
    func updateOption(fontSize: CGFloat, pangram: String)
}

class CollectionViewController: UICollectionViewController {
    
    var fontFamilies: [String] = UIFont.familyNames.sorted()
    var fontNames: [[String]] = []
    var fontSize: CGFloat = 17
    var pangram = "The quick brown fox jumps over a lazy dog."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        for family in fontFamilies {
            fontNames.append(UIFont.fontNames(forFamilyName: family))
        }
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TableViewController {
            let vc = segue.destination as? TableViewController
            vc?.delegate = self
            vc?.fontSize = fontSize
            vc?.pangram = pangram
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! CollectionReusableView
            header.sectionHeader.text = fontFamilies[indexPath.section]
            return header
            
        default:
            assert(false, "Unexpected element kind")
        }
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fontFamilies.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fontNames[section].count
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let fontName = fontNames[indexPath.section][indexPath.row]
        cell.fontName.text = fontName
        cell.pangram.attributedText = NSAttributedString(string: pangram, attributes: [NSAttributedString.Key.font : UIFont(name: fontName, size: fontSize)])
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

extension CollectionViewController: CollectionViewDelegate {
    func updateOption(fontSize: CGFloat, pangram: String) {
        self.fontSize = fontSize
        self.pangram = pangram
        collectionView.reloadData()
    }
}
