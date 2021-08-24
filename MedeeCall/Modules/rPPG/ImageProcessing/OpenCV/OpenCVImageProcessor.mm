//
//  OpenCVImageProcessor.m
//  MedeeCall
//
//  Created by Nothing2saY on 2021/03/22.
//

#import <opencv2/opencv.hpp>
#import "OpenCVImageProcessor.h"
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/tracking.hpp>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@implementation OpenCVImageProcessor{
    UIImageView* opencvView;
    UILabel* heartrateLabel;
    UIProgressView* heartrateProgress;
    cv::CascadeClassifier faceDetector;
    int frameCount;
    int totalFrameCount;
    bool faceDetected;
    cv::Rect faceRect;
    cv::Ptr<cv::Tracker> faceTracker;
    NSMutableArray *bluePixel;
    NSMutableArray *greenPixel;
    NSMutableArray *redPixel;
    int framesPerHrReading;
//    bool videoProcessingPaused;
    CFTimeInterval startTime;
    UIImage* heartIcon;
}

- (void)processImage:(cv::Mat&)image;
{
    if( !self.videoProcessingPaused ){
        //NSLog(@"+++ processing video +++");
        cv::Mat grayImage;
        cv::cvtColor(image, grayImage, cv::ColorConversionCodes::COLOR_RGB2GRAY);
        cv::Rect trackRect;
        
        faceDetected = [self faceDetect:grayImage];
        //NSLog(@"~~~~~~~ image data: %s", image.data);
        
        CGRect iconRect;
        bool isFound = false;
        
        if( faceDetected ){
            //NSLog(@"++ face detected ++");
            cv::TrackerKCF::create();
            faceTracker = cv::TrackerKCF::create();
            faceTracker->init(grayImage,faceRect);
            
            isFound = faceTracker->update(grayImage, trackRect);
            //NSLog(@"?? is it found ??");
            
            if (trackRect.area() != 0) {
                //NSLog(@"-- trackRect is not 0 -");
                if( isFound ){
                    //NSLog(@"= trackRect = x: %d, y: %d, W: %d, H: %d", trackRect.x, trackRect.y, trackRect.width, trackRect.height);
                    
                    cv::Rect2d clipRect =  [[self class] clipRectToImage :trackRect :image];
                    cv::rectangle( image, clipRect, cv::Scalar( 255, 255, 255 ), 1, 1 );
                    
                    iconRect.origin.x = clipRect.x + clipRect.width/2 - clipRect.height/2;
                    iconRect.origin.y = clipRect.y;
                    iconRect.size.width = clipRect.height;
                    iconRect.size.height = clipRect.height;

                    frameCount++;
                    //NSLog(@"--- frameCount : %d", frameCount);
                    
                    [self processImageRect:image :clipRect];
                    
                } else {
                    NSLog(@"Lost tracking");
                    frameCount = 0;
                    faceDetected = false;
                    
                }
            } else {
                NSLog(@"... trackRect is empty ...");
                //faceDetected = false;
            }
            
        }
        else {
            NSLog(@"... Face tracking lost ...");
            // Reset
            frameCount = 0;
            startTime = CACurrentMediaTime();
            [redPixel removeAllObjects];
            [greenPixel removeAllObjects];
            [bluePixel removeAllObjects];
            
            //faceDetected = [self faceDetect:grayImage];
            
//            if( faceDetected ){
//                //NSLog(@"... Face detection reset ...");
//                frameCount = 0;
//                cv::TrackerKCF::create();
//                faceTracker = cv::TrackerKCF::create();
//                faceTracker->init(grayImage,faceRect);
//                startTime = CACurrentMediaTime();
//                [redPixel removeAllObjects];
//                [greenPixel removeAllObjects];
//                [bluePixel removeAllObjects];
//                //NSLog(@"... Face detection removed...");
//            }
        }
        
        UIImage* outImage = [[self class] UIImageFromCVMat:image];
        // Animate here

        if( isFound && (trackRect.area() != 0)){
            outImage = [self animateHeartIcon: iconRect : outImage ];
       
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate frameReady:outImage :(float)self->frameCount/(float)self->framesPerHrReading : ++self->totalFrameCount];
        });
    }
}

- (id)initWithOpenCVView:(int)framesPerHRReading
                        :(id<OpenCVImageProcessorDelegate>)del{
    self.videoProcessingPaused = false;
    frameCount = 0;
    totalFrameCount = 0;
    faceDetected = false;
    framesPerHrReading =framesPerHRReading;
    NSString *faceCascadePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_default"  ofType:@"xml"];
    const CFIndex CASCADE_NAME_LEN = 2048;
    char *CASCADE_NAME = (char *) malloc(CASCADE_NAME_LEN);
    CFStringGetFileSystemRepresentation( (CFStringRef)faceCascadePath, CASCADE_NAME, CASCADE_NAME_LEN);
    faceDetector.load(CASCADE_NAME);

    bluePixel = [[NSMutableArray alloc] init];
    greenPixel = [[NSMutableArray alloc] init];
    redPixel = [[NSMutableArray alloc] init];
    
    _delegate = del;
    
    heartIcon = [UIImage imageNamed:@"Heart-icon"];
    
    return self;
}

