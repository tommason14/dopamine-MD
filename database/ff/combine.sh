$WORK/openmm-opls/ms-tools/scripts/ffconv.py $(find . -type f | grep -v "scale\|zfp\|sh" | paste -s -d' ') -o ff.zfp
