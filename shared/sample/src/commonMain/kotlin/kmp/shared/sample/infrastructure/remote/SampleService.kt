package kmp.shared.sample.infrastructure.remote

import io.ktor.client.HttpClient
import kmp.shared.base.Result
import kmp.shared.sample.infrastructure.model.SampleTextDto

internal class SampleService(private val client: HttpClient) {

    suspend fun getSampleText(body: Any): Result<SampleTextDto> =
        Result.Success(SampleTextDto(value = "This is sample text"))
    // TODO: Use real implementation below
//        runCatchingCommonNetworkExceptions {
//            client.post(SAMPLE_PATH) {
//                setBody(body)
//            }.body()
//        }

    private companion object {
        const val ROOT_PATH = "/api"
        const val SAMPLE_PATH = "$ROOT_PATH/sample"
    }
}
