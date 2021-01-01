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

``
pom.xml
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
``
> here is some example of annotating a method to use specific profile !!! if active !!!
@Component
@Profile(value="dev")
class MyRunner2 implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {

        System.out.println("In development");
    }
}
This runner is executed when the dev profile is active.

@Component
@Profile(value="prod & !dev")
class MyRunner3 implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {

        System.out.println("In production");
    }
}
This bean is executed when the prod profile is active and the dev is not active.

@Component
@Profile(value={"dev & local"})
class MyRunner5 implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {

        System.out.println("In development and local");
    }
}
This bean is executed when both dev and local profiles are active.

@Component
@Profile(value={"dev", "prod"})
class MyRunner6 implements CommandLineRunner {

    @Value("${message}")
    private String message;

    @Override
    public void run(String... args) throws Exception {

        System.out.println("Message: " + message);
    }
}
This bean is executed for either dev or prod profiles (or both). What message is outputed depends on which profile was loaded last.





# Example OF using Bean

A simple PropertyPlaceholderConfigurer example

Declare a PropertyPlaceholderConfigurer bean in Spring’s application context file as follows:
```
<bean id="mailProperties"
    class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
 
    <property name="location" value="classpath:mail.properties" />
 
</bean>

```
That tells Spring to load the properties file named “mail.properties” in the classpath to resolve any placeholders ${…} found. An exception will be thrown if Spring could not find the specified properties file. The properties file has the following entries:

```
smtp.host=smtp.gmail.com
smtp.port=587
smtp.user=tom@gmail.com
smtp.pass=secret
```
And the following bean declaration uses some placeholders which will be resolved by Spring:
```
<bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
    <property name="host" value="${smtp.host}" />
    <property name="port" value="${smtp.port}" />
    <property name="username" value="${smtp.user}" />
    <property name="password" value="${smtp.pass}" />
</bean>
```
Spring will replace these placeholders by actual values of the corresponding entries in the properties file. An exception will be thrown if a placeholder could not be resolved, e.g there is no entry with the specified key.





# Some Terms

Bean: is an object, which is created, managed and destroyed in Spring Container. We can inject an object into the Spring Container through the metadata(either xml or annotation), which is called inversion of control.

Instantiate: First the spring container finds the bean’s definition from the XML file and instantiates the bean.

Populate properties: Using the dependency injection, spring populates all of the properties as specified in the bean definition.

Set Bean Name: If the bean implements BeanNameAware interface, spring passes the bean’s id to setBeanName() method.

Set Bean factory: If Bean implements BeanFactoryAware interface, spring passes the beanfactory to setBeanFactory() method.

Pre-Initialization: Also called post process of bean. If there are any bean BeanPostProcessors associated with the bean, Spring calls postProcesserBeforeInitialization() method.

Initialize beans: If the bean implements IntializingBean,its afterPropertySet() method is called. If the bean has init method declaration, the specified initialization method is called.

Post-Initialization: – If there are any BeanPostProcessors associated with the bean, their postProcessAfterInitialization() methods will be called.

Ready to use: Now the bean is ready to use by the application

Destroy: If the bean implements DisposableBean, it will call the destroy() method


> at the bottom line
Spring have the IoC container which carry the Bag of Bean ; creation maintain and deletion are the responsibilities of Spring Container. We can put the bean in to Spring by Wiring and Auto Wiring. Wiring mean we manually configure it into the XML file and "Auto Wiring" mean we put the annotations in the Java file then Spring automatically scan the root-context where java configuration file, make it and put into the bag of Spring.
