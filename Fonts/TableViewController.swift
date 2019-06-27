//  Copyright © 2019 Makeeyaf. All rights reserved

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var pengramLabel: UITextField!
    @IBOutlet weak var slider: UISlider!
    
    weak var delegate: CollectionViewController!
    
    var fontSize: CGFloat = 0
    var pengram: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = Float(fontSize)
        fontSizeLabel.text = String(Int(fontSize))
        pengramLabel.text = pengram
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        fontSize = CGFloat(Int(sender.value.rounded()))
        fontSizeLabel.text = String(Int(fontSize))
        delegate.updateOption(fontSize: fontSize, pengram: pengram)
    }
    
    @IBAction func pengramEdited(_ sender: UITextField) {
        pengram = sender.text ?? ""
        delegate.updateOption(fontSize: fontSize, pengram: pengram)
    }
    
    
    
    
}
