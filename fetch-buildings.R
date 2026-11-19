library(getarc)
library(sf)
library(readr)
library(tidyverse)

#fetch registered buildings unit counts
#https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/ArcGIS/rest/services/registered_buildings_unit_counts/FeatureServer/0
registered_buildings <- query_layer("https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/ArcGIS/rest/services/registered_buildings_unit_counts/FeatureServer/0")

#write out data with today's date
write_sf(registered_buildings, paste0("data/registered_buildings_", Sys.Date(), ".geojson"))
write_csv(as.data.frame(registered_buildings), paste0("data/registered_buildings_", Sys.Date(), ".csv"))

#fetch MCI info
# https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/mci_components_geo/FeatureServer/0
mci_info <- query_layer("https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/mci_components_geo/FeatureServer/0")
mci_cases <- query_layer("https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/mci_cases/FeatureServer/0")

mci_together <- full_join(select(as.data.frame(mci_info),-address, -latitude, -longitude, -ObjectId, -geometry),
                          select(as.data.frame(mci_cases), docket_no, case_status, closing_date, close_code, room_rent_incr_amt),
                          by="docket_no")

write_csv(mci_together, paste0("data/mci_info_", Sys.Date(), ".csv"))

# List of all the layers in the map
# 0
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/sf_assembly/FeatureServer"
# 1
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/registered_buildings_unit_counts/FeatureServer"
# 2
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/df_county/FeatureServer"
# 3
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/sf_county/FeatureServer"
# 4
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/zip_codes_nys_rs/FeatureServer"
# 5
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/sf_senate/FeatureServer"
# 6
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/df_senate/FeatureServer"
# 7
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/mci_components_geo/FeatureServer"
# 8
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/df_assembly/FeatureServer"
# 9
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/reg_bldg_table/FeatureServer"
# 10
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/mci_cases/FeatureServer"
# 11
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/registered_buildings_unit_counts/FeatureServer/0"
# 12
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/df_county/FeatureServer/0"
# 13
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/reg_bldg_table/FeatureServer/0"
# 14
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/mci_components_geo/FeatureServer/0"
# 15
# : 
#   "https://services8.arcgis.com/ek7Sxtay3Z4WZWvk/arcgis/rest/services/sf_assembly/FeatureServer/0"