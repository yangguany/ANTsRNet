[![Build Status](https://travis-ci.org/ANTsX/ANTsRNet.png?branch=master)](https://travis-ci.org/ANTsX/ANTsRNet)

# ANTsRNet

A collection of deep learning architectures ported to the R language and tools for basic medical image processing. Based on `keras` and `tensorflow`.

Applications available at [ANTsRNet Apps](https://github.com/ANTsRNet).

<!--
Examples available at [ANTsRNetExamples](https://github.com/ntustison/ANTsRNetExamples).
-->

Documentation page [https://antsx.github.io/ANTsRNet/](https://antsx.github.io/ANTsRNet/).

## Architectures

### Image voxelwise segmentation/regression

* U-Net (2-D, 3-D)
    * [O. Ronneberger, P. Fischer, and T. Brox.  U-Net: Convolutional Networks for Biomedical Image Segmentation.](https://arxiv.org/abs/1505.04597)
    * [Fausto Milletari, Nassir Navab, Seyed-Ahmad Ahmadi. V-Net: Fully Convolutional Neural Networks for Volumetric Medical Image Segmentation.](https://arxiv.org/pdf/1606.04797.pdf)
* U-Net + ResNet (2-D, 3-D)
    * [Michal Drozdzal, Eugene Vorontsov, Gabriel Chartrand, Samuel Kadoury, and Chris Pal.  The Importance of Skip Connections in Biomedical Image Segmentation.](https://arxiv.org/abs/1608.04117)
* Dense U-Net (2-D, 3-D)
    * [X. Li, H. Chen, X. Qi, Q. Dou, C.-W. Fu, P.-A. Heng. H-DenseUNet: Hybrid Densely Connected UNet for Liver and Tumor Segmentation from CT Volumes.](https://arxiv.org/pdf/1709.07330.pdf)

### Image classification/regression

* AlexNet (2-D, 3-D)
    * [A. Krizhevsky, and I. Sutskever, and G. Hinton. ImageNet Classification with Deep Convolutional Neural Networks.](http://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf)
* VGG (2-D, 3-D)
    * [K. Simonyan and A. Zisserman. Very Deep Convolutional Networks for Large-Scale Image Recognition.](https://arxiv.org/abs/1409.1556)
* GoogLeNet (Inception v3) (2-D)
    * [C. Szegedy, W. Liu, Y. Jia, P. Sermanet, S. Reed, D. Anguelov, D. Erhan, V. Vanhoucke, and A. Rabinovich. Going Deeper with Convolutions.](https://arxiv.org/abs/1512.00567)
* ResNet/ResNeXt (2-D, 3-D)
    * [Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun.  Deep Residual Learning for Image Recognition.](https://arxiv.org/abs/1512.03385)
    * [Saining Xie and Ross Girshick and Piotr Dollár and Zhuowen Tu and Kaiming He.  Aggregated Residual Transformations for Deep Neural Networks.](https://arxiv.org/abs/1611.05431)
* WideResNet (2-D, 3-D)
    * [Sergey Zagoruyko and Nikos Komodakis.  Wide Residual Networks.](http://arxiv.org/abs/1605.07146)
* DenseNet (2-D, 3-D)
    * [G. Huang, Z. Liu, K. Weinberger, and L. van der Maaten. Densely Connected Convolutional Networks Networks.](https://arxiv.org/abs/1608.06993)

### Object detection

* Single Shot MultiBox Detector (SSD) (2-D, 3-D)
    * [W. Liu, D. Anguelov, D. Erhan, C. Szegedy, S. Reed, C-Y. Fu, and A. Berg.  SSD: Single Shot MultiBox Detector.](https://arxiv.org/abs/1512.02325)
    * SSD7: small 7-layer architecture
    * SSD300/SSD512: porting of original architectures

### Image super-resolution

* Super-resolution convolutional neural network (SRCNN) (2-D, 3-D)
    * [Chao Dong, Chen Change Loy, Kaiming He, and Xiaoou Tang.  Image Super-Resolution Using Deep Convolutional Networks.](https://arxiv.org/abs/1501.00092)
* Expanded super-resolution (ESRCNN) (2-D, 3-D)
    * [Chao Dong, Chen Change Loy, Kaiming He, and Xiaoou Tang.  Image Super-Resolution Using Deep Convolutional Networks.](https://arxiv.org/abs/1501.00092)
* Denoising auto encoder super-resolution (DSRCNN) (2-D, 3-D)
* Deep denoise super-resolution (DDSRCNN) (2-D, 3-D)
    * [Xiao-Jiao Mao, Chunhua Shen, and Yu-Bin Yang.  Image Restoration Using Convolutional Auto-encoders with Symmetric Skip Connections](https://arxiv.org/abs/1606.08921)
* ResNet super-resolution (SRResNet) (2-D, 3-D)
    * [Christian Ledig, Lucas Theis, Ferenc Huszar, Jose Caballero, Andrew Cunningham, Alejandro Acosta, Andrew Aitken, Alykhan Tejani, Johannes Totz, Zehan Wang, and Wenzhe Shi.  Photo-Realistic Single Image Super-Resolution Using a Generative Adversarial Network.](https://arxiv.org/abs/1609.04802)
* Deep back-projection network (DBPN) (2-D, 3-D)
    * [Muhammad Haris, Greg Shakhnarovich, Norimichi Ukita.  Deep Back-Projection Networks For Super-Resolution.](https://arxiv.org/abs/1803.02735)

### Registration and transforms

* Spatial transformer network (STN) (2-D, 3-D)
    * [Max Jaderberg, Karen Simonyan, Andrew Zisserman, and Koray Kavukcuoglu.  Spatial Transformer Networks.](https://arxiv.org/abs/1506.02025)

### Generative adverserial networks

* Generative adverserial network (GAN)
    * [Ian J. Goodfellow, Jean Pouget-Abadie, Mehdi Mirza, Bing Xu, David Warde-Farley, Sherjil Ozair, Aaron Courville, Yoshua Bengio.  Generative Adverserial Networks.](https://arxiv.org/abs/1406.2661)

### Clustering

* Deep embedded clustering (DEC)
    * [Junyuan Xie, Ross Girshick, and Ali Farhadi.  Unsupervised Deep Embedding for Clustering Analysis.](https://arxiv.org/abs/1511.06335)
* Deep convolutional embedded clustering (DCEC)
    * [Xifeng Guo, Xinwang Liu, En Zhu, and Jianping Yin.  Deep Clustering with Convolutional Autoencoders.](https://xifengguo.github.io/papers/ICONIP17-DCEC.pdf)

### Miscellaneous

* Mixture density networks (MDN)
    * [Christopher M. Bishop.  Mixture Density Networks.](https://publications.aston.ac.uk/373/1/NCRG_94_004.pdf)

--------------------------------------

## Installation

* ANTsRNet Installation:
    * Option 1:
       ```
       $ R
       > devtools::install_github( "ANTsX/ANTsRNet" )
       ```
    * Option 2:
       ```
       $ git clone https://github.com/ANTsX/ANTsRNet.git
       $ R CMD INSTALL ANTsRNet
       ```

## Publications

* Nicholas J. Tustison, Brian B. Avants, Zixuan Lin, Xue Feng, Nicholas Cullen, Jaime F. Mata, Lucia Flors, James C. Gee, Talissa A. Altes, John P. Mugler III, and Kun Qing.  Convolutional Neural Networks with Template-Based Data Augmentation for Functional Lung Image Quantification, _Academic Radiology_. [(pubmed)](https://www.ncbi.nlm.nih.gov/pubmed/30195415)

* Andrew T. Grainger, Nicholas J. Tustison, Kun Qing, Rene Roy, Stuart S. Berr, and Weibin Shi.  Deep learning-based quantification of abdominal fat on magnetic resonance images. _PLoS One_, 13(9):e0204071, Sep 2018.  [(pubmed)](https://www.ncbi.nlm.nih.gov/pubmed/30235253)

* Cullen N.C., Avants B.B. (2018) Convolutional Neural Networks for Rapid and Simultaneous Brain Extraction and Tissue Segmentation. In: Spalletta G., Piras F., Gili T. (eds) Brain Morphometry. Neuromethods, vol 136. Humana Press, New York, NY [doi](https://doi.org/10.1007/978-1-4939-7647-8_2)

## Acknowledgments

* We gratefully acknowledge the support of the NVIDIA Corporation with the donation of two Titan Xp GPUs used for this research.

* We gratefully acknowledge the grant support of the [Office of Naval Research](https://www.onr.navy.mil) and [Cohen Veterans Bioscience](https://www.cohenveteransbioscience.org).
