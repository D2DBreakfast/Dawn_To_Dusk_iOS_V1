//
//  extensions.swift
//  Dawn To Dusk
//
//  Created by Hiren on 22/07/21.
//

import Foundation
import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

//MARK:- Color Extension

extension UIColor {
    
    // custom color methods
    class func colorWithHex(rgbValue: UInt32) -> UIColor {
        return UIColor( red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                        alpha: CGFloat(1.0))
    }
    
    class func colorWithHexString(hexStr: String) -> UIColor {
        var cString:String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hexStr.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if (cString.isEmpty || (cString.count) != 6) {
            return colorWithHex(rgbValue: 0xFF5300);
        } else {
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            return colorWithHex(rgbValue: rgbValue);
        }
    }
    
    func changeImageColor(theImageView: UIImageView, newColor: UIColor) {
        theImageView.image = theImageView.image?.withRenderingMode(.alwaysOriginal)
        theImageView.tintColor = newColor;
    }
}

//MARK:- String Extension

extension String
{
    
    
    var isBlank:Bool {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    var isZero:Bool {
        if self == "0" || self == "" {
            return true
        }
        else {
            return false
        }
    }
    
    func IsStrEmpty() -> Bool {
        if self.isEmpty && self.isBlank && self.isZero {
           return true
        }
        else {
            return false
        }
    }
    
    /**
     Convert argument string into localisedstring and display to caller controllers
     ### Usage Example: ###
     ````
     "locatized".localized()
     ````
     */
    func localized()->String
    {
        return NSLocalizedString(self, comment: self)
    }
    
    func removeWhiteSpace() -> String {
        let trimmed = self.trimmingCharacters(in: .whitespaces)
        var final = trimmed.replacingOccurrences(of: "", with: "")
        final = final.replacingOccurrences(of: " ", with: "")
        return final.localized()
    }
    
    func customStringFormatting() -> String {
        return self.chunk(n: 1).map{ String($0) }.joined(separator: ThemeSpace).localized()
    }
    
    mutating func replaceLocalized(fromvalue: [String], tovalue: [String]) -> String {
        var replacestr: String = ""
        for (index, from) in fromvalue.enumerated() {
            replacestr = self.replacingOccurrences(of: from, with: tovalue[index])
            self = replacestr
        }
        return self.localized()
    }
    
    /**
     convert argument string into Date year format and display to caller controllers
     ### Usage Example: ###
     ````
     "string".currentYear()
     ````
     */
    static func currentYear()->String
    {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "YYYY"
        return myFormatter.string(from: Date())
    }
    
    /**
     convert argument string into Date Month format and display to caller controllers
     ### Usage Example: ###
     ````
     "string".currentMonth()
     ````
     */
    static func currentMonth()->String
    {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MM"
        return myFormatter.string(from: Date())
    }
    
    /**
     Convert argument string into substring value
     - Parameters inputSTR: main string to get sub string.
     - Parameters substring: sub string to get form main string.
     - return array: return string array with stirng, int and int arguments
     
     ### Usage Example: ###
     ````
     String.FindSubString(inputStr: "main string", subStrings: ["sub string", "sub string"])
     ````
     */
    func FindSubString(inputStr : String, subStrings: Array<String>?) ->Array<(String, Int, Int)> {
        var resultArray : Array<(String, Int, Int)> = []
        for i: Int in 0...(subStrings?.count)!-1 {
            if inputStr.contains((subStrings?[i])!) {
                let range: Range<String.Index> = inputStr.range(of: subStrings![i])!
                let lPos = inputStr.distance(from: inputStr.startIndex, to: range.lowerBound)
                let uPos = inputStr.distance(from: inputStr.startIndex, to: range.upperBound)
                let element = ((subStrings?[i])! as String, lPos, uPos)
                resultArray.append(element)
            }
        }
        for words in resultArray {
            print("FindSubString: \(words)")
        }
        return resultArray
    }
    
    /**
     Convert argument string into range value
     - Parameters value: range value with (string, int, int)
     - return array: return given string range
     
     ### Usage Example: ###
     ````
     String.ConvertRange(value: ("string", 0, 10)))
     ````
     */
    func ConvertRange(value: (String, Int, Int)) -> NSRange {
        var range: NSRange!
        range = NSRange(location: value.1, length: value.2)
        return range
    }
    
    /**
     Convert argument string into attributestring
     - Parameters attribute: pass attrbute string array with (stirng, font, color)
     - Parameters mainstring: Main string with wont to convert into attribute string
     - Parameters rangearray: pass range range array
     - return array: return attribute string with given parameter consider.
     
     ### Usage Example: ###
     ````
     let string1: String = "".localized()
     let string2: String = "Enter The mobile no. Associated with your account \nWe will mobile no you link to reset your password.".localized() as String
     let mainstring: String = string1 + string2
     let myMutableString = mainstring.Attributestring(attribute: [(string1, Font().RegularFont(font: 15.0), UIColor.black), (string2, Font().RegularFont(font: 15.0), UIColor.lightGray)], with: mainstring, with: NSArray.init(array: mainstring.FindSubString(inputStr: mainstring, subStrings: [string1, string2])))
     self.Note_lbl.attributedText = myMutableString
     String.Attributestring(attribute: [(string, font, color)], mainstring: string, rangearray:[])
     ````
     */
    func Attributestring(attribute: Array<(String, UIFont, UIColor)>, with mainstring: String, with rangearray:NSArray) -> NSAttributedString {
        let myMutableString = NSMutableAttributedString.init()
        var index: Int = 0
        for obj in attribute {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: obj.1,
                .foregroundColor: obj.2,
            ]
            let rangestring: (String, Int, Int) = rangearray.object(at: index) as! (String, Int, Int)
            let attributestring = NSMutableAttributedString.init(string: rangestring.0, attributes: attributes)
            myMutableString.append(attributestring)
            index += 1
        }
        return myMutableString
    }
    
