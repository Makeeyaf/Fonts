//  Copyright © 2019 Makeeyaf. All rights reserved

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var pangramLabel: UITextField!
    @IBOutlet weak var slider: UISlider!
    
    weak var delegate: CollectionViewDelegate?
    
    var fontSize: CGFloat = 0
    var pangram: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = Float(fontSize)
        fontSizeLabel.text = String(Int(fontSize))
        pangramLabel.text = pangram
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        fontSize = CGFloat(Int(sender.value.rounded()))
        fontSizeLabel.text = String(Int(fontSize))
        delegate?.updateOption(fontSize: fontSize, pangram: pangram)
    }
    
    @IBAction func pangramEdited(_ sender: UITextField) {
        pangram = sender.text ?? ""
        delegate?.updateOption(fontSize: fontSize, pangram: pangram)
    }
    
    
    
    
}
