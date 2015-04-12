//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Matthew Reyes on 3/21/15.
//  Copyright (c) 2015 Matthew Reyes. All rights reserved.
//

import UIKit
import AVFoundation



class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var rate: Float!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) { // plays recorded audio slow
        stopAllAudio()
        playAudio(rate = 0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) { // plays recorded audio fast
        stopAllAudio()
        playAudio(rate = 1.25)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) { // plays recorded audio at a higher pitch using playAudio...Func
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func PlayDarthvaderAudio(sender: UIButton) { // plays recorded audio at a lower pitch using playAudio...Func
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopPlayAudio(sender: AnyObject) {
        stopAllAudio()
    }
    
    func playAudioWithVariablePitch(pitch: Float){ // function that alters the recorded audios pitch
        stopAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func stopAllAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
    }
    
    func playAudio(){
        audioPlayer.rate = rate
        audioPlayer.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
