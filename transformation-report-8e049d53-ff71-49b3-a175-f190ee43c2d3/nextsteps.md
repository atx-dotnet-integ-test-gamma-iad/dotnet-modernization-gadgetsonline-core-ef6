# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The `GadgetsOnline/GadgetsOnline.csproj` project produced no errors during the build process.

## Validation

### 1. Restore NuGet Packages

Before running the project, ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns that should be addressed.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is set to an older or unintended version, update it accordingly and re-run `dotnet build`.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not been broken during the migration:

```bash
dotnet test --configuration Release
```

Review any failing tests and trace them back to API changes or behavioral differences introduced by the new runtime.

### 5. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tooling to identify any usage of APIs that have been removed or changed between the legacy framework and the current target:

```bash
dotnet tool install -g dotnet-apicompat
```

Address any flagged API usages by replacing them with their current equivalents documented in the [.NET migration guides](https://learn.microsoft.com/en-us/dotnet/core/compatibility/).

### 6. Verify Runtime Behavior

Start the application locally and exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Specifically verify:
- Database connections and queries function correctly.
- Any file system paths that were previously Windows-specific are now using `Path.Combine` or equivalent cross-platform APIs.
- Authentication and session handling behave as expected.
- Any HTTP client or external service integrations respond correctly.

### 7. Review Configuration Files

Check that `web.config` or `app.config` settings have been properly migrated to `appsettings.json` and that environment-specific configuration is handled using the `IConfiguration` pattern. Legacy `web.config` transforms will not apply in cross-platform .NET.

### 8. Validate Static Assets and Middleware

If this is a web project, confirm that static file serving, routing, and middleware registered in `Program.cs` or `Startup.cs` are functioning correctly by navigating through the application's pages and endpoints manually.

### 9. Deployment

Once the above validation steps pass:

1. Publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

2. Verify the contents of the `publish` output directory to ensure all required files, assets, and configuration are present.
3. Deploy the published output to the target server or hosting environment and perform a final smoke test against the deployed instance.