    /**
     Convert argument string into attributestring
     - Parameters attribute: pass attrbute string array with NSAttributedString.Key
     - Parameters mainstring: Main string with wont to convert into attribute string
     - Parameters rangearray: pass range range array
     - return array: return attribute string with given parameter consider.
     
     ### Usage Example: ###
     ````
     String.EditAttributestring(attribute: [NSAttributedStringKey], mainstring: string, rangearray:[])
     ````
     */
    func EditAttributestring(attribute: Array<([NSAttributedString.Key: Any])>, with mainstring: String, with rangearray:NSArray) -> NSAttributedString {
        let myMutableString = NSMutableAttributedString.init()
        var index: Int = 0
        for obj in attribute {
            let rangestring: (String, Int, Int) = rangearray.object(at: index) as! (String, Int, Int)
            let attributestring = NSMutableAttributedString.init(string: rangestring.0, attributes: obj)
            myMutableString.append(attributestring)
            index += 1
        }
        return myMutableString
    }
}

//MARK:- Date Fomrat

extension Date {
    
    func convertDateFormater() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
    
    func convertDaterang(dt1: Date, dt2: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return String.init(format: "%@ To %@", dateFormatter.string(from: dt1), dateFormatter.string(from: dt2))
    }
    
}

//MARK:- Collection Extension

extension Collection {
    public func chunk(n: IndexDistance) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}

//MARK:- Label Extension

@objc extension UILabel
{
    /**
     label maskround
     */
    func makeRound() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 5.0
    }
}

//MARK:- Tableview Extension

@objc extension UITableView {
    
    func lastIndexpath() -> IndexPath {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfRows(inSection: section) - 1, 0)
        
        return IndexPath(row: row, section: section)
    }
    
    func SetupBlankCell(indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell().setupDefaultCell()
    }
    
}

//MARK:- Viewcontroller Extension

extension UIViewController {
    
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
    
