kotlinDslPluginOptions {
    jvmTarget.set(JavaVersion.VERSION_17.toString())
}

plugins {
    `kotlin-dsl`
}

kotlin {
    jvmToolchain(17)
}

repositories {
    gradlePluginPortal()
    mavenCentral()
    google()
}
