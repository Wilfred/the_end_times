#!/bin/env python2

import os
import sys
from time import time

if __name__ == '__main__':
    CURRENT_PATH = os.path.dirname(os.path.realpath(__file__))
    PROGRAMS_PATH = os.path.join(CURRENT_PATH, 'programs')

    if len(sys.argv) > 1:
        language_filter = sys.argv[1]
    else:
        language_filter = ""

    for test_program_dir in sorted(os.listdir(PROGRAMS_PATH)):
        language, implementation = test_program_dir.split('_')

        if language_filter not in language.lower():
            print "Skipping %s (%s)" % (language, implementation)
            continue

        test_program_path = os.path.join(PROGRAMS_PATH, test_program_dir)
        os.chdir(test_program_path)

        build_script_path = os.path.join(test_program_path, 'build')
        run_script_path = os.path.join(test_program_path, 'run')

        # Build "bin" if it doesn't already exist.
        if os.path.exists(build_script_path):
            if not os.path.exists(os.path.join(test_program_path, 'bin')):
                os.system(build_script_path)
            
        if os.path.exists(run_script_path):
            before = time()
            
            return_code = os.system("%s > output.txt" % run_script_path)
            after = time()
            elapsed = after - before

            if return_code == 0:
                print "%s (%s) took %.3f seconds" % (language, implementation, elapsed)
            else:
                print "%s (%s) failed" % (language, implementation)
