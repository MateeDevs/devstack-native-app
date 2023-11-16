package extensions

import com.android.build.api.dsl.VariantDimension

fun VariantDimension.stringResource(key: String, value: String) {
    resValue("string", key, value)
}
