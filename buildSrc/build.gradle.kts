val kotlinVersion = "1.8.0"
val androidGradleVersion = "7.2.0"

kotlinDslPluginOptions {
    jvmTarget.set(JavaVersion.VERSION_1_8.toString())
}

plugins {
    `kotlin-dsl`
}

repositories {
    gradlePluginPortal()
    mavenCentral()
    google()
}

dependencies {
    implementation("com.android.tools.build:gradle:$androidGradleVersion")
    implementation("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
}
