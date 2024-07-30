package konsistTest.common

import com.lemonappdev.konsist.api.KoModifier
import com.lemonappdev.konsist.api.Konsist
import com.lemonappdev.konsist.api.verify.assertFalse
import com.lemonappdev.konsist.api.verify.assertTrue
import org.junit.Ignore
import org.junit.Test

internal class GeneralTest {
    @Test
    fun `companion objects are last declarations in the class`() {
        Konsist
            .scopeFromProject()
            .classes()
            .assertTrue {
                val companionObjects = it.objects(
                    includeNested = false,
                ).filter { obj ->
                    obj.hasModifier(KoModifier.COMPANION)
                }

                if (companionObjects.isEmpty()) {
                    return@assertTrue true
                }

                it.declarations(
                    includeNested = false,
                ).takeLast(companionObjects.size) == companionObjects
            }
    }

    @Test
    fun `no empty files allowed`() {
        Konsist
            .scopeFromProject()
            .files
            .assertFalse { it.text.isEmpty() }
    }

    @Test
    fun `package name must match file path`() {
        Konsist
            .scopeFromProject()
            .packages
            .assertTrue { it.hasMatchingPath }
    }

    @Test
    fun `no wildcard imports allowed`() {
        Konsist
            .scopeFromProject()
            .imports
            .assertFalse { it.isWildcard }
    }

    @Ignore("DevStack currently uses android log...")
    @Test
    fun `no class should use Android util logging`() {
        Konsist
            .scopeFromProject()
            .files
            .assertFalse { it.hasImport { import -> import.name == "android.util.Log" } }
    }
}
