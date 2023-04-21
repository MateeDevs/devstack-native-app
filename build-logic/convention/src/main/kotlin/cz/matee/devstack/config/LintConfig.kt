package cz.matee.devstack.config

import com.android.build.api.dsl.CommonExtension
import java.io.File

internal fun CommonExtension<*, *, *, *>.configureLint() {
    lint {
        lintConfig = File("lint.xml")
    }
}
