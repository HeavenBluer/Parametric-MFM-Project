# -*- coding: utf-8 -*-
"""
This script apply diffusion embedding on gradient distance matrix.

Input:
    - lh_input_matrix, rh_input_matrix:
        the input gradient distance matrices generated by
        CBIG_SPGrad_generate_gradient_matrix.m

    - output_dir:
        the output directory to save the results.

    - num_comp:
        the number of components of the diffusion embedding matrix.
"""
"""
Written by Ru(by) Kong and CBIG under MIT license:
https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md
"""

import sys


def apply_diffusion_on_individul_distance_matrix(
        lh_input_matrix, rh_input_matrix, output_dir, num_comp):

    import numpy as np
    import datetime
    import scipy.io as sio
    import os

    # import Santra's embedding code
    import sys
    sys.path.append(os.environ['CBIG_CODE_DIR'] +
                    '/external_packages/python/mapalign-master/')

    from mapalign import embed

    for i in range(2):
        if i == 0:
            # load distance matrix
            distance_mat = np.load(lh_input_matrix)
            hemi = 'lh'
        else:
            # load distance matrix
            distance_mat = np.load(rh_input_matrix)
            hemi = 'rh'

        # perform embedding
        startime = datetime.datetime.now()
        emb, res = embed.compute_diffusion_map(
            distance_mat,
            alpha=0.5,
            n_components=int(num_comp),
            return_result=True,
            skip_checks=True,
            overwrite=True)

        # print out time
        endtime = datetime.datetime.now()
        lapsetime = endtime - startime
        print(lapsetime)

        # save out a matlab version
        sio.savemat(
            output_dir + '/' + hemi + '_emb_' + num_comp +
            '_distance_matrix.mat', dict(emb=emb))


apply_diffusion_on_individul_distance_matrix(sys.argv[1], sys.argv[2],
                                             sys.argv[3], sys.argv[4])
