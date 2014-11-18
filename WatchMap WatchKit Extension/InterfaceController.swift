//
//  InterfaceController.swift
//  WatchMap WatchKit Extension
//
//  Created by Douglas Bumby on 2014-11-18.
//  Copyright (c) 2014 Cosmic. All rights reserved.
//

import WatchKit
import Foundation
import MapKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var map: WKInterfaceMap? = WKInterfaceMap()
    var currentRegion: MKCoordinateRegion = MKCoordinateRegion(center: (CLLocationCoordinate2DMake(35.4, 139.4)),
                                                               span: (MKCoordinateSpanMake(1.0, 1.0)))
    
    var currentSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
    
    @IBOutlet var appleButton: WKInterfaceButton?
    @IBOutlet var tokyoButton: WKInterfaceButton?
    @IBOutlet var inButton: WKInterfaceButton?
    @IBOutlet var outButton: WKInterfaceButton?
    @IBOutlet var pinsButton: WKInterfaceButton?
    @IBOutlet var imagesButton: WKInterfaceButton?
    @IBOutlet var removeAllButton: WKInterfaceButton?
    
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        
        // Configure interface objects here.
        print("%@ init", self)
    }

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
        goToApple()
    }

    override func didDeactivate() {
        // This method is called when the controller is no longer visible.
        print("%@ did deactivate", self)
        super.didDeactivate()
    }
    
    @IBAction func goToTokyo() {
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.4, 139.4)
        setMapToCoordinate(coordinate)
    }
    
    @IBAction func goToApple() {
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.331793, -122.029584)
        setMapToCoordinate(coordinate)
    }
    
    func setMapToCoordinate(coordinate: CLLocationCoordinate2D) {
        var region: MKCoordinateRegion = MKCoordinateRegionMake(coordinate, currentSpan)
        currentRegion = region
        
        var newCenterPoint: MKMapPoint = MKMapPointForCoordinate(coordinate)
        map?.setMapRect(MKMapRectMake(newCenterPoint.x, newCenterPoint.y, currentSpan.latitudeDelta, currentSpan.longitudeDelta))
        map?.setCoordinateRegion(region)
    }
    
    @IBAction func zoomOut() {
        var span: MKCoordinateSpan = MKCoordinateSpanMake(currentSpan.latitudeDelta * 2, currentSpan.longitudeDelta * 2)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(currentSpan.center, span)
        
        currentSpan = span
        map?.setCoordinateRegion(region)
    }
    
    @IBAction func zoomIn() {
        var span: MKCoordinateSpan = MKCoordinateSpanMake(currentSpan.latitudeDelta * 0.5, currentSpan.longitudeDelta * 0.5)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(currentSpan.center, span)
        
        currentSpan = span
        map?.setCoordinateRegion(region)
    }

    @IBAction func addPinAnnotations() {
        map?.addAnnotation(currentRegion.center, withPinColor: WKInterfaceMapPinColor.Red)
        
        var greenCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentRegion.center, currentRegion.center.longitude - 0.3)
        map?.addAnnotation(greenCoordinate, withPinColor: WKInterfaceMapPinColor.Green)
        
        var purpleCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentRegion.center, currentRegion.center.longitude - 0.3)
        map?.addAnnotation(purpleCoordinate, withPinColor: WKInterfaceMapPinColor.Purple)
    }
    
    
    @IBAction func addImageAnnotations() {
        var firstCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude - 0.3)
        
        // Uses image in Watch app bundle.
        map?.addAnnotation(firstCoordinate, withImage: UIImage(named: "Whale"))
        
        var secondCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude + 0.3)
        
        // Uses image in WatchKit extension bundle
        let image: UIImage = UIImage(named: "Bumblebee")!
        map?.addAnnotation(secondCoordinate, withImage: image)
        
    }
    
    @IBAction func removeAll() {
        map?.removeAllAnnotations()
    }

}
