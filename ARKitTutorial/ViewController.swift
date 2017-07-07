//
//  ViewController.swift
//  ARKitTutorial
//
//  Created by Jothi Ramaswamy on 7/7/17.
//  Copyright © 2017 Jothi Ramaswamy. All rights reserved.
//

import UIKit
import ARKit
import SceneKit


class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    
    let colors = [UIColor.green, UIColor.black, UIColor.blue, UIColor.brown, UIColor.purple, UIColor.red, UIColor.cyan, UIColor.darkGray, UIColor.gray, UIColor.lightGray, UIColor.magenta, UIColor.orange, UIColor.white, UIColor.yellow]
    
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    @IBAction func addCube(_ sender: Any) {
        
        let cubePosition = getCameraCoordinates(sceneView: sceneView)
        
        var cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        
        cube.firstMaterial?.diffuse.contents = color
        
        let cubeNode = SCNNode(geometry: cube)
        
        cubeNode.geometry?.firstMaterial?.lightingModel = .physicallyBased
        
        cubeNode.position = SCNVector3(cubePosition.x, cubePosition.y, cubePosition.z)
        sceneView.scene.rootNode.addChildNode(cubeNode)
        
    }
    @IBAction func addCup(_ sender: Any) {
        
        let sphere = SCNSphere(radius: 0.1)
        
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        
        sphere.firstMaterial?.diffuse.contents = color
        
        let cupNode = SCNNode(geometry: sphere)
        
        cupNode.geometry?.firstMaterial?.lightingModel = .physicallyBased
        
        let cupPosition = getCameraCoordinates(sceneView: sceneView)
        cupNode.position = SCNVector3(cupPosition.x, cupPosition.y, cupPosition.z)
        sceneView.scene.rootNode.addChildNode(cupNode)
    }
    
    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

