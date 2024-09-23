package dev.icerock.moko.resources.utils // must be same as in moko-resources to override method

import platform.Foundation.NSBundle
import platform.Foundation.NSDirectoryEnumerator
import platform.Foundation.NSFileManager
import platform.Foundation.NSURL
import platform.Foundation.pathExtension

/**
 * Workaround by MAX-POLKOVNIK from https://github.com/icerockdev/moko-resources/issues/747#issuecomment-2330854244
 * Remove when https://github.com/icerockdev/moko-resources/issues/747 is resolved
 */

var nsBundle: NSBundle = NSBundle.mainBundle // <-- this is where we should looking for resources, by default mainBundle

fun NSBundle.Companion.loadableBundle(identifier: String): NSBundle {
    val bundlePath: String = nsBundle.bundlePath // <-- path where we should search for bundle with resources
    val enumerator: NSDirectoryEnumerator = requireNotNull(NSFileManager.defaultManager.enumeratorAtPath(bundlePath))
    while (true) {
        val relativePath: String = enumerator.nextObject() as? String ?: break
        val url = NSURL(fileURLWithPath = relativePath)
        if (url.pathExtension == "bundle") {
            val fullPath = "$bundlePath/$relativePath"
            val foundedBundle: NSBundle? = NSBundle.bundleWithPath(fullPath)
            val loadedIdentifier: String? = foundedBundle?.bundleIdentifier

            if (isBundleSearchLogEnabled) {
                println("moko-resources auto-load bundle with identifier $loadedIdentifier at path $fullPath")
            }

            if (foundedBundle?.bundleIdentifier == identifier) return foundedBundle
        }
    }

    throw IllegalArgumentException("bundle with identifier $identifier not found")
}

var isBundleSearchLogEnabled = false
