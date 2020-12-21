# Hello World Rest API

it's all about externalization and profiles to expose the app's configurations and api without changing any parameters inside the code, that's why using pom.xml and profiles and properties >>> such as npm and ecosystem.

## Externalization
the property of externalizing a app configurations out, then >>> put it in application.properties file such as ecosystem file 
instead of hardcoding password, username, ip adresses and configuration in java classes, it may changed so we need to externalize it out 
- the place in :main.java.resources.application.properties , and may devided into multiple files 
- the standrad place of the property file is under the resources dir, but can be olaced at any place 
#Note: 
- in sping u must specify where is configuration/properties file, but in spring boot u shouldn't do it, will be included automaticaly .

## Profile
A profile is a set of configuration settings. Spring Boot allows to define profile specific property files in the form of application-{profile}.properties. It automatically loads the properties in an application.properties file for all profiles, and the ones in profile-specific property files only for the specified profile. The keys in the profile-specific property override the ones in the master property file.
The @Profile annotation indicates that a component is eligible for registration when the specified profile or profiles are active. The default profile is called default; all the beans that do not have a profile set belong to this profile.

Spring Boot profiles example
In the following application, we have three profiles (local, dev, prod) and two profile-specific property files. We use the spring.profiles.active to set active profiles and SpringApplicationBuilder's profiles method to add new active profiles.

pom.xml
``
src
├── main
│   ├── java
│   │   └── com
│   │       └── zetcode
│   │           └── Application.java
│   └── resources
│       ├── application-dev.properties
│       ├── application-prod.properties
│       └── application.properties
└── test
    └── java
This is the project structure.
