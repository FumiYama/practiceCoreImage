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
    class func hexStr (var hexStr : NSString, let alpha : CGFloat) -> UIColor {
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
    let mb_monochromeButton: UIButton = UIButton() //モノクロ化のボタン
    let rb_reversalButton: UIButton = UIButton() // 反転ボタン
    let ccb_colorConversionButton: UIButton = UIButton() // 色変換ボタン
    let sb_sharpButton: UIButton = UIButton() // 画像の境界をシャープに
    
    let slider: UISlider = UISlider() // すらいだー

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ss = self.view.frame.size // 画面サイズ
        
        let initRasterizeValue : CGFloat = 1.0         // ラスタライズ化の初期化値.
        
        slider.layer.position = CGPointMake(ss.width/2, ss.height - 100)
        slider.layer.zPosition = 1
        slider.minimumValue = 0.1
        slider.maximumValue = 1.0
        slider.value = Float(1.0 - initRasterizeValue)
        slider.addTarget(self, action: "onValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(slider)
        
        iv_imageView = UIImageView(frame: CGRectMake(0, 0, ss.width, ss.height*3/4))
        iv_imageView.image = UIImage(CIImage: ii_inputImage!)
        iv_imageView.contentMode = UIViewContentMode.ScaleAspectFit // ??????????

        if iv_imageView != nil {
            iv_imageView.layer.shouldRasterize = true
            
            iv_imageView.layer.rasterizationScale = initRasterizeValue // 値の初期化
            
            self.view.addSubview(iv_imageView)
        }
        
        sb_sepiaButton.frame = CGRectMake(0, 0, 50, 50)
        sb_sepiaButton.backgroundColor = UIColor.hexStr("#F52F57", alpha: 1)
        sb_sepiaButton.setTitle("sepia", forState: .Normal)
        sb_sepiaButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sb_sepiaButton.layer.position = CGPoint(x: ss.width/7, y: ss.height-50)
        sb_sepiaButton.tag = 1
        sb_sepiaButton.addTarget(self, action: "onClickSepiaButton:", forControlEvents: .TouchUpInside)
        
        mb_mosaicButton.frame = CGRectMake(0, 0, 50, 50)
        mb_mosaicButton.backgroundColor = UIColor.hexStr("#1A763E", alpha: 1.0)
        mb_mosaicButton.setTitle("mosaic", forState: .Normal)
        mb_mosaicButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        mb_mosaicButton.layer.position = CGPoint(x: ss.width*2/7, y: ss.height-50)
        mb_mosaicButton.addTarget(self, action: "onClickMosaicButton:", forControlEvents: .TouchUpInside)
        
        mb_monochromeButton.frame = CGRectMake(0, 0, 50, 50)
        mb_monochromeButton.backgroundColor = UIColor.hexStr("#5j5j5j", alpha: 1.0)
        mb_monochromeButton.setTitle("monochrome", forState: .Normal)
        mb_monochromeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        mb_monochromeButton.layer.position = CGPoint(x: ss.width*3/7, y: ss.height-50)
        mb_monochromeButton.addTarget(self, action: "onClickMonochromeButton:", forControlEvents: .TouchUpInside)
        
        rb_reversalButton.frame = CGRectMake(0, 0, 50, 50)
        rb_reversalButton.backgroundColor = UIColor.hexStr("#FCA311", alpha: 1.0)
        rb_reversalButton.setTitle("reversal", forState: .Normal)
        rb_reversalButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        rb_reversalButton.layer.position = CGPoint(x: ss.width*4/7, y: ss.height-50)
        rb_reversalButton.addTarget(self, action: "onClickReversalButton:", forControlEvents: .TouchUpInside)
        
        ccb_colorConversionButton.frame = CGRectMake(0, 0, 50, 50)
        ccb_colorConversionButton.backgroundColor = UIColor.hexStr("#3A6EA5", alpha: 1.0)
        ccb_colorConversionButton.setTitle("conversion", forState: .Normal)
        ccb_colorConversionButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        ccb_colorConversionButton.layer.position = CGPoint(x: ss.width*6/7, y: ss.height-50)
        ccb_colorConversionButton.addTarget(self, action: "onClickColorConversionButton:", forControlEvents: .TouchUpInside)
        
        
        sb_sharpButton.frame = CGRectMake(0, 0, 50, 50)
        ccb_colorConversionButton.backgroundColor = UIColor.hexStr("#16DB65", alpha: 1.0)
        ccb_colorConversionButton.setTitle("sharp", forState: .Normal)
        ccb_colorConversionButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        ccb_colorConversionButton.layer.position = CGPoint(x: ss.width*6/7, y: ss.height-100)
        ccb_colorConversionButton.addTarget(self, action: "onClickSharpButton:", forControlEvents: .TouchUpInside)
        
        
        self.view.addSubview(sb_sepiaButton)
        self.view.addSubview(mb_mosaicButton)
        self.view.addSubview(mb_monochromeButton)
        self.view.addSubview(rb_reversalButton)
        self.view.addSubview(ccb_colorConversionButton)
        self.view.addSubview(sb_sharpButton)
        
    }
    
    func onValueChanged(slider: UISlider) {
        if iv_imageView != nil {
            iv_imageView.layer.rasterizationScale = CGFloat(1.1 - slider.value)
        }
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
    
    func onClickMonochromeButton(sender: UIButton) {
        let mf_monochromeFilter = CIFilter(name: "CIColorMonochrome")
        mf_monochromeFilter?.setValue(ii_inputImage, forKey: kCIInputImageKey) //イメージのセット
        //モノクロ化するための値の調整
        mf_monochromeFilter?.setValue(CIColor(red: 0.5, green: 0.5, blue: 0.5), forKey: kCIInputColorKey)
        mf_monochromeFilter?.setValue(1.0, forKey: kCIInputIntensityKey)
        
        oi_outputImage = mf_monochromeFilter?.outputImage
        iv_imageView.image = UIImage(CIImage: oi_outputImage)
        iv_imageView.setNeedsDisplay()
    }
    
    func onClickReversalButton(sender: UIButton) {
        let if_invertFilter = CIFilter(name: "CIColorInvert")
        if_invertFilter?.setValue(ii_inputImage, forKey: kCIInputImageKey)
        oi_outputImage = if_invertFilter?.outputImage
        iv_imageView.image = UIImage(CIImage: oi_outputImage)
        iv_imageView.setNeedsDisplay()
    }
    
    func onClickColorConversionButton(sender:UIButton) {
        let cf_colorFilter = CIFilter(name: "CIColorCrossPolynomial")!
        
        cf_colorFilter.setValue(ii_inputImage, forKey: kCIInputImageKey)
        
        // RGBの変換値を作成.
        let r: [CGFloat] = [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        let g: [CGFloat] = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        let b: [CGFloat] = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        // モノクロ化するための値の調整.
        cf_colorFilter.setValue(CIVector(values: r, count: 10), forKey: "inputRedCoefficients")
        cf_colorFilter.setValue(CIVector(values: g, count: 10), forKey: "inputGreenCoefficients")
        cf_colorFilter.setValue(CIVector(values: b, count: 10), forKey: "inputBlueCoefficients")
        
        oi_outputImage = cf_colorFilter.outputImage
        iv_imageView.image = UIImage(CIImage: oi_outputImage)
        iv_imageView.setNeedsDisplay()
    }
    
    func onClickSharpButton(sender: UIButton) {
        // カラーエフェクトを指定してCIFilterをインスタンス化.
        let mySharpFilter = CIFilter(name:"CIUnsharpMask")!
        
        // イメージのセット.
        mySharpFilter.setValue(ii_inputImage, forKey: kCIInputImageKey)
        
        // フィルターを通した画像をアウトプット.
        oi_outputImage = mySharpFilter.outputImage
        
        // 再びUIViewにセット.
        iv_imageView.image = UIImage(CIImage: oi_outputImage)
        
        // 再描画.
        iv_imageView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

