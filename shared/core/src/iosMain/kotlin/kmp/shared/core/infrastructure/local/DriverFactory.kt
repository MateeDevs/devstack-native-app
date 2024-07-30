package kmp.shared.core.infrastructure.local

import com.squareup.sqldelight.db.SqlDriver
import com.squareup.sqldelight.drivers.native.NativeSqliteDriver
import kmp.Database

internal actual class DriverFactory {
    actual fun createDriver(dbName: String): SqlDriver =
        NativeSqliteDriver(Database.Schema, dbName)
}
