package cz.matee.devstack.kmp.shared.base

fun <T : Any> Result<T>.getOrNull(): T? =
    (this as? Result.Success)?.data
