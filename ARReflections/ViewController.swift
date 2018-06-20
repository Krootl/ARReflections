//
//  ViewController.swift
//  ARReflections
//
//  Created by Ivan Nesterenko on 20/6/18.
//  Copyright © 2018 Ivan Nesterenko. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create scene view
        sceneView.scene = SCNScene()
        sceneView.delegate = self
        
        // Create sphere
        let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.1))
        sceneView.scene.rootNode.addChildNode(sphereNode)
        
        // Create material for sphere
        let reflectiveMaterial = SCNMaterial()
        reflectiveMaterial.lightingModel = .physicallyBased
        reflectiveMaterial.metalness.contents = 1.0
        reflectiveMaterial.roughness.contents = 0
        sphereNode.geometry?.firstMaterial = reflectiveMaterial
        
        // Animate the sphere
        let moveLeft = SCNAction.moveBy(x: 0.18, y: 0, z: 0, duration: 1)
        moveLeft.timingMode = .easeInEaseOut;
        let moveRight = SCNAction.moveBy(x: -0.18, y: 0, z: 0, duration: 1)
        moveRight.timingMode = .easeInEaseOut;
        let moveSequence = SCNAction.sequence([moveLeft, moveRight])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        sphereNode.runAction(moveLoop)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.environmentTexturing = ARWorldTrackingConfiguration.EnvironmentTexturing.automatic
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
