#!/bin/bash
grep -q "<h1>Hello, World!</h1>" index.html && echo "HTML file created successfully." || echo "HTML file creation failed."
