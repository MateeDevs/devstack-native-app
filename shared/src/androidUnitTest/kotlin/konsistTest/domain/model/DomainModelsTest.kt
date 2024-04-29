package konsistTest.domain.model

import com.lemonappdev.konsist.api.KoModifier
import com.lemonappdev.konsist.api.Konsist
import com.lemonappdev.konsist.api.ext.list.modifierprovider.withModifier
import com.lemonappdev.konsist.api.ext.list.withPackage
import com.lemonappdev.konsist.api.verify.assertTrue
import org.junit.Test

internal class DomainModelsTest {

    @Test
    fun `all domain model data classes have a primary constructor with all properties immutable`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withPackage("..domain.model")
            .withModifier(KoModifier.DATA)
            .assertTrue { klass ->
                klass.primaryConstructor?.let { constructor ->
                    constructor.hasAllParameters { value -> value.hasValModifier }
                } ?: false
            }
    }
}
