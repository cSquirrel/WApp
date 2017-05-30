
# Status
* API's url and access key are hardcoded but the should be moved away from to source code. API key should be kept in a file never commited to the repository 
* due to the nature of the app the model is close to API hence they contain code for creating them from JSON. Would the model be internal to the app I would extract this code to ModelBuilder to keep the model JSON agnostic
* ApplicationConfiguration instance is created in Interface Builder and injected into ViewController. This is good enough for this exercise. In long term there would be an entity responsible for creating and providing the configuration, i.e. initial screen downloading additional settings from server

More in the documentation below.


# Documentation
* [Roadmap](Documentation/Roadmap.md)
* [Technical Design](Documentation/TechnicalDesign.md)
* [UX Design](Documentation/UXDesign.md)
