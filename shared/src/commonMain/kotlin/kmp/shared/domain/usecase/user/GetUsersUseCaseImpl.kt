package kmp.shared.domain.usecase.user

import kmp.shared.base.usecase.UseCaseFlowNoParams
import kmp.shared.domain.model.User
import kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetUsersUseCase : UseCaseFlowNoParams<List<User>>

internal class GetUsersUseCaseImpl internal constructor(private val repository: UserRepository) :
    GetUsersUseCase {
    override suspend fun invoke(): Flow<List<User>> = repository.getUsers()
}
