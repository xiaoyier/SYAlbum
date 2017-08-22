//
//  SYAlbumController.swift
//  Pods
//
//  Created by AllConnected on 2017/8/22.
//
//

import UIKit

public class Test: UIViewController {
    
//    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        
//        //do something
//        view.backgroundColor = UIColor.white
//    }
    
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override public func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func show(_ sender: UIButton) {
        
        let sheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil)
        
        sheet.addButton(withTitle: "Browser")
        sheet.addButton(withTitle: "Picker")
        
        sheet.show(in: self.view)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        debugPrint(view.subviews)
    }
}

extension Test: UIActionSheetDelegate {
    
    public func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        guard buttonIndex != actionSheet.cancelButtonIndex else {
            return
        }

        switch buttonIndex {
        case 1:
            let container = Browser(library: PHLibrary())
            let vc2 = BrowserAlbumListControllerMake(container)
            present(vc2, animated: true, completion: nil)
            
        case 2:
            let container = Picker(library: PHLibrary())
            let vc2 = BrowserAlbumListControllerMake(container)
            present(vc2, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
}
