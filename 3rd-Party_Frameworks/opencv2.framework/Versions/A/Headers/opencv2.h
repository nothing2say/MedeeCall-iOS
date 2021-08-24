#import <Foundation/Foundation.h>

// ! Project version number
FOUNDATION_EXPORT double opencv2VersionNumber;

// ! Project version string
FOUNDATION_EXPORT const unsigned char opencv2VersionString[];

#import <opencv2/MatOfRect2d.h>
#import <opencv2/MatOfFloat4.h>
#import <opencv2/MatOfPoint2i.h>
#import <opencv2/Double3.h>
#import <opencv2/MatOfByte.h>
#import <opencv2/Range.h>
#import <opencv2/Size2f.h>
#import <opencv2/Converters.h>
#import <opencv2/Mat.h>
#import <opencv2/ByteVector.h>
#import <opencv2/Point2f.h>
#import <opencv2/KeyPoint.h>
#import <opencv2/Rect2f.h>
#import <opencv2/Float6.h>
#import <opencv2/MatOfKeyPoint.h>
#import <opencv2/MatOfRect2i.h>
#import <opencv2/FloatVector.h>
#import <opencv2/TermCriteria.h>
#import <opencv2/Int4.h>
#import <opencv2/MatOfDMatch.h>
#import <opencv2/Scalar.h>
#import <opencv2/Point3f.h>
#import <opencv2/MatOfDouble.h>
#import <opencv2/IntVector.h>
#import <opencv2/RotatedRect.h>
#import <opencv2/MatOfFloat6.h>
#import <opencv2/DoubleVector.h>
#import <opencv2/Size2d.h>
#import <opencv2/MinMaxLocResult.h>
#import <opencv2/MatOfInt4.h>
#import <opencv2/Rect2i.h>
#import <opencv2/Point2i.h>
#import <opencv2/MatOfPoint3.h>
#import <opencv2/MatOfRotatedRect.h>
#import <opencv2/DMatch.h>
#import <opencv2/Point3i.h>
#import <opencv2/CvType.h>
#import <opencv2/CVObjcUtil.h>
#import <opencv2/Size2i.h>
#import <opencv2/Float4.h>
#import <opencv2/MatOfFloat.h>
#import <opencv2/Rect2d.h>
#import <opencv2/MatOfPoint2f.h>
#import <opencv2/Point2d.h>
#import <opencv2/Double2.h>
#import <opencv2/MatOfInt.h>
#import <opencv2/ArrayUtil.h>
#import <opencv2/MatOfPoint3f.h>
#import <opencv2/Point3d.h>
#import <opencv2/Core.h>
#import <opencv2/Algorithm.h>
#import <opencv2/TickMeter.h>
#import <opencv2/Moments.h>
#import <opencv2/Imgproc.h>
#import <opencv2/CLAHE.h>
#import <opencv2/GeneralizedHough.h>
#import <opencv2/GeneralizedHoughBallard.h>
#import <opencv2/GeneralizedHoughGuil.h>
#import <opencv2/LineSegmentDetector.h>
#import <opencv2/Subdiv2D.h>
#import <opencv2/Ml.h>
#import <opencv2/ANN_MLP.h>
#import <opencv2/Boost.h>
#import <opencv2/DTrees.h>
#import <opencv2/EM.h>
#import <opencv2/KNearest.h>
#import <opencv2/LogisticRegression.h>
#import <opencv2/NormalBayesClassifier.h>
#import <opencv2/ParamGrid.h>
#import <opencv2/RTrees.h>
#import <opencv2/SVM.h>
#import <opencv2/SVMSGD.h>
#import <opencv2/StatModel.h>
#import <opencv2/TrainData.h>
#import <opencv2/Phase_unwrapping.h>
#import <opencv2/HistogramPhaseUnwrapping.h>
#import <opencv2/HistogramPhaseUnwrappingParams.h>
#import <opencv2/PhaseUnwrapping.h>
#import <opencv2/Photo.h>
#import <opencv2/AlignExposures.h>
#import <opencv2/AlignMTB.h>
#import <opencv2/CalibrateCRF.h>
#import <opencv2/CalibrateDebevec.h>
#import <opencv2/CalibrateRobertson.h>
#import <opencv2/MergeDebevec.h>
#import <opencv2/MergeExposures.h>
#import <opencv2/MergeMertens.h>
#import <opencv2/MergeRobertson.h>
#import <opencv2/Tonemap.h>
#import <opencv2/TonemapDrago.h>
#import <opencv2/TonemapMantiuk.h>
#import <opencv2/TonemapReinhard.h>
#import <opencv2/Plot.h>
#import <opencv2/Plot2d.h>
#import <opencv2/Xphoto.h>
#import <opencv2/GrayworldWB.h>
#import <opencv2/LearningBasedWB.h>
#import <opencv2/SimpleWB.h>
#import <opencv2/TonemapDurand.h>
#import <opencv2/WhiteBalancer.h>
#import <opencv2/Dnn.h>
#import <opencv2/ClassificationModel.h>
#import <opencv2/DetectionModel.h>
#import <opencv2/DictValue.h>
#import <opencv2/KeypointsModel.h>
#import <opencv2/Layer.h>
#import <opencv2/Model.h>
#import <opencv2/Net.h>
#import <opencv2/SegmentationModel.h>
#import <opencv2/TextDetectionModel.h>
#import <opencv2/TextDetectionModel_DB.h>
#import <opencv2/TextDetectionModel_EAST.h>
#import <opencv2/TextRecognitionModel.h>
#import <opencv2/Features2d.h>
#import <opencv2/AKAZE.h>
#import <opencv2/AffineFeature.h>
#import <opencv2/AgastFeatureDetector.h>
#import <opencv2/BFMatcher.h>
#import <opencv2/BOWImgDescriptorExtractor.h>
#import <opencv2/BOWKMeansTrainer.h>
#import <opencv2/BOWTrainer.h>
#import <opencv2/BRISK.h>
#import <opencv2/DescriptorMatcher.h>
#import <opencv2/FastFeatureDetector.h>
#import <opencv2/Feature2D.h>
#import <opencv2/FlannBasedMatcher.h>
#import <opencv2/GFTTDetector.h>
#import <opencv2/KAZE.h>
#import <opencv2/MSER.h>
#import <opencv2/ORB.h>
#import <opencv2/SIFT.h>
#import <opencv2/SimpleBlobDetector.h>
#import <opencv2/SimpleBlobDetectorParams.h>
#import <opencv2/Mat+Converters.h>
#import <opencv2/Imgcodecs.h>
#import <opencv2/Text.h>
#import <opencv2/BaseOCR.h>
#import <opencv2/ERFilter.h>
#import <opencv2/ERFilterCallback.h>
#import <opencv2/OCRBeamSearchDecoder.h>
#import <opencv2/OCRBeamSearchDecoderClassifierCallback.h>
#import <opencv2/OCRHMMDecoder.h>
#import <opencv2/OCRHMMDecoderClassifierCallback.h>
#import <opencv2/OCRTesseract.h>
#import <opencv2/TextDetector.h>
#import <opencv2/TextDetectorCNN.h>
#import <opencv2/CvCamera2.h>
#import <opencv2/Videoio.h>
#import <opencv2/VideoCapture.h>
#import <opencv2/VideoWriter.h>
#import <opencv2/Wechat_qrcode.h>
#import <opencv2/WeChatQRCode.h>
#import <opencv2/Calib3d.h>
#import <opencv2/CirclesGridFinderParameters.h>
#import <opencv2/StereoBM.h>
#import <opencv2/StereoMatcher.h>
#import <opencv2/StereoSGBM.h>
#import <opencv2/UsacParams.h>
#import <opencv2/Objdetect.h>
#import <opencv2/BaseCascadeClassifier.h>
#import <opencv2/CascadeClassifier.h>
#import <opencv2/HOGDescriptor.h>
#import <opencv2/QRCodeDetector.h>
#import <opencv2/Structured_light.h>
#import <opencv2/GrayCodePattern.h>
#import <opencv2/SinusoidalPattern.h>
#import <opencv2/SinusoidalPatternParams.h>
#import <opencv2/StructuredLightPattern.h>
#import <opencv2/Video.h>
#import <opencv2/BackgroundSubtractor.h>
#import <opencv2/BackgroundSubtractorKNN.h>
#import <opencv2/BackgroundSubtractorMOG2.h>
#import <opencv2/DISOpticalFlow.h>
#import <opencv2/DenseOpticalFlow.h>
#import <opencv2/FarnebackOpticalFlow.h>
#import <opencv2/KalmanFilter.h>
#import <opencv2/SparseOpticalFlow.h>
#import <opencv2/SparsePyrLKOpticalFlow.h>
#import <opencv2/Tracker.h>
#import <opencv2/TrackerGOTURN.h>
#import <opencv2/TrackerGOTURNParams.h>
#import <opencv2/TrackerMIL.h>
#import <opencv2/TrackerMILParams.h>
#import <opencv2/VariationalRefinement.h>
#import <opencv2/Xfeatures2d.h>
#import <opencv2/AffineFeature2D.h>
#import <opencv2/BEBLID.h>
#import <opencv2/BoostDesc.h>
#import <opencv2/BriefDescriptorExtractor.h>
#import <opencv2/DAISY.h>
#import <opencv2/FREAK.h>
#import <opencv2/HarrisLaplaceFeatureDetector.h>
#import <opencv2/LATCH.h>
#import <opencv2/LUCID.h>
#import <opencv2/MSDDetector.h>
#import <opencv2/PCTSignatures.h>
#import <opencv2/PCTSignaturesSQFD.h>
#import <opencv2/SURF.h>
#import <opencv2/StarDetector.h>
#import <opencv2/TBMR.h>
#import <opencv2/VGG.h>
#import <opencv2/Ximgproc.h>
#import <opencv2/AdaptiveManifoldFilter.h>
#import <opencv2/ContourFitting.h>
#import <opencv2/DTFilter.h>
#import <opencv2/DisparityFilter.h>
#import <opencv2/DisparityWLSFilter.h>
#import <opencv2/EdgeAwareInterpolator.h>
#import <opencv2/EdgeBoxes.h>
#import <opencv2/FastBilateralSolverFilter.h>
#import <opencv2/FastGlobalSmootherFilter.h>
#import <opencv2/FastLineDetector.h>
#import <opencv2/GuidedFilter.h>
#import <opencv2/RFFeatureGetter.h>
#import <opencv2/RICInterpolator.h>
#import <opencv2/RidgeDetectionFilter.h>
#import <opencv2/SparseMatchInterpolator.h>
#import <opencv2/StructuredEdgeDetection.h>
#import <opencv2/SuperpixelLSC.h>
#import <opencv2/SuperpixelSEEDS.h>
#import <opencv2/SuperpixelSLIC.h>
#import <opencv2/GraphSegmentation.h>
#import <opencv2/SelectiveSearchSegmentation.h>
#import <opencv2/SelectiveSearchSegmentationStrategy.h>
#import <opencv2/SelectiveSearchSegmentationStrategyColor.h>
#import <opencv2/SelectiveSearchSegmentationStrategyFill.h>
#import <opencv2/SelectiveSearchSegmentationStrategyMultiple.h>
#import <opencv2/SelectiveSearchSegmentationStrategySize.h>
#import <opencv2/SelectiveSearchSegmentationStrategyTexture.h>
#import <opencv2/Aruco.h>
#import <opencv2/Board.h>
#import <opencv2/CharucoBoard.h>
#import <opencv2/DetectorParameters.h>
#import <opencv2/Dictionary.h>
#import <opencv2/GridBoard.h>
#import <opencv2/Bgsegm.h>
#import <opencv2/BackgroundSubtractorCNT.h>
#import <opencv2/BackgroundSubtractorGMG.h>
#import <opencv2/BackgroundSubtractorGSOC.h>
#import <opencv2/BackgroundSubtractorLSBP.h>
#import <opencv2/BackgroundSubtractorLSBPDesc.h>
#import <opencv2/BackgroundSubtractorMOG.h>
#import <opencv2/SyntheticSequenceGenerator.h>
#import <opencv2/Bioinspired.h>
#import <opencv2/Retina.h>
#import <opencv2/RetinaFastToneMapping.h>
#import <opencv2/TransientAreasSegmentationModule.h>
#import <opencv2/Face.h>
#import <opencv2/BIF.h>
#import <opencv2/BasicFaceRecognizer.h>
#import <opencv2/EigenFaceRecognizer.h>
#import <opencv2/FaceRecognizer.h>
#import <opencv2/Facemark.h>
#import <opencv2/FacemarkAAM.h>
#import <opencv2/FacemarkKazemi.h>
#import <opencv2/FacemarkLBF.h>
#import <opencv2/FacemarkTrain.h>
#import <opencv2/FisherFaceRecognizer.h>
#import <opencv2/LBPHFaceRecognizer.h>
#import <opencv2/MACE.h>
#import <opencv2/PredictCollector.h>
#import <opencv2/StandardCollector.h>
#import <opencv2/Tracking.h>
#import <opencv2/TrackerCSRT.h>
#import <opencv2/TrackerCSRTParams.h>
#import <opencv2/TrackerKCF.h>
#import <opencv2/TrackerKCFParams.h>
#import <opencv2/Img_hash.h>
#import <opencv2/AverageHash.h>
#import <opencv2/BlockMeanHash.h>
#import <opencv2/ColorMomentHash.h>
#import <opencv2/ImgHashBase.h>
#import <opencv2/MarrHildrethHash.h>
#import <opencv2/PHash.h>
#import <opencv2/RadialVarianceHash.h>