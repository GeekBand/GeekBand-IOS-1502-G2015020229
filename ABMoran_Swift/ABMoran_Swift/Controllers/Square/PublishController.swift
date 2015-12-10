//
//  PublishController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/27/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class PublishController : UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,UITextViewDelegate,CLLocationManagerDelegate{
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var locationManager: CLLocationManager!
    
    var img:UIImage!
    
    //@property (strong, nonatomic) NSMutableDictionary *dic;
    
    let user = NSUserDefaults.standardUserDefaults();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.backgroundColor = UIColor(red: 230/255.0, green: 106/255.0, blue: 58/255.0, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 230/255.0, green: 106/255.0, blue: 58/255.0, alpha: 1)
        self.navigationController!.navigationBar.alpha = 1.0
        self.textView.delegate = self;
        let title = UILabel(frame: CGRectMake(self.view.frame.size.width/2-30, 10, 100, 30))
        title.text = "发布照片"
        title.textColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(title)
        photoView.image = img
        
        makePublishButton()
        makeBackButton()
    }
    
    @IBAction func pickImage(sender: AnyObject){
        let picker = UIImagePickerController()
        let alert = UIAlertController(title: nil, message: nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(picker, animated:true ,completion:nil)
        }))
        alert.addAction(UIAlertAction(title: "相册", style: UIAlertActionStyle.Default, handler: {
            (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(picker, animated:true ,completion:nil)
        }))
        self.presentViewController(alert, animated:true ,completion:nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        self.photoView.image = image;
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func makePublishButton(){
        let publishButton = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("publishButtonClicked"))
        self.navigationItem.rightBarButtonItem = publishButton
    }
    
    func makeBackButton(){
        let backButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backButtonClicked"))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func backButtonClicked(){
        Navigator.GotoMainView()
    }
    
    func publishButtonClicked(){
        self.pleaseWait()
        let imageData:NSData = UIImageJPEGRepresentation(self.photoView.image!,0.1)!
        let request = NSMutableURLRequest(URL: NSURL(string: "http://moran.chinacloudapp.cn/moran/web/picture/create")!)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 10
        
        let form:BLMultipartForm = BLMultipartForm()
        form.addValue(user.stringForKey("user_id")!, forField: "user_id")
        form.addValue(user.stringForKey("token")!, forField: "token")
        form.addValue(imageData, forField: "data")
        form.addValue(textView.text, forField: "title")
        
        form.addValue("上海市浦东新区", forField: "location")
        form.addValue("121.47794", forField: "longitude")
        form.addValue("31.22516", forField: "latitude")
        form.addValue("上海市浦东新区", forField: "addr")
        
        
        request.addValue(form.contentType(), forHTTPHeaderField: "Content-Type")
        request.HTTPBody = form.httpBody()
        
        let session = NSURLSession.sharedSession()
        let task:NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            self.clearAllNotice()
            if error == nil{
                self.noticeSuccess("上传成功!")
                Navigator.GotoMainView()
            }
        }
        task.resume()
    }
    
    func touchDown(sender: AnyObject){
        
    }
    
    //    func getLatitudeAndLongitude(){
    //        self.locationManager = [[CLLocationManager alloc]init];
    //        self.locationManager.delegate = self;
    //        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //
    //        self.locationManager.distanceFilter = 1000.0f;
    //        if ([[[UIDevice currentDevice] systemVersion]floatValue] >= 8.0) {
    //            [_locationManager requestWhenInUseAuthorization];
    //        }
    //        if ([CLLocationManager locationServicesEnabled]) {
    //            [self.locationManager startUpdatingLocation];
    //        } else {
    //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"定位失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    //            [alert show];
    //        }
    //
    //    }
    //
    //    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
    //        self.dic = [NSMutableDictionary dictionary];
    //        NSString *latitudeString = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    //        NSString *longitudeString = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    //        [self.dic setValue:latitudeString forKey:@"latitude"];
    //        [self.dic setValue:longitudeString forKey:@"longtitude"];
    //        CLLocationDegrees latitude = newLocation.coordinate.latitude;
    //        CLLocationDegrees longitude = newLocation.coordinate.longitude;
    //        CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    //        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    //        if (!error && [placemarks count] > 0) {
    //        NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
    //        // TODO:
    //        NSString *locationLabelText = dict[@"Name"];
    //        
    //        } else {
    //        NSLog(@"Error: %@", error);
    //        }
    //        }];
    //        [manager stopUpdatingLocation];
    //    }

}