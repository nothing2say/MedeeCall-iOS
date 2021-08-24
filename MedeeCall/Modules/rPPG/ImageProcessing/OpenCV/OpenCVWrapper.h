//
//  OpenCVWrapper.h
//  MedeeCall
//
//  Created by Nothing2saY on 2021/03/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#ifdef __cplusplus
//    #import <opencv2/videoio/cap_ios.h>
//#endif

//@protocol CvVideoCameraDelegate <NSObject>
//#ifdef __cplusplus
//// delegate method for processing image frames
//- (void)processImage:(UIImageView *)image;
//#endif
//
//@end

//@class FooCvVideoCamera;
//
//@protocol CvVideoCameraDelegate <NSObject>
//
//#ifdef __cplusplus
//// delegate method for processing image frames
//- (void)processImage:(void*)image;
//#endif
//
//@end

NS_ASSUME_NONNULL_BEGIN

@protocol OpenCVWrapperDelegate <NSObject>
- (void)framesReady:(bool) videoProcessingPaused
                   :(double) actualFPS;

- (void)frameAvailable:(UIImage*) frame
                      :(float) heartRateProgress
                      :(int) frameNumber;
@end

@protocol OpenCVImageProcessorDelegate <NSObject>
- (void)framesProcessed:(int)frameCount
                       :(NSMutableArray*) redPixels
                       :(NSMutableArray*) greenPixelsIn
                       :(NSMutableArray*) bluePixelsIn
                       :(double)fps;

- (void)frameReady: (UIImage*) frame
                  : (float) heartRateProgress
                  : (int) frameNumber;
                        
@end

@interface OpenCVWrapper : NSObject<OpenCVImageProcessorDelegate>

@property(nonatomic, weak)id <OpenCVWrapperDelegate> delegate;

- (id) init;

- (NSString *)openCVVersionString;
- (UIImage *)loadImage: (NSString *)imageName;
- (BOOL)initializeCamera:(int)framesPerHeartRateSample
                        :(int)frameRate;

- (void) startCamera :(int)frameRate;
- (void) stopCamera;
- (void) resumeCamera :(int)framesPerHeartRateSample;

- (NSMutableArray*)getRedPixels;
- (NSMutableArray*)getGreenPixels;
- (NSMutableArray*)getBluePixels;
- (double)getActualFps;


@end

NS_ASSUME_NONNULL_END
