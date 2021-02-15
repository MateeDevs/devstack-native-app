package cz.matee.devstack.kmp.shared.infrastructure.local

import com.russhwolf.settings.Settings
import com.russhwolf.settings.get
import com.russhwolf.settings.set

interface AuthDao {

    fun saveToken(token: String)
    fun retrieveToken(): String?
}

internal class AuthDaoImpl(private val settings: Settings) : AuthDao {
    companion object {
        private const val TOKEN_KEY = "auth_token"
    }

    override fun saveToken(token: String) {
        settings[TOKEN_KEY] = token
    }

    override fun retrieveToken(): String? = settings[TOKEN_KEY]

}