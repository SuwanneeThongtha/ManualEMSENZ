$images = @{
    "fig_06_01_box_widget"          = "237a0c6c-df29-42f7-8e80-d0d841d302c9"
    "fig_06_02_max_min_defect"      = "23cf69b7-71e7-4ff3-88ea-25e334fc61b4"
    "fig_08_01_single_file"         = "eca8b85d-8176-40c2-93f5-d8702089f0ad"
    "fig_08_02_merged_multi_file"   = "3935ddeb-c941-430c-afce-b95c640c3f1f"
    "fig_09_01_dl1_default"         = "ad2b8d51-da40-4c89-9a00-78afa5816263"
    "fig_09_02_dl1_aligned"         = "9b6afb14-4512-4e26-be9b-441c85cf13db"
    "fig_09_03_all_dl_default"      = "82a92c08-59ac-45d7-ab27-d81343069b75"
    "fig_09_04_all_dl_aligned"      = "e2099c3a-0102-4920-a6b5-bc9a69f57755"
    "fig_09_05_project_merge"       = "e1d76c5a-285c-44cd-957b-3c38ec22bae8"
    "fig_09_06_align_by_distance"   = "5a82da8e-2bae-4439-9f06-2594252e3bc0"
    "fig_09_07_align_by_time"       = "6b1789ed-1192-4e43-bd68-5d9aae7fbbac"
    "fig_09_08_align_settings"      = "d688c28a-1a59-4261-bdbf-4dd79c4bd14c"
    "fig_11_01_note_sync"           = "85f75643-6336-42b3-8256-fb887852f9dc"
    "fig_13_01_ratio_calibration"   = "be0887de-ef2d-4f1f-9245-81370f5953bd"
    "fig_14_01_calc_formula"        = "f0fd55aa-d922-4eed-8dad-b39bfe069de4"
    "fig_15_01_no_filter"           = "9a7a9adb-8641-43b9-a4a8-68126cda59a3"
    "fig_15_02_moving_average"      = "031a4015-007f-420a-8b3e-694d0ab515cf"
    "fig_15_03_median_filter"       = "01d3f606-1c85-4491-add9-ba2e3c945b95"
    "fig_15_04_savitzky_golay"      = "d0fd1cc4-b74a-4123-8709-636886b53104"
    "fig_16_01_auto_amplitude"      = "96b5bc96-c54d-4659-bc62-d3f9643c3f64"
    "fig_19_01_multi_download"      = "0541864a-f418-438d-8d1f-d4b93775fb68"
}

$token = (gh auth token)
$outDir = "manual_assets\images"

foreach ($entry in $images.GetEnumerator()) {
    $name = $entry.Key
    $id = $entry.Value
    $url = "https://github.com/user-attachments/assets/$id"
    $outFile = Join-Path $outDir "$name.png"
    
    Write-Host "Downloading $name ..."
    try {
        $headers = @{ "Authorization" = "token $token"; "Accept" = "application/octet-stream" }
        Invoke-WebRequest -Uri $url -Headers $headers -OutFile $outFile -MaximumRedirection 10
        $size = (Get-Item $outFile).Length
        Write-Host "  -> OK ($size bytes)"
    } catch {
        Write-Host "  -> FAILED: $_"
    }
}

Write-Host "`nDone. Downloaded files:"
Get-ChildItem $outDir | Format-Table Name, Length
