package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParamsImpl
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetUsersUseCase : UseCaseFlowNoParams<List<User>>

class GetUsersUseCaseImpl internal constructor(private val repository: UserRepository) :
    UseCaseFlowNoParamsImpl<List<User>>(), GetUsersUseCase {
    override suspend fun doWork(params: Unit): Flow<List<User>> = repository.getUsers()
}