package cz.matee.devstack.kmp.shared.infrastructure.local

import com.squareup.sqldelight.db.SqlDriver
import com.squareup.sqldelight.drivers.native.NativeSqliteDriver
import cz.matee.devstack.kmp.Database

internal actual class DriverFactory {
    actual fun createDriver(dbName: String): SqlDriver =
        NativeSqliteDriver(Database.Schema, dbName)
}