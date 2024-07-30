package konsistTest.android.compose

import com.lemonappdev.konsist.api.Konsist
import com.lemonappdev.konsist.api.ext.list.modifierprovider.withInternalModifier
import com.lemonappdev.konsist.api.ext.list.modifierprovider.withPublicOrDefaultModifier
import com.lemonappdev.konsist.api.ext.list.withAnnotation
import com.lemonappdev.konsist.api.ext.list.withType
import com.lemonappdev.konsist.api.verify.assertTrue
import org.junit.Test

internal class ComposeTest {
    @Test
    fun `every internal or public compose function has a modifier`() {
        Konsist
            .scopeFromProject()
            .functions()
            .let { fns ->
                fns.withPublicOrDefaultModifier() +
                    fns.withInternalModifier()
            }
            .withAnnotation { it.name == "Composable" }
            .filter { fn ->
                !fn.hasReturnValue &&
                    (fn.returnType?.text == "Unit" || fn.returnType?.text == null) &&
                    ignoredComposables.none { filtered -> fn.name.contains(filtered) }
            }
            .assertTrue { fn ->
                fn.parameters
                    .withType { it.name == "Modifier" }
                    .let { params ->
                        params.size == 1 &&
                            params.all { param -> param.hasDefaultValue() && param.name == "modifier" }
                    }
            }
    }

    private companion object {
        val ignoredComposables = listOf(
            "Route",
            "Preview",
            "Screen",
            "Navigation",
            "Dialog",
            "Event",
            "Effect",
            "BottomSheet",
            "Provider",
            "Override",
            "Theme",
        )
    }
}
