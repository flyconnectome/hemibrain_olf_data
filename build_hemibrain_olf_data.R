# Code used to generate the lists and dataframes in https://github.com/flyconnectome/hemibrain_olf_data
# By reading in TeamDrive spreadsheet 'AL_fragments_PN_search' for FIB typing.

library(elmr)
library(tidyr)
library(dplyr)
library(stringr)
library(tidyverse)
library(googlesheets4)
library(tracerutils)

fib_pns=read_team_sheet(id = '1P-ITJs9JdexIahOaU5teKaQ7fi0t5G0QOtTrAfRGwGM', team_drive = 'flyconnectome', ws = "PNs")

# read in sheet that colect info from FAFB and matches form mPN FIB > FAFB
fafb_info = read.csv("/Users/mmc46/projects/EM_Adult/FIB_PN_validation/FIB_mPN_nb_to_FAFB_with_info.csv", stringsAsFactors = F)

# For olfactory PNs, excluding VPs: working with uPNs and mPNs
# for mlALT, create new variable 'glom' and append 'v'. Drop 'Glom'
# remove contralateral VL1 and V:  !(bodyId%in% c(698508565, 1912789965)) - not doing this now. Only for totting up numbers.
# remove 'lv' and 'v' from glomerulus
fib_pns %>%
  filter(str_detect(Type,"^uPN$|^uPN - outlier"), !(str_detect(Glom, "VP"))) %>%
  select(bodyId, Name, Glom, Tract, Lineage) %>%
  mutate(glomerulus = str_replace(Glom, pattern = "^v|^lv", replacement = ""),
         lineage = case_when(
           Lineage == 'ALad1' ~ 'adPN',
           str_detect(Lineage, '^ALl1_') ~ 'lPN',
           Lineage == 'ALlv1' ~ 'lvPN',
           Lineage == 'ALv1' ~ 'vPN',
         TRUE ~ Lineage),
         new_type_name = paste0(glomerulus, " ", lineage),
         type = 'fib', hemisphere = 'FIB') %>%
  rename(tract = Tract, name = Name, skid = bodyId) %>%
  select(-Glom, -Lineage) -> fib_upns

nrow(fib_upns)
# [1] 122

# For olfactory mPNs or uPNs/mPNs
# replace NAs with TRUE first, so negation of str_detect works
fib_pns %>%
  filter(str_detect(Type, "mPN") & !(grepl(x = Glom, pattern = "VP"))) %>%
  select(bodyId, Name, Glom, Tract, Lineage) %>%
  mutate(lineage = case_when(
    Lineage == 'ALad1' ~ 'adPN',
    (str_detect(Lineage, '^ALl1')) | Lineage == 'lPN' ~ 'lPN',
    str_detect(Lineage, '^ALlv1',) ~ 'lvPN',
    str_detect(Lineage, '^ALv1',) ~ 'vPN',
    TRUE ~ Lineage)) %>% 
  left_join(select(fafb_info, bodyId, class, is_olfactory, top_glomerulus, good_match)) %>%
  rename(tract = Tract, name = Name, glomerulus = Glom) %>%
  select(-Lineage) -> fib_mpns

# There are a few new uPNs
# use the FAFB info to get the top glomerulus
# for those with good match == n, put glom with ?
fib_mpns %>%
  filter(class == 'uPN') %>%
  mutate(top_glomerulus = case_when(
    str_detect(good_match, "^n") ~ paste0(top_glomerulus, "?"),
    TRUE ~ top_glomerulus
  ), new_type_name = paste0(top_glomerulus, " ", lineage),
  type = 'fib', hemisphere = 'FIB') %>%
  select(-is_olfactory, -good_match, -glomerulus, -class) %>%
  rename(skid = bodyId, glomerulus = top_glomerulus) -> new_fib_upns

all_fib_upns = bind_rows(fib_upns, new_fib_upns)

nrow(all_fib_upns)
# [1] 134

write.csv(all_fib_upns, "/repositories/hemibrain_olf_data/FIB_uPNs.csv") 

# remaining mPNs
fib_mpns %>%
  filter(class == 'mPN') %>%
  select(-good_match, -glomerulus, -class, -top_glomerulus) %>%
  mutate(new_type_name = case_when(
    is_olfactory == TRUE ~ paste0("olfactory multi", " ", lineage, " ", tract) ,
    is_olfactory == FALSE ~ paste0("multi", " " , lineage, " ", tract)),
  type = 'fib', hemisphere = 'FIB') %>%
rename(skid = bodyId) %>%
  select(-is_olfactory) -> fib_mpns_clean

nrow(fib_mpns_clean)
# [1] 156

write.csv(fib_mpns_clean, "/repositories/hemibrain_olf_data/FIB_mPNs.csv")

# For VP PNs
# list of all neurons
fib_pns %>%
  mutate_at(vars(Type, Glom), ~replace_na(., TRUE)) %>%
  filter(str_detect(Glom, "VP")) %>%
  select(bodyId, Name, Glom, Type, Tract, Lineage) %>% 
  mutate(Glom = replace(Glom, Glom == 'TRUE', "NA"),
         Lineage = case_when(
           Lineage == 'e adPN' ~ 'adPN',
           TRUE ~ Lineage),
         new_type_name = case_when(
           Type %in% c("uPN", "biPN") ~ paste0(Glom, " ", Lineage), 
           Type == 'mPN' ~ paste0("VP multi", " ", Lineage, " ", Tract)),
         valence = case_when(
           (Type == 'uPN' & str_detect(Glom, "VP(4|5)")) ~ "hygrosensory",
           (Type == 'uPN' & str_detect(Glom, "VP(2|3)")) ~ "thermosensory"),
         type = 'fib', hemisphere = 'FIB') %>%
  rename(tract = Tract, name = Name, skid = bodyId, lineage = Lineage, glomerulus = Glom, PN_type = Type) -> fib_vp_pns

