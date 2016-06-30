

# topojson > us2016.topo.json \
# 	-q 5e3 \
# 	-s 1e-8 \
# 		states=cb_2015_us_state_500k/cb_2015_us_state_500k.shp \
# 			--id-property GEOID \
# 		districts=cb_2015_us_cd114_500k/cb_2015_us_cd114_500k.shp \
# 			--id-property GEOID \
# 		counties=cb_2015_us_county_500k/cb_2015_us_county_500k.shp \
# 			--id-property GEOID


topojson > us2016.topo.json \
		states=cb_2015_us_state_500k/cb_2015_us_state_500k.shp \
		districts=cb_2015_us_cd114_500k/cb_2015_us_cd114_500k.shp \
		counties=cb_2015_us_county_500k/cb_2015_us_county_500k.shp