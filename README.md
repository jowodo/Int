Data, code, results and thesis of master internship
===================================================

This project is organised according to [Noble 2009](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424)

- `data`: contains unchanging original data (IV-, UVVis-, XRD-measurments). Do not put anything else there, better yet, make the folder read-only.
- `results`: contains end results of calculations. Do not put intermediate or temporary results there. 
- `code`: contains project specific programs or scripts
- `doc`: contains documentation, instructions and manuscripts.

Dependencies
------------
- python3: argparse, dfply, numpy, pandas, pyDOE, scikit-learn, scipy 
- R: earth, emma (manual installation necessary), dplyr