nrow(fib_vp_pns)
# [1] 41

write.csv(fib_vp_pns,"/repositories/hemibrain_olf_data/FIB_VP_PNs.csv")

# FAFB RHS
rhssk = catmaid_skids("^WTPN2017_uPN_right$")
rhs_name = catmaid_get_neuronnames(rhssk)
malt = catmaid_skids("^WTPN2017_mALT_right$")
mlalt = catmaid_skids("^WTPN2017_mlALT_right$")
lalt = catmaid_skids("^WTPN2017_lALT_right$")
t5alt = catmaid_skids("^WTPN2017_t5ALT_right$")

# make tibble with name and skid
rhs_upns = tibble(rhssk, rhs_name)

# build df, ordering columns as FIB one
# remove LHS V bilateral and VL1 (bilateral neurons have both left and right annotations, that refers to tract)
rhs_upns %>%
  rename(skid = rhssk, name = rhs_name) %>%
  mutate(
    tract = case_when(
      skid %in% malt ~ 'mALT',
      skid %in% mlalt ~ 'mlALT',
      skid %in% lalt ~ 'lALT',
      skid %in% t5alt ~ 't5ALT'
    ),
    glomerulus = str_match(name, pattern = "glomerulus (\\S+)")[, 2],
    type = 'manu',
    hemisphere = 'FAFB.RHS'
  ) %>%
  filter(!(str_detect(glomerulus, "VP")),!(skid %in% c(27884, 73937))) -> rhs_upns

# nrow(rhs_upns)
# [1] 125

# join FIB and FAFB
all_upns = rbind(rhs_upns, fib_upns)

all_upns %>%
  count(glomerulus, hemisphere) %>%
  spread(key = hemisphere, value = n) -> all_upns_summ

# Read in uPN Catalogue to add both birth order and valence info
upncat = gs_url("https://docs.google.com/spreadsheets/d/1byWuARv_lKoNmkfI9wZYS3qCoQMMGUTFwSayPcVRj8g/edit?usp=sharing", lookup = FALSE, visibility = 'private')

birth_order = gs_read(upncat, ws='Birth_order')
valence = gs_read(upncat, ws='Valences')

# get glomerulus for lPNs, lv PNs
ulpns_gloms = unique(str_match(catmaid_get_neuronnames(intersect(catmaid_skids('WTPN2017_lineage_lPN'), rhssk)), 
                               pattern = "glomerulus (\\S+)")[,2])
ulvpns_gloms = unique(str_match(catmaid_get_neuronnames(intersect(catmaid_skids('WTPN2017_lineage_lvPN'), rhssk)), 
                                pattern = "glomerulus (\\S+)")[,2])
vppn_gloms = unique(str_match(catmaid_get_neuronnames(intersect(catmaid_skids('vpPN'), rhssk)), 
                              pattern = "glomerulus (\\S+)")[,2])
vmpn_gloms = unique(str_match(catmaid_get_neuronnames(intersect(catmaid_skids('WTPN2017_lineage_vmPN'), rhssk)), 
                              pattern = "glomerulus (\\S+)")[,2])
# add lineages to df
all_upns_summ %>%
  left_join(birth_order[c('glom.FAFB', "lineage", "birth.order")], by = c("glomerulus" = "glom.FAFB")) %>%
  mutate(lineage = case_when(
    (is.na(lineage) & glomerulus%in%ulvpns_gloms) ~ 'lvPN',
    (is.na(lineage) & str_detect(glomerulus, pattern = "^v")) ~ 'vPN',
    (is.na(lineage) & glomerulus%in%ulpns_gloms) ~ 'lPN',
    (is.na(lineage) & glomerulus%in%vppn_gloms) ~ 'vpPN',
    (is.na(lineage) & glomerulus%in%vmpn_gloms) ~ 'vmPN',
    lineage == 'e adpn' ~ 'e adPN',
    lineage == 'l adpn' ~ 'l adPN',
    TRUE ~ lineage),
    new.glom = str_replace(glomerulus, pattern = "^lv|v", replacement = "")) %>% 
  left_join(valence[c('Glomerulus', 'Significance')], by = c('new.glom' = 'Glomerulus')) %>% 
  select(-new.glom) %>%
  group_by(lineage) %>%
  arrange(birth.order, lineage) %>%
  mutate(RHS.FIB = FAFB.RHS - FIB) %>%
  select(glomerulus, FAFB.RHS, FIB, RHS.FIB, lineage, birth.order, Significance) -> all_upns_df

# Adjust lineage order for VM3, as it the only case of emb adPN with 2 neurons: 18 and 20. Keep only one row.
all_upns_df = all_upns_df[-(which(all_upns_df$glomerulus == 'VM3')[1]),]
all_upns_df[all_upns_df[,'glomerulus']=='VM3','birth.order'] = '18 and 20'

# write csv of all_upns_df
write.csv(all_upns_df, "/repositories/hemibrain_olf_data/uPNsdf_FIB_FAFB.csv")








