package kmp.shared.infrastructure.local

import com.russhwolf.settings.Settings
import com.russhwolf.settings.get
import com.russhwolf.settings.set

internal interface AuthDao {

    fun saveToken(token: String)
    fun retrieveToken(): String?

    fun saveUserId(userId: String)
    fun retrieveUserId(): String?

    fun wipeData()
}

internal val AuthDao.isLoggedIn get() = retrieveToken() != null && retrieveUserId() != null

internal class AuthDaoImpl(private val settings: Settings) : AuthDao {
    override fun saveToken(token: String) {
        settings[TOKEN_KEY] = token
    }

    override fun retrieveToken(): String? = settings[TOKEN_KEY]

    override fun saveUserId(userId: String) {
        settings[USER_KEY] = userId
    }

    override fun retrieveUserId(): String? = settings[USER_KEY]

    override fun wipeData() {
        settings.remove(USER_KEY)
        settings.remove(TOKEN_KEY)
    }

    companion object {
        private const val TOKEN_KEY = "auth_token"
        private const val USER_KEY = "user_id"
    }
}
