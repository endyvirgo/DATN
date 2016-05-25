//
//  ViewController.swift
//  DATN_Scale
//
//  Created by KhanhNguyen on 4/13/16.
//  Copyright © 2016 KhanhNguyen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    //    let captureSession = AVCaptureSession()
    //    var previewLayer : AVCaptureVideoPreviewLayer?
    //
    //    // Neu tim thay thiet bi chup anh se luu tru vao day
    //    var captureDevice : AVCaptureDevice?
    let label = UILabel()
    
    var circles = [UITouch: CirclesLabel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        //
        //        let devices = AVCaptureDevice.devices()
        //
        //        // lap qua tat ca cac thiet bi chup anh tren dien thoai
        //        for device in devices {
        //            // kiem tra thiet bi ho tro video khong
        //            if (device.hasMediaType(AVMediaTypeVideo)) {
        //                // Kiem tra vi tri va xac nhan da co camera truoc
        //                if(device.position == AVCaptureDevicePosition.Front) {
        //                    captureDevice = device as? AVCaptureDevice
        //                    if captureDevice != nil {
        //                        print("Capture device found")
        //                        beginSession()
        //                    }
        //                }
        //            }
        //        }
        
        view.multipleTouchEnabled = true
        
        label.text = "Put on here"
        
        label.textAlignment = NSTextAlignment.Center
        
        
        view.addSubview(label)
        
    }
    //    func updateDeviceSettings(focusValue : Float, isoValue : Float) {
    //        let error: NSErrorPointer = nil
    //
    //        if let device = captureDevice {
    //            do {
    //                try captureDevice!.lockForConfiguration()
    //
    //            } catch let error1 as NSError {
    //                error.memory = error1
    //            }
    //
    //            device.setFocusModeLockedWithLensPosition(focusValue, completionHandler: { (time) -> Void in
    //
    //            })
    //
    //            // Adjust the iso to clamp between minIso and maxIso based on the active format
    //            //dieu chinh iso de kep giua minIso va maxIso dua tren dinh dang hoat dong
    //            let minISO = device.activeFormat.minISO
    //            let maxISO = device.activeFormat.maxISO
    //            let clampedISO = isoValue * (maxISO - minISO) + minISO
    //
    //            device.setExposureModeCustomWithDuration(AVCaptureExposureDurationCurrent, ISO: clampedISO, completionHandler: { (time) -> Void in
    //                //
    //            })
    //
    //            device.unlockForConfiguration()
    //
    //        }
    //    }
    //    func touchPercent(touch : UITouch) -> CGPoint {
    //        // Get the dimensions of the screen in points
    //        //lay kich thuoc man hinh tai cac diem
    //        let screenSize = UIScreen.mainScreen().bounds.size
    //        //tao mot tap doi tuong CGPoint trong dat 0,0
    //        // Create an empty CGPoint object set to 0, 0
    //        var touchPer = CGPointZero
    //        //dat x/y la vi tri cham, chia boi width/height cua man hinh
    //        // Set the x and y values to be the value of the tapped position, divided by the width/height of the screen
    //        touchPer.x = touch.locationInView(self.view).x / screenSize.width
    //        touchPer.y = touch.locationInView(self.view).y / screenSize.height
    //        //tra ve toa do CGPoint
    //        // Return the populated CGPoint
    //
    //        return touchPer
    //    }
    //    func focusTo(value : Float) {
    //        let error: NSErrorPointer = nil
    //
    //
    //        if let device = captureDevice {
    //            do {
    //                try captureDevice!.lockForConfiguration()
    //
    //            } catch let error1 as NSError {
    //                error.memory = error1
    //            }
    //
    //            device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
    //                //
    //            })
    //            device.unlockForConfiguration()
    //
    //        }
    //    }
    
    //    let screenWidth = UIScreen.mainScreen().bounds.size.width
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        
        //        let touchPer = touchPercent( touches.first! as UITouch )
        //        updateDeviceSettings(Float(touchPer.x), isoValue: Float(touchPer.y))
        //        super.touchesBegan(touches, withEvent:event)
        
        for touch in touches
        {
            label.hidden = true
            let circle = CirclesLabel()
            circle.drawAtPoint(touch.locationInView(view),
                               force: touch.force / touch.maximumPossibleForce)
            circles[touch] = circle
            view.layer.addSublayer(circle)
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        //        let touchPer = touchPercent( touches.first! as UITouch )
        //        updateDeviceSettings(Float(touchPer.x), isoValue: Float(touchPer.y))
        for touch in touches where circles[touch] != nil
        {
            
            
            let circle = circles[touch]!
            circle.drawAtPoint(touch.locationInView(view),
                               force: touch.force / touch.maximumPossibleForce)
        }
        
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        for touch in touches where circles[touch] != nil
        {
            let circle = circles[touch]!
            
            circles.removeValueForKey(touch)
            circle.removeFromSuperlayer()
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?)
    {
        guard let touches = touches else
        {
            return
        }
        
        for touch in touches where circles[touch] != nil
        {
            let circle = circles[touch]!
            
            circle.removeFromSuperlayer()
        }
    }
    //    func configureDevice() {
    //        let error: NSErrorPointer = nil
    //        if let device = captureDevice {
    //
    //            do {
    //                try captureDevice!.lockForConfiguration()
    //
    //            } catch let error1 as NSError {
    //                error.memory = error1
    //            }
    //
    //            device.focusMode = .Locked
    //            device.unlockForConfiguration()
    //        }
    //
    //    }
    
    //    func beginSession() {
    //        configureDevice()
    //        var err : NSError? = nil
    //
    //        var deviceInput: AVCaptureDeviceInput!
    //
    //        do {
    //            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
    //
    //        } catch let error as NSError {
    //            err = error
    //            deviceInput = nil
    //        };
    //
    //
    //        captureSession.addInput(deviceInput)
    //
    //        if err != nil {
    //            print("error: \(err?.localizedDescription)")
    //        }
    //
    //        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    //
    //        self.view.layer.addSublayer(previewLayer!)
    //        previewLayer?.frame = self.view.layer.frame
    //        captureSession.startRunning()
    //    }
    //    override func viewDidLayoutSubviews()
    //    {
    //        label.frame = view.bounds
    //
    //    }
}

