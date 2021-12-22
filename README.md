# Matee KMP DevStack

## About
This repo contains our template for multiplatform mobile project. Both Android and iOS implementations
are present with shared module containing all common business logic organized in Clean architecture.  
The project is simple app built just for demonstration.  
  
User flows: 
 - Auth: login and registration screen
 - Users: paginated list of users with user detail 
 - Profile: detailed info about user with demonstration of geolocation API
 - Recipes/Counter: Platform specific playground

## Architecture
Clean (common modules) + MVVM (platform-specific modules) architecture is used for its testability and ease of *modularization*.
Code is divided into several layers:
 - infrastructure (`Source`)
 - data (`Repository`)
 - domain (`UseCase`)

### Shared
Shared module handles networking, persistence and contains UseCases which bridge platform specific code
with common code. 
Module structure is organized with Clean architecture in mind to several layers of abstraction where everything
is marked as `internal` to prevent confusion between domain and data layer.
  
> The whole project relies heavily on dependency injection 

### Android 
Android code is separated into several feature-modules with `android:app` module providing navigation 
root and `android:shared` module containing shared android code like common components or values. 
Following standards the Android-specific modules use MVVM architecture where ViewModels use UseCases as 
gateway to shared *model* layer. 

### iOS
- More info in the [iOS readme](/ios)

## Technologies

### Shared

#### DI - Koin
Koin supports Kotlin Multiplatform and it's pure Kotlin project. Each module
(including all andorid feature modules) has it's own Koin module. All modules (including common module)
are put together inside platform specific code where Koin is initialized. 

#### Persistance - SqlDelight, Multiplatform Settings
In a same way that native UI is more capable than cross-platform frameworks, SQL is the most capable tool
for relation database. SqlDelight provides tools for generating Kotlin facade for SQL code.

Using relation database for simple key-value pairs is an overkill so [Multiplatform Settings](https://github.com/russhwolf/multiplatform-settings) 
library was used to handle that. It provides common API to access default native tools for storing simple data. 

#### Networking - Ktor
Accessing network is usually the most used IO operation for mobile apps so Ktor was used for it's simple
and extensible API and because it's multiplatform capable with different engines for each platform. 

### Android

#### UI - Jetpack Compose
Jetpack Compose is still in Beta but it's the future of Android UI and new projects should consider using it.  
While it is possible to create hybrid app with both the *old* View system and Compose, we've 
chosen to go all in on Compose.

### iOS
- More info in the [iOS readme](/ios)
