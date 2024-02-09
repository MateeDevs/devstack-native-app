package kmp.shared.data.store

import kmp.shared.base.ErrorResultException
import kmp.shared.base.Result
import kmp.shared.data.source.UserLocalSource
import kmp.shared.data.source.UserRemoteSource
import kmp.shared.data.source.UserUpdateRequest
import kmp.shared.domain.model.User
import kmp.shared.extension.asDomain
import kmp.shared.infrastructure.local.UserEntity
import kmp.shared.infrastructure.model.UserDto
import org.mobilenativefoundation.store.store5.Converter
import org.mobilenativefoundation.store.store5.Fetcher
import org.mobilenativefoundation.store.store5.FetcherResult
import org.mobilenativefoundation.store.store5.MutableStore
import org.mobilenativefoundation.store.store5.MutableStoreBuilder
import org.mobilenativefoundation.store.store5.SourceOfTruth
import org.mobilenativefoundation.store.store5.Updater
import org.mobilenativefoundation.store.store5.UpdaterResult

typealias UserStore = MutableStore<String, User>

internal fun createUserStore(
    remote: UserRemoteSource,
    local: UserLocalSource,
): MutableStore<String, User> {
    val fetcher = Fetcher.ofResult<String, UserDto> { id ->
        when (val res = remote.getUser(id)) {
            is Result.Success -> FetcherResult.Data(res.data)
            is Result.Error -> FetcherResult.Error.Custom(res.error)
        }
    }

    val sourceOfTruth = SourceOfTruth.of<String, UserEntity, User>(
        nonFlowReader = { id -> local.getUser(id)?.asDomain },
        writer = { _, entity -> local.updateOrCreate(entity) },
    )

    return MutableStoreBuilder
        .from(
            fetcher = fetcher,
            sourceOfTruth = sourceOfTruth,
            converter = UserConverter,
        )
        .build(
            updater = Updater.by(
                post = { id, value ->
                    val request = with(value) {
                        UserUpdateRequest(bio, firstName, lastName, null, phone)
                    }
                    when (val res = remote.updateUser(id, request)) {
                        is Result.Success -> UpdaterResult.Success.Typed(res.data.asDomain)
                        is Result.Error -> {
                            UpdaterResult.Error.Exception(ErrorResultException(res.error))
                        }
                    }
                },
            ),
        )
}

internal object UserConverter : Converter<UserDto, UserEntity, User> {
    override fun fromNetworkToLocal(network: UserDto): UserEntity = with(network) {
        UserEntity(id, email, firstName, lastName, phone, bio)
    }

    override fun fromOutputToLocal(output: User): UserEntity = with(output) {
        UserEntity(id, email, firstName, lastName, phone, bio)
    }
}
