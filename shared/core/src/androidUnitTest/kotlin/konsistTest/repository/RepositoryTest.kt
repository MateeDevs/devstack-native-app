package konsistTest.repository

import com.lemonappdev.konsist.api.Konsist
import com.lemonappdev.konsist.api.ext.list.withNameContaining
import com.lemonappdev.konsist.api.verify.assertTrue
import org.junit.Test

@Suppress("konsist.all repositories inherit from a corresponding interface")
class RepositoryTest {
    @Test
    fun `all repositories inherit from a corresponding interface`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withNameContaining("Repository")
            .assertTrue { klass ->
                klass.numParents == 1 &&
                    klass.hasAllParents { parent ->
                        parent.fullyQualifiedName.contains("domain.repository")
                    }
            }
    }

    @Test
    fun `'Repository' implementation classes should reside in 'data' and 'repository' package`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withNameContaining("Repository")
            .filter { it.numParents == 1 }
            .assertTrue { it.resideInPackage("..data.repository..") }
    }

    @Test
    fun `'Repository' interfaces should reside in 'domain' and 'repository' package`() {
        Konsist
            .scopeFromProject()
            .interfaces()
            .withNameContaining("Repository")
            .assertTrue { it.resideInPackage("..domain.repository..") }
    }
}
