#!/bin/env python2

import os
from time import time

if __name__ == '__main__':
    CURRENT_PATH = os.path.dirname(os.path.realpath(__file__))
    PROGRAMS_PATH = os.path.join(CURRENT_PATH, 'programs')

    for test_program_dir in sorted(os.listdir(PROGRAMS_PATH)):
        language, implementation = test_program_dir.split('_')

        test_program_path = os.path.join(PROGRAMS_PATH, test_program_dir)
        os.chdir(test_program_path)
        
        run_script_path = os.path.join(test_program_path, 'run')

        if os.path.exists(run_script_path):
            before = time()
            
            return_code = os.system(run_script_path)
            after = time()
            elapsed = after - before

            if return_code == 0:
                print "%s (%s) took %.3f seconds" % (language, implementation, elapsed)
            else:
                print "%s (%s) failed" % (language, implementation)
