Background
==========
Resting state fMRI data from 1489 subjects were registered using surface-based alignment. A gradient weighted markov random field approach was employed to identify cortical areas.

Information about Downloads
===========================
For each parcel resolution there are two dlabel.nii files corresponding to assignments to Yeo et al 7 and 17 network parcellation. The parcellations were computed in "fsaverage6" space and sampled to the fsLR32k space.  Each parcel was matched to a corresponding network in the 7 and 17 network parcellation by Yeo et al. 

Example Usage
=============

### Workbench Viewer
1) Make sure connectome workbench viewer has been set up and configured (https://wiki.humanconnectome.org/display/WBPublic/Connectome+Workbench+Help+Guide).
2) In terminal,  
   a) wb_view  
   b) open an underlying fslr32k spec file on which the parcellation will be overlaid  
   c) select file-> open file  
   d) click to the folder containing this Readme and from there click to subfolders `fslr32k` and `cifti` containing the `dlabel.nii` files  
   e) select 'Connectivity Dense Label Files (*dlabel.nii)' on the bottom of the window  
   f) select the Schaefer_2018 parcellation file you want to use  
   g) in the overlay toolbox select the corresponding Schaefer_2018 parcellation file

### Matlab
1) Make sure Matlab has been installed together with the FieldTrip Cifti Reader (https://github.com/Washington-University/cifti-matlab)  
2) ```x=ft_read_cifti('Schaefer2018_400Parcels_17Networks_order.dlabel.nii','mapname','array');```

References
==========
+ Schaefer A, Kong R, Gordon EM, Zuo XN, Holmes AJ, Eickhoff SB, Yeo BT, (accepted), Local-Global Parcellation of the Human Cerebral Cortex From Intrinsic Functional Connectivity MRI, Cerebral Cortex
+ Yeo BT, Krienen FM, Sepulcre J, Sabuncu MR, Lashkari D, Hollinshead M, Roffman JL, Smoller JW, Zollei L., Polimeni JR, Fischl B, Liu H, Buckner RL (2011) The organization of the human cerebral cortex estimated by functional connectivity. J. Neurophysiol.
