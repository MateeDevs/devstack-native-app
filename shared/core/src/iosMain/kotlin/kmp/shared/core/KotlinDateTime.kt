package kmp.shared.core

import kotlinx.datetime.Instant
import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.TimeZone
import kotlinx.datetime.toInstant
import kotlinx.datetime.toKotlinInstant
import kotlinx.datetime.toLocalDateTime
import kotlinx.datetime.toNSDateComponents
import platform.Foundation.NSDate

// Force the companion object to be included in the framework. For example, upon adding the following code to Platform.kt in iosMain in a sample KMM project, the companion object was included in the headers:
fun Instant.Companion.dummy(): Nothing = TODO()

fun NSDate.toInstant() = this.toKotlinInstant()
fun NSDate.toLocalDate() = toInstant().toLocalDateTime(TimeZone.currentSystemDefault()).date
fun NSDate.toLocalDateTime() = toInstant().toLocalDateTime(TimeZone.currentSystemDefault())

fun LocalDate.toComponents() = toNSDateComponents()
fun LocalDateTime.toComponents() = toNSDateComponents()
fun LocalDateTime.toInstant() = toInstant(TimeZone.currentSystemDefault())