    func statusBarColorChange() {
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = ModeBG_Color
            statusBar.tag = 100
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = ModeBG_Color // UIColor.systemBackground
        }
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func SetupNavBarwithBack_cart() {
        self.statusBarColorChange()
        self.navigationController?.navigationBar.backgroundColor = ModeBG_Color
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = ModeBG_Color
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.hidesBackButton = true
        let backbtn = UIButton().NavBackButton()
        backbtn.addTarget(self, action: #selector(TappedBackBTN(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backbtn)
        
//        let cartBTN = UIButton().NavCartButton()
//        cartBTN.addTarget(self, action: #selector(TappedCartBTN(_:)), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: cartBTN)
    }
    
    func SetupNavBarforback() {
        self.statusBarColorChange()
        self.navigationController?.navigationBar.backgroundColor = ModeBG_Color
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = ModeBG_Color
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.hidesBackButton = true
        let backbtn = UIButton().NavBackButton()
        backbtn.addTarget(self, action: #selector(TappedBackBTN(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backbtn)
    }
    
    @IBAction func TappedBackBTN(_ sender: UIButton) {
        if isModal {
            self.dismiss(animated: true, completion:nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func TappedCartBTN(_ sender: UIButton) {
        let cart = CartManageVC.init(nibName: "CartManageVC", bundle: nil)
        self.navigationController?.pushViewController(cart, animated: true)
    }
    
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
        parent?.backgroundColor = ModeBG_Color
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
    }
    
}

//MARK:- View Extension

extension UIView {
    func recurrenceAllSubviews() -> [UIView] {
        var all = [UIView]()
        func getSubview(view: UIView) {
            all.append(view)
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}

//MARK:- Int Extension

extension Int {
    init(_ range: Range<Int> ) {
        let delta = range.startIndex < 0 ? abs(range.startIndex) : 0
        let min = UInt32(range.startIndex + delta)
        let max = UInt32(range.endIndex   + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
}

//MARK:- Imageview or image Extension

extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async() { () -> Void in
                let imageInset: CGFloat = self.frame.size.height / 10
                self.image = cachedImage.resizableImage(withCapInsets: UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset), resizingMode: .stretch)
            }
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async() { () -> Void in
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    let imageInset: CGFloat = self.frame.size.height / 10
                    self.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset), resizingMode: .stretch)
                }
            }.resume()
        }
    }
    
    func downloadedFrom(link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit, radious: CGFloat? = nil) {
        if link == nil || link?.count == 0 {
            return
        }
        guard let url = URL(string: link!) else { return }
        self.clipsToBounds = true
        self.layer.cornerRadius = radious!
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async() { () -> Void in
                let imageInset: CGFloat = self.frame.size.height / 10
                self.image = cachedImage.resizableImage(withCapInsets: UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset), resizingMode: .stretch)
            }
        } else {
            downloadedFrom(url: url, contentMode: mode)
        }
    }
    
}

//MARK:- Button Extension

extension UIButton {
    
    func NavBackButton() -> UIButton {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        //        btn.layer.borderColor = WhiteBorderColor?.cgColor
        //        btn.layer.borderWidth = 1
        btn.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.4)
        btn.tintColor = UIColor.white
        btn.setImage(UIImage.init(systemName: "chevron.backward"), for: .normal)
        return btn
    }
    
    func NavCartButton() -> UIButton {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        //        btn.layer.borderColor = WhiteBorderColor?.cgColor
        //        btn.layer.borderWidth = 1
        btn.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.4)
        //        btn.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        btn.tintColor = UIColor.white
        btn.setImage(UIImage.init(named: "CartIC"), for: .normal)
        return btn
    }
    
    func NavAddButton() -> UIButton {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.4)
        btn.tintColor = UIColor.white
        btn.setImage(UIImage.init(systemName: "plus"), for: .normal)
        return btn
    }
    
    func GetThemeButtonwithBorder() {
        self.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.setTitleColor(.white, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderColor = WhiteBorderColor?.cgColor
        self.layer.borderWidth = 1
    }
    
    func GetThemeButtonwithoutBorder() {
        self.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.setTitleColor(.white, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
}

extension Array where Element: Equatable {
    func whatFunction(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}

extension Double {
    
    func formatprice() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: self as NSNumber)!
    }
    
}


extension UITableViewCell {
    func setupDefaultCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.contentView.backgroundColor = ModeBG_Color
        cell.backgroundColor = ModeBG_Color
        return cell
    }
}

extension UITabBar {
    func addBadge(index:Int, counts: Int) {
        if let tabItems = self.items {
            let tabItem = tabItems[index]
            tabItem.badgeValue = String.init(format: "%d", counts)
            tabItem.badgeColor = .clear
            tabItem.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        }
    }
    func removeBadge(index:Int) {
        if let tabItems = self.items {
            let tabItem = tabItems[index]
            tabItem.badgeValue = nil
        }
    }
    
 }
