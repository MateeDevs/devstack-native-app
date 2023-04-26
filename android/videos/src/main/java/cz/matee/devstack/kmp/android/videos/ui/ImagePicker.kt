package cz.matee.devstack.kmp.android.videos.ui

import android.net.Uri
import androidx.activity.compose.ManagedActivityResultLauncher
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.platform.LocalContext

/**
 * @param onGalleryResult returns the URI of the picked video from gallery
 */
@Composable
fun rememberVideoPickerState(
    onGalleryResult: (Uri?) -> Unit,
): VideoPickerState {
    val context = LocalContext.current
    val galleryVideoPicker =
        rememberLauncherForActivityResult(
            ActivityResultContracts.PickVisualMedia(),
            onGalleryResult,
        )
    return remember(
        galleryVideoPicker,
        context,
    ) {
        VideoPickerState(
            galleryPhotoPicker = galleryVideoPicker,
        )
    }
}

class VideoPickerState internal constructor(
    private val galleryPhotoPicker: ManagedActivityResultLauncher<PickVisualMediaRequest, Uri?>,
) {
    fun launchGalleryPicker() {
        galleryPhotoPicker.launch(
            PickVisualMediaRequest(
                ActivityResultContracts.PickVisualMedia.VideoOnly,
            ),
        )
    }
}
