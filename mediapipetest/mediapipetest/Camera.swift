//
//  Camera.swift
//  mediapipetest
//
//  Created by Santiago Calvo on 5/7/20.
//  Copyright © 2020 Eagerworks. All rights reserved.
//

import AVFoundation
import UIKit

class Camera {
  lazy var session = AVCaptureSession()
  lazy var input = try! AVCaptureDeviceInput(device: device)
  lazy var device = AVCaptureDevice.default(
    .builtInWideAngleCamera,
    for: .video,
    position: .front)!

  lazy var output = AVCaptureVideoDataOutput()

  init() {
    output.videoSettings = [
      kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_32BGRA
    ]
    session.addInput(input)
    session.addOutput(output)
    session.connections[0].videoOrientation = .portrait
    session.connections[0].isVideoMirrored = true
  }

  func setMetadataDelegate(delegate: AVCaptureMetadataOutputObjectsDelegate?) {
    let metadataOutput = AVCaptureMetadataOutput()

    metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)

    metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
  }

  func setSampleBufferDelegate(
    _ delegate: AVCaptureVideoDataOutputSampleBufferDelegate?
  ) {
    output.setSampleBufferDelegate(delegate, queue: .main)
  }

  var isRunning: Bool {
    session.isRunning
  }

  func start() {
    UIApplication.shared.isIdleTimerDisabled = true
    session.startRunning()
  }

  func stop() {
    UIApplication.shared.isIdleTimerDisabled = false
    session.stopRunning()
  }
}

