@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    `kotlin-dsl`
    `java-gradle-plugin`
    alias(libs.plugins.ktlint)
}

group = "cz.matee.devstack.buildlogic"

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

kotlin {
    kotlinDslPluginOptions {
        jvmTarget.set(JavaVersion.VERSION_17.toString())
    }
}

dependencies {
    implementation(files(libs.javaClass.superclass.protectionDomain.codeSource.location))
    compileOnly(libs.androidTools.gradle)
    compileOnly(libs.kotlin.gradlePlugin)
    compileOnly(libs.kotlin.gradlePlugin)
}

gradlePlugin {
    plugins {
        plugin(
            dependency = libs.plugins.devstack.android.application.compose,
            pluginName = "AndroidApplicationComposeConventionPlugin",
        )
    }
    plugins {
        plugin(
            dependency = libs.plugins.devstack.android.application.core,
            pluginName = "AndroidApplicationConventionPlugin",
        )
    }
    plugins {
        plugin(
            dependency = libs.plugins.devstack.android.library.compose,
            pluginName = "AndroidLibraryComposeConventionPlugin",
        )
    }
    plugins {
        plugin(
            dependency = libs.plugins.devstack.android.library.core,
            pluginName = "AndroidLibraryConventionPlugin",
        )
    }
    plugins {
        plugin(
            dependency = libs.plugins.devstack.kmm.library,
            pluginName = "KmmLibraryConventionPlugin",
        )
    }
}

fun NamedDomainObjectContainer<PluginDeclaration>.plugin(
    dependency: Provider<out PluginDependency>,
    pluginName: String,
) {
    val pluginId = dependency.get().pluginId
    register(pluginId) {
        id = pluginId
        implementationClass = "cz.matee.devstack.plugin.$pluginName"
    }
}

//        register("androidApplication") {
//            id = "nowinandroid.android.application"
//            implementationClass = "AndroidApplicationConventionPlugin"
//        }
//        register("androidApplicationJacoco") {
//            id = "nowinandroid.android.application.jacoco"
//            implementationClass = "AndroidApplicationJacocoConventionPlugin"
//        }
//        register("androidLibraryCompose") {
//            id = "nowinandroid.android.library.compose"
//            implementationClass = "AndroidLibraryComposeConventionPlugin"
//        }
//        register("androidLibrary") {
//            id = "nowinandroid.android.library"
//            implementationClass = "AndroidLibraryConventionPlugin"
//        }
//        register("androidFeature") {
//            id = "nowinandroid.android.feature"
//            implementationClass = "AndroidFeatureConventionPlugin"
//        }
//        register("androidLibraryJacoco") {
//            id = "nowinandroid.android.library.jacoco"
//            implementationClass = "AndroidLibraryJacocoConventionPlugin"
//        }
//        register("androidTest") {
//            id = "nowinandroid.android.test"
//            implementationClass = "AndroidTestConventionPlugin"
//        }
//        register("androidHilt") {
//            id = "nowinandroid.android.hilt"
//            implementationClass = "AndroidHiltConventionPlugin"
//        }
//        register("androidRoom") {
//            id = "nowinandroid.android.room"
//            implementationClass = "AndroidRoomConventionPlugin"
//        }
//        register("androidFirebase") {
//            id = "nowinandroid.android.application.firebase"
//            implementationClass = "AndroidApplicationFirebaseConventionPlugin"
//        }
//        register("androidFlavors") {
//            id = "nowinandroid.android.application.flavors"
//            implementationClass = "AndroidApplicationFlavorsConventionPlugin"
//        }
//    }
// }
