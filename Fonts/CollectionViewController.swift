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
        cell.pangram.attributedText = NSAttributedString(string: pangram, attributes: [NSAttributedString.Key.font : UIFont(name: fontName, size: fontSize) as Any])
        return cell
    }
}



extension CollectionViewController: CollectionViewDelegate {
    func updateOption(fontSize: CGFloat, pangram: String) {
        self.fontSize = fontSize
        self.pangram = pangram
        collectionView.reloadData()
    }
}
