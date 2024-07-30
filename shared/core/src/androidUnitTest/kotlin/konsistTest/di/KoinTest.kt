package konsistTest.di

import com.lemonappdev.konsist.api.KoModifier
import com.lemonappdev.konsist.api.Konsist
import com.lemonappdev.konsist.api.ext.list.modifierprovider.withoutModifier
import com.lemonappdev.konsist.api.ext.list.withNameEndingWith
import com.lemonappdev.konsist.api.ext.list.withPackage
import com.lemonappdev.konsist.api.ext.list.withParent
import com.lemonappdev.konsist.api.provider.KoFullyQualifiedNameProvider
import com.lemonappdev.konsist.api.verify.assertTrue
import org.junit.Test

internal class KoinTest {
    @Test
    fun `every 'ViewModel' has a declaration in Koin's module`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withoutModifier(KoModifier.ABSTRACT)
            .withNameEndingWith("ViewModel")
            .assertIsDefinedInKoinModule()
    }

    @Test
    fun `every 'Repository' has a declaration in Koin's module`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withPackage("..data..")
            .withParent { it.hasNameEndingWith("Repository") }
            .withoutModifier(KoModifier.ABSTRACT)
            .assertIsDefinedInKoinModule()
    }

    @Test
    fun `every 'Source' has a declaration in Koin's module`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withPackage("..infrastructure..")
            .withParent { it.hasNameEndingWith("Source") }
            .withoutModifier(KoModifier.ABSTRACT)
            .assertIsDefinedInKoinModule()
    }

    @Test
    fun `every 'Api' has a declaration in Koin's module`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withPackage("..infrastructure..")
            .withParent { it.hasNameEndingWith("Api") }
            .withoutModifier(KoModifier.ABSTRACT)
            .assertIsDefinedInKoinModule()
    }

    @Test
    fun `every 'UseCase' has a declaration in Koin's module`() {
        Konsist
            .scopeFromProject()
            .classes()
            .withPackage("..domain..")
            .withParent { it.hasNameEndingWith("UseCase") }
            .withoutModifier(KoModifier.ABSTRACT)
            .assertIsDefinedInKoinModule()
    }

    private fun <E : KoFullyQualifiedNameProvider> List<E>.assertIsDefinedInKoinModule() {
        val modules = getKoinModules()
        this.assertTrue { modules.any { file -> file.hasImportWithName(it.fullyQualifiedName) } }
    }

    private fun getKoinModules() = Konsist
        .scopeFromProject()
        .properties()
        .withNameEndingWith("Module", "module")
        .filter { it.text.contains("= module {") }
        .map { it.containingFile }
}
