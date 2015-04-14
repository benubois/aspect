import UIKit

class CalculatorViewController: UITableViewController {
    
    var observer:NSObjectProtocol?
    
    enum Sections: Int {
        case Original = 0
        case Resized = 1
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

        let notificationCenter = NSNotificationCenter.defaultCenter()
        let mainQueue = NSOperationQueue.mainQueue()
        self.observer = notificationCenter.addObserverForName(UITextFieldTextDidChangeNotification, object: nil, queue: mainQueue) { notification in
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == Sections.Original.rawValue {
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
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == Sections.Original.rawValue) {
            return "Original"
        }
        else if (section == Sections.Resized.rawValue) {
            return "Resized"
        }
        return nil
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! Cell
        cell.textField.becomeFirstResponder()
    }

    func getCell() -> Cell? {
        let bundle = NSBundle.mainBundle()
        let nib = UINib(nibName: "Cell", bundle: bundle).instantiateWithOwner(self, options: nil)
        return nib.first as? Cell
    }
    
    func calculate(textField:UITextField) {
        if let currentWidth = self.widthOriginalCell?.textField.text.toInt(), currentHeight = self.heightOriginalCell?.textField.text.toInt() {
            let widthProportion = Float(currentWidth) / Float(currentHeight)
            let heightProportion = Float(currentHeight) / Float(currentWidth)

            if (textField == self.heightResizedCell?.textField){
                if let newHeight = self.heightResizedCell?.textField.text.toInt() {
                    let newWidth = Float(newHeight) * widthProportion
                    let displayValue = String(Int(round(newWidth)))
                    self.widthResizedCell?.textField.text = displayValue
                }
            } else {
                if let newWidth = self.widthResizedCell?.textField.text.toInt() {
                    let newHeight = Float(newWidth) * heightProportion
                    let displayValue = String(Int(round(newHeight)))
                    self.heightResizedCell?.textField.text = displayValue
                }
            }
        }
    }

}
