# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Ensure no legacy `<TargetFrameworkVersion>` elements remain from the original .NET Framework project.

### 4. Check for Removed or Incompatible APIs

Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.PlatformAbstractions` tooling to scan for any API usage that may have been removed in cross-platform .NET:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to:
- `System.Web` references, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry or WCF server-side components
- Any third-party packages that may still target .NET Framework only

### 5. Run Unit Tests

If a test project exists in the solution, execute the tests to validate runtime behavior:

```bash
dotnet test --configuration Release
```

Address any test failures before proceeding to deployment.

### 6. Verify Static Assets and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that connection strings, application settings, and environment-specific values have been migrated correctly.
- Check that static files, views, and other content files are included in the project and accessible at runtime.

### 7. Run the Application Locally

Start the application locally to perform a manual smoke test:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core workflows to confirm that functionality is intact.

### 8. Deployment

Once the above steps are validated:

1. Publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

2. Copy the contents of the `./publish` directory to your target server or hosting environment.
3. Ensure the target environment has the correct .NET runtime version installed. You can verify this with:

```bash
dotnet --list-runtimes
```

4. Configure your web server (IIS, Nginx, or Apache) to point to the published output and confirm the application starts correctly under the production configuration.