# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution. The `GadgetsOnline` project compiled without issues under the new cross-platform .NET target.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages that may need to be updated.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate areas of concern such as obsolete APIs or nullable reference mismatches.

### 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0` or `net6.0`). Ensure this aligns with your intended deployment environment.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences between the legacy .NET Framework and the new .NET runtime.

### 5. Verify Runtime Behavior

Launch the application locally and exercise the primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to the following areas that commonly differ between .NET Framework and cross-platform .NET:

- **Configuration**: Verify that `System.Configuration` usages have been replaced with `Microsoft.Extensions.Configuration` where applicable.
- **HTTP and Networking**: Confirm that any `HttpClient` or networking code behaves as expected.
- **File Paths**: Ensure file path handling uses `Path.Combine` and does not rely on Windows-specific path separators.
- **Database Connectivity**: If Entity Framework is used, confirm the correct provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is referenced and migrations run successfully.
- **Authentication/Authorization**: If ASP.NET membership or legacy auth providers were used, verify they have been replaced with compatible middleware.

### 6. Check for Removed or Unsupported APIs

Run the .NET Upgrade Compatibility Analyzer or review the [.NET API compatibility documentation](https://learn.microsoft.com/en-us/dotnet/core/compatibility/) to identify any APIs that exist in the codebase but are no longer supported or have changed behavior in cross-platform .NET.

```bash
dotnet add package Microsoft.DotNet.ApiCompat
```

### 7. Test on Target Platforms

If cross-platform support is a goal, run and validate the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific issues that would not appear in a Windows-only build.

### 8. Review Warnings as Errors

If the project has `<TreatWarningsAsErrors>` set, review all warnings surfaced during the build step and resolve them before proceeding to deployment.

## Deployment

Once all validation steps have passed:

1. Publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

2. Verify the contents of the `publish` output directory to ensure all required assets, configuration files, and dependencies are present.

3. Deploy the published output to the target environment and perform a final smoke test against the live configuration.