package cz.matee.devstack.kmp.shared.infrastructure.local

import com.squareup.sqldelight.db.SqlDriver
import cz.matee.devstack.kmp.Database

expect class DriverFactory {
    fun createDriver(dbName: String): SqlDriver
}

fun createDatabase(driverFactory: DriverFactory): Database =
    Database(driverFactory.createDriver("kmp.db"))