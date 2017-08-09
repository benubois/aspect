import UIKit

class CalculatorViewController: UITableViewController {
    
    var observer:NSObjectProtocol?
    
    enum Sections: Int {
        case original = 0
        case resized = 1
    }
    
    lazy var widthOriginalCell:Cell? = {
        return self.getCell()
    }()
    
    lazy var heightOriginalCell:Cell? = {
        return self.getCell()
    }()
    
    lazy var widthResizedCell:Cell? = {
        return self.getCell()
    }()
    
    lazy var heightResizedCell:Cell? = {
        return self.getCell()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Aspect"

        let notificationCenter = NotificationCenter.default
        let mainQueue = OperationQueue.main
        self.observer = notificationCenter.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: nil, queue: mainQueue) { notification in
            let textField = notification.object as! UITextField
            self.calculate(textField)
        }
        
        self.widthOriginalCell?.label.text = "Width"
        self.widthOriginalCell?.textField.text = "1024"
        
        self.heightOriginalCell?.label.text = "Height"
        self.heightOriginalCell?.textField.text = "768"
        
        self.widthResizedCell?.label.text = "Width"
        self.heightResizedCell?.label.text = "Height"
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == Sections.original.rawValue {
            if indexPath.row == 0 {
                return self.widthOriginalCell!
            } else {
                return self.heightOriginalCell!
            }
        }
        else {
            if indexPath.row == 0 {
                return self.widthResizedCell!
            } else {
                return self.heightResizedCell!
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == Sections.original.rawValue) {
            return "Original"
        }
        else if (section == Sections.resized.rawValue) {
            return "Resized"
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! Cell
        cell.textField.becomeFirstResponder()
    }

    func getCell() -> Cell? {
        let bundle = Bundle.main
        let nib = UINib(nibName: "Cell", bundle: bundle).instantiate(withOwner: self, options: nil)
        return nib.first as? Cell
    }
    
    func calculate(_ textField:UITextField) {
        if let currentWidthString = self.widthOriginalCell?.textField.text, let currentWidth = Int(currentWidthString), let currentHeightString = self.heightOriginalCell?.textField.text, let currentHeight = Int(currentHeightString) {
            let widthProportion = Float(currentWidth) / Float(currentHeight)
            let heightProportion = Float(currentHeight) / Float(currentWidth)

            if (textField == self.heightResizedCell?.textField){
                if let newHeightString = self.heightResizedCell?.textField.text, let newHeight = Int(newHeightString) {
                    let newWidth = Float(newHeight) * widthProportion
                    let displayValue = String(Int(round(newWidth)))
                    self.widthResizedCell?.textField.text = displayValue
                }
            } else {
                if let newWidthString = self.widthResizedCell?.textField.text, let newWidth = Int(newWidthString) {
                    let newHeight = Float(newWidth) * heightProportion
                    let displayValue = String(Int(round(newHeight)))
                    self.heightResizedCell?.textField.text = displayValue
                }
            }
        }
    }

}
