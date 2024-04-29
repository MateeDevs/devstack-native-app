package konsistTest.infrastructure

import com.lemonappdev.konsist.api.Konsist
import com.lemonappdev.konsist.api.ext.list.print
import com.lemonappdev.konsist.api.ext.list.withName
import com.lemonappdev.konsist.api.ext.list.withNameContaining
import com.lemonappdev.konsist.api.ext.list.withPackage
import com.lemonappdev.konsist.api.ext.list.withoutReceiverType
import com.lemonappdev.konsist.api.verify.assertTrue
import kotlinx.serialization.Serializable
import org.junit.Test

internal class InfrastructureTest {
    @Test
    fun `all DTOs are internal or private`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withPackage("..infrastructure.dto..")
            .assertTrue { klass ->
                klass.hasInternalModifier || klass.hasPrivateModifier
            }
    }

    @Test
    fun `all classes in 'infrastructure' package are annotated with Serializable`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withPackage("..infrastructure.dto..")
            .assertTrue { klass ->
                klass.hasAnnotationOf(Serializable::class)
            }
    }

    @Test
    fun `all classes in 'infrastructure' have immutable properties`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withPackage("..infrastructure.dto..")
            .assertTrue { klass ->
                klass.properties()
                    .all { prop -> prop.hasValModifier }
            }
    }

    @Test
    fun `all 'toDomain()' extensions functions are either internal or private`() {
        Konsist
            .scopeFromProject()
            .functions()
            .withPackage("..infrastructure..", "..data..")
            .withName("toDomain")
            .print { it.fullyQualifiedName }
            .assertTrue { fn -> fn.hasInternalModifier || fn.hasPrivateModifier }
    }

    @Test
    fun `all 'toDomain()' function are in the 'infrastructure' package`() {
        Konsist
            .scopeFromProject()
            .functions()
            .filter { it.isTopLevel }
            .withoutReceiverType { it.name.contains("ViewObject") }
            .withNameContaining("toDomain")
            .assertTrue { it.resideInPackage("..infrastructure..") }
    }
}
