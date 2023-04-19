kotlinDslPluginOptions {
    jvmTarget.set(JavaVersion.VERSION_17.toString())
}

plugins {
    `kotlin-dsl`
}

repositories {
    gradlePluginPortal()
    mavenCentral()
    google()
}
