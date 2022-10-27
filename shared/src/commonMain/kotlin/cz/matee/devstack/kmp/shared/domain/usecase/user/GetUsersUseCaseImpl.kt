package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetUsersUseCase : UseCaseFlowNoParams<List<User>>

class GetUsersUseCaseImpl internal constructor(private val repository: UserRepository) :
    GetUsersUseCase {
    override suspend fun invoke(): Flow<List<User>> = repository.getUsers()
}