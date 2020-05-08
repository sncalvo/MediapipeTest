//
//  MediapipeHandler.swift
//  mediapipetest
//
//  Created by Santiago Calvo on 5/7/20.
//  Copyright © 2020 Eagerworks. All rights reserved.
//


import UIKit
import SwiftUI
import AVFoundation

final class MediapipeHandler: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
  let camera = Camera()
  var tracker: HandTracker? = HandTracker()
  var previewLayer: AVSampleBufferDisplayLayer!


  override func viewDidLoad() {
    super.viewDidLoad()
    camera.setSampleBufferDelegate(self)
    camera.start()
    tracker!.startGraph()
    tracker!.delegate = self

    view.backgroundColor = UIColor.black

    previewLayer = AVSampleBufferDisplayLayer()
    previewLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
    previewLayer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer)
  }

  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    previewLayer.enqueue(sampleBuffer)
    let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
    tracker!.processVideoFrame(pixelBuffer)
  }

  deinit {
    self.tracker = nil
  }
}

extension MediapipeHandler: TrackerDelegate {
  func handTracker(_ handTracker: HandTracker!, didOutputLandmarks landmarks: [Landmark]!) {
    print(landmarks!)
  }

  func handTracker(_ handTracker: HandTracker!, didOutputPixelBuffer pixelBuffer: CVPixelBuffer!) {
    var newSampleBuffer: CMSampleBuffer? = nil
    var timimgInfo: CMSampleTimingInfo = CMSampleTimingInfo.invalid
    var videoInfo: CMVideoFormatDescription? = nil

    CMVideoFormatDescriptionCreateForImageBuffer(allocator: nil, imageBuffer: pixelBuffer, formatDescriptionOut: &videoInfo)
    CMSampleBufferCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: pixelBuffer, dataReady: true, makeDataReadyCallback: nil, refcon: nil, formatDescription: videoInfo!, sampleTiming: &timimgInfo, sampleBufferOut: &newSampleBuffer)

    setSampleBufferAttachments(newSampleBuffer!)
    previewLayer.enqueue(newSampleBuffer!)
  }

  func setSampleBufferAttachments(_ sampleBuffer: CMSampleBuffer) {
    let attachments: CFArray! = CMSampleBufferGetSampleAttachmentsArray(sampleBuffer, createIfNecessary: true)
    let dictionary = unsafeBitCast(CFArrayGetValueAtIndex(attachments, 0),
                                   to: CFMutableDictionary.self)
    let key = Unmanaged.passUnretained(kCMSampleAttachmentKey_DisplayImmediately).toOpaque()
    let value = Unmanaged.passUnretained(kCFBooleanTrue).toOpaque()
    CFDictionarySetValue(dictionary, key, value)
  }
}

extension MediapipeHandler: UIViewControllerRepresentable {
  typealias UIViewControllerType = MediapipeHandler

  func makeUIViewController(
    context: UIViewControllerRepresentableContext<MediapipeHandler>
  ) -> MediapipeHandler {
    MediapipeHandler()
  }

  func updateUIViewController(
    _ uiViewController: MediapipeHandler,
    context: UIViewControllerRepresentableContext<MediapipeHandler>
  ) {
  }
}
