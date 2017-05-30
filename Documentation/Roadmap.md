
# Version 0.1 "Minimum Viable Product"

## The Goal
Handle happy path only. The app will show weather forecast in London (cid = 2643743), metric units only.

## Implementation scope
 * [the model](TechnicalDesign.md#Model) to contain the data
  * unit tested JSON deserialisation of the model
 * the API to fetch the data
  * implement the network layer
  * unit test the network layer with mocked responses
  * implement the API layer
  * unit test the API layer with mocked responses, including correct deserialisation of model
 * [the UI](UXDesign.md) to present the data

# Version 0.2 "Error Handling"
## The Goal
Handle unhappy paths

## Implementation scope
 * unhappy paths
 * handle [the model](TechnicalDesign.md#Model) deserialised from invalid JSON
  	* missing mandatory fields
 	* malformed JSON data
* handle network errors
	* no network available
	* server returned HTTP error 

# Version 0.3 "Location Selection"#

## The Goal#
Allow users to select a location from bundled list of cities provided by Open Map Weather (see: http://bulk.openweathermap.org/sample/city.list.json.gz). Allow users to select units: imperial(Fahrenheit), metric (Celsius) or Kelvin

## Implementation scope
* location selector
	* extend the UI with the feature of location selection and preserving the selected location
	* use the preserved selected location in API call
* unit selection
	* extend the UI with the feature of unit selection and preserving the selected unit
	* use the preserved selected unit in API call

# Version 0.4 "Multiple Locations"

## The Goal#
Introduce support for multiple locations. User can add, remove and change order of multiple locations

## Implementation scope
* extend [the model](TechnicalDesign.md#Model_v2) 
	* add required properties
	* extend unit tests (happy/unhappy path) covering JSON deserialisation
* location selector
	* extend the UI with the feature of editing (add/remove) the list of locations
	* extend the UI with the feature of reordering list of locations

#Version 0.5
TBD