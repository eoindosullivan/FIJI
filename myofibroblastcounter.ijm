//crop to a high quality area of staining if required due to artefact, although whole image best
title = getTitle()
run("Split Channels");
selectWindow("C2-" + title); //col1 - not needed
close();
selectWindow("C4-" + title); //this is pdgfrb - mask1
setThreshold(1510, 65535);
setOption("BlackBackground", false);
run("Convert to Mask");
run("Create Mask");
run("Create Selection");
run("ROI Manager...");
roiManager("Add");
selectWindow("C4-" + title);
close()
selectWindow("C3-" + title); // a-sma - mask 2
setThreshold(500, 65535);
setOption("BlackBackground", false);
run("Convert to Mask");
run("Create Mask");
run("Create Selection");
run("ROI Manager...");
roiManager("Add");
selectWindow("mask");
roiManager("Select", newArray(0,1));
roiManager("AND"); // this is the key step! 
selectWindow("C1-"+title); //dapi - mask 3
run("Restore Selection");
setBackgroundColor(0, 0, 0);
run("Clear Outside");
run("Gaussian Blur...", "sigma=1");
setThreshold(771, 65535);
run("Convert to Mask");
run("Watershed");
run("Measure");
run("Analyze Particles...", "size=0-500 pixel show=Outlines include summarize in_situ");
run("Select All");
run("Measure");
//use the second measure here to measure to toal area of the image so you can normalise nuclear count
selectWindow("C1-" + title);
close();
selectWindow("C3-" + title);
close();
selectWindow("mask");
close();
selectWindow("mask");
close();
roiManager("Deselect");
roiManager("Delete");
// results in the "summary" readout under "count" , normalise to second measures area