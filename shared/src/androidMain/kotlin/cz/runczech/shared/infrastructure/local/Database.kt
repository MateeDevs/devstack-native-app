package cz.runczech.shared.infrastructure.local

import android.content.Context
import com.squareup.sqldelight.android.AndroidSqliteDriver
import com.squareup.sqldelight.db.SqlDriver

//internal actual class DriverFactory(private val context: Context) {
//    actual fun createDriver(dbName: String): SqlDriver =
//        AndroidSqliteDriver(Database.Schema, context, dbName)
//}