- (void)resume :(int)framesPerHeartRateReading{
    framesPerHrReading = framesPerHeartRateReading;
    faceDetected = false;
    frameCount = 0;
    self.videoProcessingPaused = false;
}

- (bool) faceDetect: (cv::Mat&) image {
    
    std::vector<cv::Rect> faceRects;
    
    double scalingFactor = 1.1;
    int minNeighbors = 2;
    int flags = 0;
    cv::Size minimumSize(30,30);
    faceDetector.detectMultiScale(image, faceRects,
                                  scalingFactor, minNeighbors, flags,
                                  cv::Size(30, 30) );
    
    if( faceRects.size() > 0 ){
        
        faceRect = faceRects[0];
        //NSLog(@"faceRect :: x=%d y=%d | W=%d H=%d", faceRect.x, faceRect.y, faceRect.width, faceRect.height);
    
        // Take the top 20% and middle 60% of the face rectangle
        faceRect.height = (int)((double)faceRect.height/5.0);
        faceRect.x = faceRect.x + (int)((double)faceRect.width/3.5);
        faceRect.y = faceRect.y + (int)((double)faceRect.height/2.0);
        faceRect.width = (int)(((double)faceRect.width*2.0)/5.0);
        cv::rectangle( image, faceRect, cv::Scalar( 0, 255, 0 ), 2, 2 );
        //NSLog(@"Face found");
        return true;
    }else{
        return false;
    }
}
+(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat {
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];

    CGColorSpaceRef colorSpace;
    CGBitmapInfo bitmapInfo;

    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
        bitmapInfo = kCGImageAlphaNone | kCGBitmapByteOrderDefault;
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
        bitmapInfo = kCGBitmapByteOrder32Little | (
            cvMat.elemSize() == 3? kCGImageAlphaNone : kCGImageAlphaNoneSkipFirst
        );
    }

    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);

    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(
        cvMat.cols,                 //width
        cvMat.rows,                 //height
        8,                          //bits per component
        8 * cvMat.elemSize(),       //bits per pixel
        cvMat.step[0],              //bytesPerRow
        colorSpace,                 //colorspace
        bitmapInfo,                 // bitmap info
        provider,                   //CGDataProviderRef
        NULL,                       //decode
        false,                      //should interpolate
        kCGRenderingIntentDefault   //intent
    );

    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);

    return finalImage;
}

+ (cv::Rect2d) clipRectToImage: (cv::Rect2d)clipRect :(cv::Mat&)image{
    cv::Size s = image.size();
    cv::Rect2d rectImage(0,0, s.width, s.height );
    cv::Rect2d result = clipRect & rectImage;   // Intersection of the two rectangles
    return result;
}

-(void) processImageRect: (cv::Mat&) image :(cv::Rect2d&) rect {
    
    //NSLog(@"= processImageRect = x: %f, y: %f, W: %f, H: %f", rect.x, rect.y, rect.width, rect.height);
    uint8_t* pixelPtr = (uint8_t*)image.data;
    int cn = image.channels();
//    cv::Scalar_<uint8_t> bgrPixel;
    uint8_t blue;
    uint8_t green;
    uint8_t red;
    double blueAcc = 0, greenAcc = 0, redAcc = 0;

    for(int i = rect.x; i < (rect.x + rect.width); i++)
    {
        for(int j = rect.y; j < (rect.y + rect.height); j++)
        {
            blue = pixelPtr[i*image.cols*cn + j*cn + 0]; // B
            green = pixelPtr[i*image.cols*cn + j*cn + 1]; // G
            red = pixelPtr[i*image.cols*cn + j*cn + 2]; // R
            blueAcc += blue;
            greenAcc += green;
            redAcc += red;
        }
    }
    blueAcc /= (rect.width*rect.height);
    greenAcc /= (rect.width*rect.height);
    redAcc /= (rect.width*rect.height);
    [bluePixel addObject:[NSNumber numberWithDouble:blueAcc]];
    [greenPixel addObject:[NSNumber numberWithDouble:greenAcc]];
    [redPixel addObject:[NSNumber numberWithDouble:redAcc]];
    
    //NSLog(@"@frameCount: %d", frameCount);
    NSLog(@"## Frame: %d --- R: %f, G: %f, B %f", frameCount, redAcc, greenAcc, blueAcc);
    
    if( frameCount %  framesPerHrReading  == 0){
        NSLog(@"... Calculating Pulse ...");
        self.videoProcessingPaused = true;
        CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
        double fps = (double)framesPerHrReading/elapsedTime;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate framesProcessed:self->framesPerHrReading :self->redPixel :self->greenPixel :self->bluePixel :fps ];
        });
    }
    
}
-(UIImage*) animateHeartIcon :(CGRect&) iconRect :(UIImage*) outImage {
    float animationFactor = (float)iconRect.size.width * 0.15; // Maximum size animation
    float frameFactor = (float)(frameCount%30);
    float animationValue = animationFactor / frameFactor; // Fixup. 30 is 30 fps
    iconRect = CGRectInset( iconRect, animationValue, animationValue );
    UIGraphicsBeginImageContextWithOptions(outImage.size, NO, 0.0);
    [outImage drawInRect:CGRectMake(0.0, 0.0, outImage.size.width, outImage.size.height)];
    [heartIcon drawInRect:iconRect];
    outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImage;

}
@end
