# hemibrain_olf_data
Data on FIB hemibrain olfactory neurons that will be useful for analysis in upcoming FIB hemibrain papers.

It includes primary data such as classification of hemibrain olfactory and thermo/hygrosensory (VP) uniglomerular projection neurons (uPNs) and multiglomerular ones, and comparison of certain features with FAFB.

* bodyid
* name: instance name
* type
* PN_type: uPN or mPN.
* tract
* glomerulus for uni- or biglomerular PNs
* lineage
* fafb_type: for thermo/hygrosensory (VP) projection neurons, based on typing of FAFB matches in [Marin 2020](https://www.biorxiv.org/content/10.1101/2020.01.20.912709v2))
* hemisphere: FIB
* valence: for VP PNs

The file `FIB_uPNs.csv` lists all uniglomerular olfactory uPNs, on the right hemisphere. 

The file `FIB_LHS_uPNs.csv` lists the identifiable uniglomerular olfactory uPNs, on the left hemisphere. The axon is truncated as it extends dorsally, and in some instances, the dendrites are also partially truncated.

The file `FIB_VP_PNs.csv` lists all thermo- and hygrosensory PNs (uni-, bi- and multiglomerular ones) as identified by Lisa Marin (for more info see [Marin 2020](https://www.biorxiv.org/content/10.1101/2020.01.20.912709v2)). Some multiglomerular ones might also receive some olfactory input, but the expectation is that most input will be thermo-sensory. 

The file `FIB_mPNs.csv` lists all remaining multiglomerular PNs. They might receive only olfactory or mixed input.

The file `odour_scenes.csv` includes for each glomerulus, the known ligand for those sensory neurons, which odour scene it relates to and the valence. Please not that some valences are not known, or clear in different contexts. This file is the same as figure S7 of [Bates &Schlegel, 2020](https://doi.org/10.1101/2020.01.19.911453).

The file `uPNsdf_FIB_FAFB.csv` includes for each classical (i.e. canonical) uPNs a comparison of the number of individuals per type, between the right hemipshere of FAFB and FIB.
* FAFB.RHS: number in FAFB.RHS
* FIB: number in hemibrain
* RHS.FIB: difference between FAFB.RHS and FIB
* lineage: this column distinguishes between embryonic and larval PNs of the anterodorsal lineage (e adPN or l adPN)
* birth order: the assignement of DP1l, VC5 and DC4 to e adPN is based on our data. So the placement in the birth order is putative, according to gaps in order as already described in the literature.

The file `other_PNs.csv` lists non classical olfactory or thermo-hygro PNs, those that include SEZ innervation and almost bypass the AL or those that input onto the AL.
