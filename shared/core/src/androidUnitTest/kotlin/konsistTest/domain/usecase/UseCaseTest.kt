package konsistTest.domain.usecase

import com.lemonappdev.konsist.api.Konsist
import com.lemonappdev.konsist.api.ext.list.properties
import com.lemonappdev.konsist.api.ext.list.withName
import com.lemonappdev.konsist.api.ext.list.withParameters
import com.lemonappdev.konsist.api.ext.list.withParent
import com.lemonappdev.konsist.api.verify.assertTrue
import org.junit.Ignore
import org.junit.Test

internal class UseCaseTest {

    @Test
    fun `implementations of use cases are internal`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withParent { parent ->
                parent.hasNameContaining("UseCase")
            }
            .assertTrue { klass -> klass.hasInternalModifier }
    }

    @Test
    fun `interfaces extending 'UseCase' should have 'UseCase' suffix`() {
        Konsist
            .scopeFromProject()
            .interfaces()
            .withParent { it.name.isUseCase() }
            .assertTrue { it.name.endsWith("UseCase") }
    }

    @Test
    fun `interfaces extending 'UseCase' reside in the 'domain' and 'usecase' package`() {
        Konsist
            .scopeFromProject()
            .interfaces()
            .withParent { it.name.isUseCase() }
            .assertTrue { it.resideInPackage("..domain..usecase..") }
    }

    @Test
    fun `classes extending 'UseCase' that have their own functions must be private`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withParent { it.hasNameContaining("UseCase") }
            .assertTrue { klass ->
                klass.functions(includeNested = false, includeLocal = false)
                    // ignore our doWork function
                    .filterNot { fn -> fn.hasOverrideModifier && fn.hasSuspendModifier && fn.name == "invoke" }
                    .all { fn -> fn.hasPrivateModifier }
            }
    }

    @Test
    fun `classes extending 'UseCase' must have all properties private`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withParent { it.hasNameContaining("UseCase") }
            .properties(includeNested = false, includeLocal = false)
            .assertTrue { fn ->
                fn.hasPrivateModifier
            }
    }

    @Test
    @Ignore("Once the project is prepared for this, enable it!")
    fun `interfaces extending 'UseCase' with params should have 'Params' data class that is used as param`() {
        Konsist
            .scopeFromProject()
            .interfaces()
            .withParent { parent -> parent.name.isUseCaseWithParams() }
            .assertTrue { useCaseInterface ->
                val paramDateClass = useCaseInterface
                    .classes()
                    .first { paramsDeclaration -> paramsDeclaration.name == "Params" }

                val implementation = Konsist
                    .scopeFromFile(useCaseInterface.projectPath)
                    .classes()
                    .withParent { parent -> parent.name == useCaseInterface.name }
                    .first()

                val implementationHasParams = implementation
                    .functions()
                    .withName("doWork")
                    .withParameters { params ->
                        val param = params.first()
                        param.type.fullyQualifiedName == paramDateClass.fullyQualifiedName
                    }.size == 1

                implementationHasParams
            }
    }

    private fun String.isUseCase(): Boolean {
        return this in (useCasesNoParams + useCasesWithParams)
    }

    private fun String.isUseCaseWithParams(): Boolean {
        return this in useCasesWithParams
    }

    private companion object {
        val useCasesWithParams = listOf(
            "UseCase",
            "UseCaseResult",
            "UseCaseFlow",
            "UseCaseFlowResult",
        )

        val useCasesNoParams = listOf(
            "UseCaseNoParams",
            "UseCaseResultNoParams",
            "UseCaseFlowNoParams",
            "UseCaseFlowResultNoParams",
        )
    }
}
