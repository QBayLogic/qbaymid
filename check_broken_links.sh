#!/bin/bash

# do:
# cd build/
# python3 -m http.server
# pip3 install pylinkvalidate

pylinkvalidate.py http://0.0.0.0:8000/ --test-outside -w 8 -i http://www.linkedin.com,https://www.linkedin.com
