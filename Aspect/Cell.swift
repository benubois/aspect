import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textField.keyboardType = UIKeyboardType.numberPad
    }

}
