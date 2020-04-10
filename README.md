# CoVid-Models

Models for 3D printing for project Robots4Motol and various lab-ware tinkering.
- Only [OpenSCAD](https://www.openscad.org/) source files are being tracked.
- Openscad is available for all main operating system (Windows, various Linux/Unix and MacOS) for FREE
- Enables easy parameters modification.
- **If you are not able to install OpenSCAD for any reason, just write me an email (jiri.kub@gmail.com).**
- Several models are also published on [Thingiverse](https://www.thingiverse.com/) on my [Thingiverse profile](https://www.thingiverse.com/Kvant/about).

## Used Libraries
- two OpenScad library required and provided - `round_corners.scad` and `round_text.scad`.


## Repository Structure and Model Versions
- Two main series developed: _96well serie_ and its ancestor serie _kvant96 serie_.
- A 96well serie is abandoned due to design flaws, printing time and different filter tips currently used.
- kvant96 serie is currently deployed and maintained
- all printing time is estimated based on experimental 0.35mm profile in PrusaSlicer for 0.4mm nozzle PrusaMK3S printer (see PrusaSlicer profiles folder).


### 96well Serie
- abandoned
- the lower part is [Eppendorf  96 well](https://www.eppendorf.com/product-media/doc/en/105601_Marketing-Manual/Eppendorf_Consumables_Technical-data_Deepwell-Plate-96-2000_Eppendorf-Deepwell-Plate-96-2000-uL.pdf)
- the upper part is designed for _Biosphere FilterTips 200 ul extralong_
- **96well adapter**
    - abandoned branch, the origin of all other 96well adapters
    - the last iteration sits tightly on the lower part thanks to the square shafts
- **96well adapter - lightweight**
    - simple fast to print (about two and half hour)
    - high contamination chance
- **96well adapter - reinforced**
    - durable design (about five and half hour to print)
    - each filter tip has its separate shaft, e.g. low chance of contamination
- **96well adapter - heavy**
    - a direct descendant of the original design with cylindric shafts
    - durable and robust design (no slicing done, 96well series abandoned)


### Kvant96 Serie
   - currently deployed
   - used in OpenTrons design with 
   - lower part remains same; [eppensdorf 96 well](https://www.eppendorf.com/product-media/doc/en/105601_Marketing-Manual/Eppendorf_Consumables_Technical-data_Deepwell-Plate-96-2000_Eppendorf-Deepwell-Plate-96-2000-uL.pdf)
   - upper part is dimensioned for shorter _Bioshpere FilterTips 2-200 ul_ for either holding whole rack (adapter) or holding separate filter tips (filter tip rack)
   - **kvant96 filter tips rack**
     - filter tips rack for previously mentioned Biosphere FilterTips
     - a direct descendant of 96well adapter - reinforced
     - low chance of cross-contamination as each filter tip has its cylindric shaft
     - abandoned version as the design is unnecessarily thick and complex
   - **kvant96 filter tips rack - lightweight**
     - improved (finalized) version of _kvant96 filter tips rack_
     - low chance of cross-contamination as the plane sits tight to the lower part
     - compact design and fast to print design (about 1 hour and 20 minutes)
   - **kvant96 adapter**
      - connecting part used for holding Eppendorf 96 well and the top part of Biosphere FilterTips (yellow part)
      - very compact and fast to print design (about 40 minutes)


### Biomek Serie
 - Reversed engineered labware serie compatible with Biomek
 - **Biomek Baths-holder**
   - basic bath holder for four Biomek (automated laboratory workstation) 100 ml baths
   - printing time about two hours
 - **Biomek Baths-holder -- lightweight**
   - improved bath holder for four Biomek (automated laboratory workstation) 100 ml baths
   - printing time about one hour and a half


### OpenTrons hardware
 - **Pipette Head Plate**
   - An additional plate used for OpenTrons pipette head
   - Significantly improves the releasing of filter tips
   - Rubberbands (diameter between 6 and 10 cm) are used for locking it in place
   - Only a temporary solution

   - **Pipette Head Plate**
     - Basic first temporal solution
     - Obsolete design, too stiff
   
   - **Pipette Head Plate lightweight**
     - Lightweight iterative solution
     - Obsolete
  
   - **Opentrons Pipette Head Plate**
     - Final solution
     - Merge of two previous version
     - Production design
  
- **Rack Holder**
   - Custom made filter tips rack holder
   - Lower interface: standard 96well plate dimensions (128x86 mm) with the _OpenTrons_ borders.
   - Upper interface: _Biosphere Filter Tips 200ul extra long_


### Various Custom Hardware
 - **Test Tube Opener**
   - Custom test tube opener developed for Hospital Na Bulovce in Prague to make sample processing easier.
   - [FL Medical Sterile test tube](https://www.flmedical.com/test-tubes/test-tubes-with-cap/) used for development, but any other type of test tubes can be used.

 - **Filter tips Sorting Rack**
   - The rack used for easier sorting and storing filter tips
   - Based on [Pipet tip sorting device 'Elster' for 10 µL pipet tips](https://www.thingiverse.com/thing:4256563) by [AM LN](https://www.thingiverse.com/Easylabsolutions/about), but different pipette tips used.
   - Designed for Charles University in Prague.
 

## License
- All provided code is licensed under [Attribution-NonCommercial-ShareAlike 4.0 International (human readable)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
- Full license can be found [here](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode)
