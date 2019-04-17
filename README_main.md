# Project: OCR (Optical Character Recognition) 

![image](figs/intro.png)

### [Full Project Description](doc/project4_desc.md)

Term: Spring 2019

+ Team #
+ Team members
	+ Liu, Siwei sl4224@columbia.edu
	+ Vitha, Matthew mv2705@columbia.edu
	+ Wang, Yujie yw3285@columbia.edu
	+ Xia, Mengran mx2205@columbia.edu
	+ Yao, Yu yy2906@columbia.edu

+ Project summary: In this project, we created an OCR post-processing procedure to enhance Tesseract OCR output. Our project focuses on the post-processing. The whole project contains three parts: (1) Error detection (2) Error correction (3) Evaluation and performance measure. 

+ Papers: Our assigned papers are (1) [D1 On Retrieving Legal Files](https://github.com/TZstatsADS/Spring2019-Proj4-grp11/blob/master/doc/paper/D-1.pdf). and (1) [C3 Probability Scoring for Spelling Correction](https://github.com/TZstatsADS/Spring2019-Proj4-grp11/blob/master/doc/paper/C-3.pdf) 

**(1) Error Detection**
Since we figured there are 13 text files whose total number of lines do not match between their corresponding ground_truth and tesseract files, we manually trimmed the lines of those files and saved all those files in the folder called "ground_truth_trimmed. (We did line checks). Then we implemented the rest five methods of error detection. Detail of the total eight methods for error detection can be seen from the following figure.
![image](https://github.com/TZstatsADS/Fall2018-Project4-sec1--section1-project4_group1/blob/master/figs/screen-2.PNG)
	
**Contribution statement**: ([default](doc/a_note_on_contributions.md)) 

 All team members approve our work presented in this GitHub repository including this contributions statement. 

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
