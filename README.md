# hemibrain_olf_data
Data on FIB hemibrain olfactory neurons that will be useful for analysis in upcoming FIB hemibrain papers. The hemibrain dataset is described in [Scheffer et al, 2020](https://doi.org/10.7554/eLife.57443).

It includes primary data such as classification of hemibrain olfactory and thermo/hygrosensory (VP) uniglomerular projection neurons (uPNs) and multiglomerular ones, and comparison of certain features with FAFB. It also includes the list of receptor neurons (RNs). 

Hemibrain neurons are defined by a bodyid, accompanied by a name (instance name) and type.

## PN related files
In addition to bodyid name and type, columns can include:

* PN_type: uPN or mPN.
* tract
* glomerulus for uni- or biglomerular PNs
* lineage
* fafb_type: for thermo/hygrosensory (VP) projection neurons, based on typing of FAFB matches in [Marin et al, 2020](https://doi.org/10.1016/j.cub.2020.06.028)
* hemisphere: FIB
* valence: for VP PNs

The file `FIB_uPNs.csv` lists all uniglomerular olfactory uPNs, on the right hemisphere. 

The file `FIB_LHS_uPNs.csv` lists the identifiable uniglomerular olfactory uPNs, on the left hemisphere. The axon is truncated as it extends dorsally, and in some instances, the dendrites are also partially truncated.

The file `FIB_VP_PNs.csv` lists all thermo- and hygrosensory PNs (uni-, bi- and multiglomerular ones) as identified by Lisa Marin (for more info see [Marin et al, 2020](https://doi.org/10.1016/j.cub.2020.06.028). Some multiglomerular ones might also receive some olfactory input, but the expectation is that most input will be thermo-sensory. 

The file `FIB_mPNs.csv` lists all remaining multiglomerular PNs. They might receive only olfactory or mixed input.

The file `odour_scenes.csv` includes for each glomerulus, the known ligand for those sensory neurons, which odour scene it relates to and the valence. Please not that some valences are not known, or clear in different contexts. This file is the same as figure S7 of [Bates&Schlegel et al, 2020](https://doi.org/10.1016/j.cub.2020.06.042).

The file `uPNsdf_FIB_FAFB.csv` includes for each classical (i.e. canonical) uPNs a comparison of the number of individuals per type, between the right hemipshere of FAFB and FIB.
* FAFB.RHS: number in FAFB.RHS
* FIB: number in hemibrain
* RHS.FIB: difference between FAFB.RHS and FIB
* lineage: this column distinguishes between embryonic and larval PNs of the anterodorsal lineage (e adPN or l adPN)
* birth order: the assignement of DP1l, VC5 and DC4 to e adPN is based on our data. So the placement in the birth order is putative, according to gaps in order as already described in the literature.

The file `other_PNs.csv` lists non classical olfactory or thermo-hygro PNs, those that include SEZ innervation and almost bypass the AL or those that input onto the AL.

## RN files
The file `FIB_RNs.csv` lists all RNs. It includes name and type (as in neuPrint), glomerulus, laterality for the type (unilateral (U) or bilateral (B)), soma side (ipsilateral or contralateral) and modality (according to the glomerulus). The field 'notes' indicates 9 outlier or problematic RNs.
The file `AL_gloms_RN_info.csv` lists for each glomerulus the receptor (as known as this time), the number of expected RNs for each type and its citation, the qualitative assessement of glomeruli truncation in the hemibrain dataset as well as RN fragmentation status.
