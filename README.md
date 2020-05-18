# hemibrain_olf_data
Data on FIB hemibrain olfactory neurons that will be useful for analysis in upcoming FIB hemibrain papers.

It includes primary data such as classification of hemibrain olfactory and thermo/hygrosensory (VP) uniglomerular projection neurons (uPNs) and multiglomerular ones, and comparison of certain features with FAFB.

* bodyid
* hemibrain name (might be out of date)
* tract
* glomerulus for uni- or biglomerular PNs
* PN_type: for `FIB_VP_PNs.csv` file only.
* lineage
* new_type_name: shown in neuPrint as type, with a few exceptions: those in which the lineage is one of these 

mdPN	> A
lvPN2	>	B
ilPN	> C1/C2
ilvPN	> D
ivPN	>	E
ivmPN	> F
VUMa2	>	G

Until the neuPrint v1.1 is released, the type shown in neuPrint Explorer are the ones on the right.

* valence: for `FIB_VP_PNs.csv` file only.
* type: fib or fafb
* hemisphere: FAFB.RHS, FAFB.LHS or FIB

The file `FIB_uPNs.csv` lists all uniglomerular olfactory uPNs. 

The file `FIB_VP_PNs.csv` lists all thermo- and hygrosensory PNs (uni-, bi- and multiglomerular ones) as identified by Lisa Marin (for more info see [Marin 2020](https://www.biorxiv.org/content/10.1101/2020.01.20.912709v2)). Some multiglomerular ones might also receive some olfactory input, but the expectation is that most input will be thermo-sensory. This is reflected in the type name - starts with 'VP'.

The file `FIB_mPNs.csv` lists all remaining multiglomerular PNs. Each of these bodyids was matched to a neuron we have traced in FAFB. The `new_type_name` starts with 'olfactory' if the best match in FAFB receives a majority (>70%) of olfactory input. If this is not the case, the `new_type_name` does not include 'olfactory', reflecting the fact that it receives a mix of olfactory and thermo/hygrosensory input. In the few cases where the FAFB match was not perfect, we follow the latter rule for type naming, so without specifying type of input.

The file `odour_scenes.csv` includes for each glomerulus, the known ligand for those sensory neurons, which odour scene it relates to and the valence. For VP PNs (thermo/hygrosensory) there are more detailed valences in the `FIB_VP_PNs.csv` file.
Please not that some valences are not known, or clear in different contexts. This file is the same as figure S7 of [Bates &Schlegel, 2020](https://doi.org/10.1101/2020.01.19.911453).

The file `uPNsdf_FIB_FAFB.csv` includes for each classical (i.e. canonical) uPNs a comparison of the number of individuals per type, between the right hemipshere of FAFB and FIB.
* FAFB.RHS: number in FAFB.RHS
* FIB: number in hemibrain
* RHS.FIB: difference between FAFB.RHS and FIB
* lineage: this column distinguishes between embryonic and larval PNs of the anterodorsal lineage (e adPN or l adPN)
* birth order: the assignement of DP1l, VC5 and DC4 to e adPN is based on our data. So the placement in the birth order is putative, according to gaps in order as already described in the literature.
