//
//  DSPFilter.h
//  MedeeCall
//
//  Created by Nothing2saY on 2021/03/22.
//

#ifndef DSPFilter_h
#define DSPFilter_h

#endif /* DSPFilter_h */

@interface DSPFilter : NSObject
- (void) butterworthFilter :(int)fps
                :(float*) data
                :(int)numSamples
                :(double) lowFrequency
                :(double) highFrequency;

@end

