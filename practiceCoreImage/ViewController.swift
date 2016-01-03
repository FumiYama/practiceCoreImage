//
//  ViewController.swift
//  practiceCoreImage
//
//  Created by Fumiya Yamanaka on 2016/01/02.
//  Copyright © 2016年 Fumiya Yamanaka. All rights reserved.
//

import UIKit
import CoreImage

extension UIColor {
    class func hexStr (var hexStr : NSString, var alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}

class ViewController: UIViewController {

    
    let ii_inputImage = CIImage(image: UIImage(named: "2.jpg")!) // ベース画像
    var oi_outputImage: CIImage!
    var iv_imageView: UIImageView! // imageview
    
    
    let sb_sepiaButton: UIButton = UIButton() //セピアのボタン
    let mb_mosaicButton: UIButton = UIButton() // モザイクボタン
    
    // 画面サイズ取得


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ss = self.view.frame.size // 画面サイズ
        iv_imageView = UIImageView(frame: CGRectMake(0, 0, ss.width, ss.height))
        iv_imageView.image = UIImage(CIImage: ii_inputImage!)
        iv_imageView.contentMode = UIViewContentMode.ScaleAspectFit // ??????????
        self.view.addSubview(iv_imageView)
        
        sb_sepiaButton.frame = CGRectMake(0, 0, 60, 60)
        sb_sepiaButton.backgroundColor = UIColor.hexStr("#F52F57", alpha: 1)
        sb_sepiaButton.setTitle("sepia", forState: .Normal)
        sb_sepiaButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sb_sepiaButton.layer.position = CGPoint(x: ss.width/2, y: ss.height-50)
        sb_sepiaButton.tag = 1
        sb_sepiaButton.addTarget(self, action: "onClickSepiaButton:", forControlEvents: .TouchUpInside)
        
        mb_mosaicButton.frame = CGRectMake(0, 0, 60, 60)
        mb_mosaicButton.backgroundColor = UIColor.hexStr("#1A763E", alpha: 1.0)
        mb_mosaicButton.setTitle("mosaic", forState: .Normal)
        mb_mosaicButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        mb_mosaicButton.layer.position = CGPoint(x: ss.width/4, y: ss.height-50)
        mb_mosaicButton.addTarget(self, action: "onClickMosaicButton:", forControlEvents: .TouchUpInside)
        
        self.view.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(sb_sepiaButton)
        self.view.addSubview(mb_mosaicButton)
        
        
        
        
        
    }
    
    func onClickSepiaButton(sender: UIButton) {
        
        let sf_sepiaFilter = CIFilter(name: "CISepiaTone")!
        
        sf_sepiaFilter.setValue(ii_inputImage, forKey: kCIInputImageKey)
        
        sf_sepiaFilter.setValue(1.0, forKey: kCIInputIntensityKey)
        
        oi_outputImage = sf_sepiaFilter.outputImage!
        
        iv_imageView.image = UIImage(CIImage: oi_outputImage)
        
        iv_imageView.setNeedsDisplay()
    }
    
    func onClickMosaicButton(sender: UIButton) {
        let pf_pixellateFilter = CIFilter(name: "CIPixellate")
        
        pf_pixellateFilter?.setValue(ii_inputImage, forKey: kCIInputImageKey)
        
        oi_outputImage = pf_pixellateFilter?.outputImage!
        
        iv_imageView.image = UIImage(CIImage: oi_outputImage)
        
        iv_imageView.setNeedsDisplay()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