class CirclesLabel: CAShapeLayer
{
    let text = CATextLayer()
    override init()
    {
        super.init()
        text.foregroundColor = UIColor.purpleColor().CGColor
        text.alignmentMode = kCAAlignmentCenter
        addSublayer(text)
        strokeColor = UIColor.purpleColor().CGColor
        lineWidth = 5
        fillColor = nil
        //nil: bien chua co gia tri, chua duoc khoi tao, chua duoc gan gia
        //vong tron se khong duoc do mau khi de gia tri nil
    }
    override init(layer: AnyObject)
    {
        super.init(layer: layer)
    }
    required init?(coder Decoder: NSCoder)
    {
        fatalError("init(coder:) Khong duoc thuc hien")
    }
    func drawAtPoint(location: CGPoint, force: CGFloat)
    {
        let bankinh = 100 + (force * 1)
        
        path = UIBezierPath(
            ovalInRect: CGRect(
                origin: location.offset(dx: bankinh, dy: bankinh),
                size: CGSize(width: bankinh * 2, height: bankinh * 2))).CGPath
        let gram = force * 337
        let roundGram = Int(gram)
        let string1 = String("\(roundGram) grams")
        //text.string = String(format: "%.f" + " g", force * 337)
        //text.string = String(string1,location.offset(dx: bankinh, dy: bankinh))
        text.string = String(string1)
        text.frame = CGRect(origin: location.offset(dx: 75, dy: -bankinh),
                            size: CGSize(width: 300, height: 50))
    }
}
//them thuoc tinh moi offset vao CGPoint
extension CGPoint
{
    func offset(dx dx: CGFloat, dy: CGFloat) -> CGPoint
    {
        return CGPoint(x: self.x - dx, y: self.y - dy)
    }
}


