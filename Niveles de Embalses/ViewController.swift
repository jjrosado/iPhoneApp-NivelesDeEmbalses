//
//  ViewController.swift
//  Niveles de Embalses
//
//  Created by JRo....... on 9/8/15.
//  Copyright (c) 2015 Javier Rosado. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var resultDate: UILabel!
    
    @IBOutlet var resultTable: UITableView!
    
    var cellContent = [Dam]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //For Notifications test only
        //let push = PFPush()
        //
        //push.setMessage("This is a test! JJ")
        //push.sendPushInBackgroundWithBlock({
        //    (isSuccessful, error) -> Void in
        //    print(isSuccessful)
        //})
        //
        
        // Do any additional setup after loading the view, typically from a nib.
        
        GenerateContent()
        self.resultTable.delegate = self
        self.resultTable.dataSource = self
        self.resultTable.separatorStyle = .None
        self.resultTable.registerClass(PlacesTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PlacesTableViewCell))
        resultTable.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    @IBAction func btnShare(sender: UIBarButtonItem) {
        let textToShare = "Drops PR!  Entra al sitio web para ver el resultado de los niveles de los embalses!"
        
        if let myWebsite = NSURL(string: "http://www.dropspr.com/")
        {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    func showError(){
        
        resultDate.text = "No fue posible generar el resulto. Por favor vuelva a intentarlo mas tarde."
    }
    
    func GenerateContent() {
        //let urlPath = "http ://acueductospr.com/AAARepresas/reservoirlist"
        let urlPath = "https://past.acueductospr.com:8181/AAARepresas/reservoirlist"
        let endpoint = NSURL(string: urlPath)
        //let request = NSMutableURLRequest(URL:endpoint!)
        
        var dam = [Dam]()
        if endpoint != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(endpoint!, completionHandler: { (data, response, error) -> Void in
                var urlError = false
                var dif = ""
                var optimun = ""
                var dateReport = ""
                
                if error == nil {
                    
                    let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                    
                    //println(urlContent)
                    var date = urlContent.componentsSeparatedByString("<h3 class=\"sec-intro\">")
                    var embalse = urlContent.componentsSeparatedByString("<div class=\"locationLevel\">")
                    var diference = urlContent.componentsSeparatedByString("<div class=\"updown\">")
                    var average = urlContent.componentsSeparatedByString("<div class=\"average\">")
                    var scale = urlContent.componentsSeparatedByString("<div class=\"col-md-12 scale\">")
                    
                    if embalse.count > 0 {
                        
                        var dateArray = date[1].componentsSeparatedByString("</h3>")
                        dateReport = dateArray[0] as String
                        dateReport = dateReport.stringByReplacingOccurrencesOfString("<strong>", withString: "")
                        dateReport = dateReport.stringByReplacingOccurrencesOfString("</strong>", withString: "")
                        
                        
                        //for var i = 1; i <= 11;i += 1 {
                        for i in 1...11 {
                            
                            var embalseArray = embalse[i].componentsSeparatedByString("</div>")
                            var diferenceArray = diference[i].componentsSeparatedByString("</div>")
                            dif = diferenceArray[0] as String
                            dif = dif.stringByReplacingOccurrencesOfString("<strong>", withString: "")
                            dif = dif.stringByReplacingOccurrencesOfString("</strong>", withString: "")
                            
                            var averageArray = average[i].componentsSeparatedByString("</div>")
                            var scaleArray = scale[i].componentsSeparatedByString("</div>")
                            optimun = scaleArray[0] as String
                            optimun = optimun.stringByReplacingOccurrencesOfString("<div>", withString: "")
                            optimun = optimun.stringByReplacingOccurrencesOfString("<strong>", withString: "")
                            optimun = optimun.stringByReplacingOccurrencesOfString("</strong>", withString: "")
                            optimun = optimun.stringByReplacingOccurrencesOfString("N.", withString: "Nivel")
                            
                            let content = Dam(damData: ["damName": String(embalseArray[0] as NSString)
                                ,"difference": String(dif)
                                ,"average": String(averageArray[0] as NSString)
                                ,"optimun": String(optimun.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))])
                                
                            dam.append(content)
                        }
                        
                    }else{
                        urlError =  true
                    }
                }else{
                    urlError =  true
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                
                    if urlError == true {
                        self.showError()
                    }else{
                        self.resultDate.text = dateReport
                        self.cellContent = dam
                        self.resultTable.reloadData()
                    }
                }
                
            })
            task.resume()
            
        } else{
            self.showError()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return cellContent.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(PlacesTableViewCell), forIndexPath: indexPath) as! PlacesTableViewCell
        cell.dams = cellContent[indexPath.row]
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        resultTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
