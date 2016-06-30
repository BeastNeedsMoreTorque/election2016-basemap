###Election Basemap with D3.js and TopoJson

Hey there. So you want to make an election map using TopoJSON and D3! Well good news, friend. I'm here to outline a relatively simple approach I've worked out after making maps through a couple of national election cycles and a long primary season.

First, the basics. National election results in the U.S. are reported generally at three levels: by state, by County, and by congressional district. During the primaries and general election, the Associated Press provides live results by subscription. Results are keyed by FIPS codes at the state, county, and district level. This Gist will outline the process for building a bare-bones front-facing election map without getting into the AP's feed and how one loads it. (But if you're interested, I'd suggest checking out the excellent [Elex project](https://source.opennews.org/en-US/articles/introducing-elex-tool-make-election-coverage-bette/).) This tutorial is broken out in two parts:

1. Create a topojson file with states, counties, and congressional districts using Census Bureau shapefiles and the Topojson command line tool.
2. Build a responsive, zoomable, USA Albers-projected map using JavaScript and the D3.js library.

####Creating the TopoJSON

The U.S. Census Bureau [provides shapefiles](https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html) for states, counties, and congressional districts, as well as populated areas, zip codes and, of course, census tracts. It’s a gold mine! To build our election map topojson file, we’ll start by downloading the highest resolutions files for states, counties and districts. (The shapefiles are listed with 500K, 5M and 20M. Counterintuitively, the 500K file is actually the largest.)

To combine the three shapefiles into one topojson file, we’ll use the topojson command-line tool. Topojson is a format. TopoJSON is a tool created by Mike Bostock for converting shapefiles and GeoJSON into much smaller files. TopoJSON is similar to GeoJSON but eliminates redundancy by combining line segments and shared borders.

Start by putting all three of our shapefiles in one directory.

Using the command line, we’ll create a new TopoJSON file that contains topology for states, counties, and districts as separate objects.

```shell
topojson > us2016.topo.json \
	-q 5e3 \
	-s 1e-8 \
		states=cb_2015_us_state_500k/cb_2015_us_state_500k.shp \
			--id-property GEOID \
		districts=cb_2015_us_cd114_500k/cb_2015_us_cd114_500k.shp \
			--id-property GEOID \
		counties=cb_2015_us_county_500k/cb_2015_us_county_500k.shp \
			--id-property GEOID
```

Notes: -q and -s stand for “quantization” and “simplification” respectfully. Each has some bearing on the file size and level of detail in the output file. Each are documented in the command line reference, but the best explanation I’ve read is here in this article: http://zevross.com/blog/2014/04/22/spatial-data-on-a-diet-tips-for-file-size-reduction-using-topojson/.

The output file is a TopoJSON file roughly 1.5MB in size. Each of the features nested in the states, counties and districts objects is keyed by it’s GEOID property, which in the original shapefiles is the FIPS.

Topojson Command Line reference:
https://github.com/mbostock/topojson/wiki/Command-Line-Reference
Topojson install instructions:
https://github.com/mbostock/topojson/wiki/Installation
