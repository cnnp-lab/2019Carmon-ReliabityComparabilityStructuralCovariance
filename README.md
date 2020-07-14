# Reliability and comparability of human brain structural covariance networks.

Supporting Matlab code for the preprint “Reliability and comparability of human brain structural covariance networks” uploaded to arXiv ([https://arxiv.org/abs/1911.12755](https://arxiv.org/abs/1911.12755)).



## Reproducing the analysis

The intention of this code library is to make our analysis transparent and reproducible. However, the provided code is not intend to be used as a software package for other datasets.

In `main_figures.m` you will find all function calls to reproduce the figures of the main results. All function calls for the figures of the supplementary material are listed in `supplementary_figures.m` in the folder *supplementary*.


## Dependencies and acknowledgement

### Code

For completeness, code of the Brain Connectivity Tool ([https://sites.google.com/site/bctnet/](https://sites.google.com/site/bctnet/)) and of FreeSurfer ([https://github.com/freesurfer/freesurfer/tree/dev/matlab](https://github.com/freesurfer/freesurfer/tree/dev/matlab)) is included. Copyright stays with the original publications.

The code of the function error_ellipse.m was inspired by the Matlab source code of this tutorial [https://www.visiondummy.com/2014/04/draw-error-ellipse-representing-covariance-matrix/](https://www.visiondummy.com/2014/04/draw-error-ellipse-representing-covariance-matrix/).

### Data sets

For the reproduction of our analysis all necessary data is included as MAT files. However, for reasons of good data governance this does not include the original NIFTI files and meta data variables (e.g. age or gender). For access to the original data sets and meta data see [http://www.mrc-cbu.cam.ac.uk/datasets/camcan/](http://www.mrc-cbu.cam.ac.uk/datasets/camcan/) and [https://www.humanconnectome.org/study/hcp-young-adult/document/1200-subjects-data-release](https://www.humanconnectome.org/study/hcp-young-adult/document/1200-subjects-data-release).

To reproduce the brain surface plots of panel b-d of figure 3 please include a lh.aparc.annot and lh.pial file.


## Contributors

* **Jona Carmon**

* **Yujiang Wang**


## License

The provided code can be freely used under the Creative Common License (CC).