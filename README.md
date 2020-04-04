# CoVid-Models

Models for 3D printing for project Robots4Motol and various lab-ware tinkering.
- All stls, 3mfs and gcodes are ignored

# Used Libraries
- single OpenScad library required and provided - `round_corners.scad.`

# Repository Structure and Model Versions
- Two main series developed: _96well serie_ and its ancestor serie _kvant96 serie_.
- A 96well serie is abandoned due to design flaws, printing time and different filter tips currently used.
- kvant96 serie is currently deployed and maintained
- all printing time is estimated based on experimental 0.35mm profile in PrusaSlicer for 0.4mm nozzle PrusaMK3S printer (see PrusaSlicer profiles folder).

## 96well Serie
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

## Kvant96 Serie
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


     