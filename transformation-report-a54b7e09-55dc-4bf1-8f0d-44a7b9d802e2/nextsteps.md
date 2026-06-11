# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, as some may indicate compatibility concerns that did not manifest as hard errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Avoid `net6.0` or `net7.0` as these are out of support. If the project is a web application, ensure the framework moniker is `net8.0` and that `Microsoft.AspNetCore` packages are not being manually referenced, as they are included in the framework.

### 4. Check for Windows-Specific APIs

Even without build errors, the project may contain Windows-specific API calls (e.g., registry access, `System.Drawing`, COM interop) that will fail at runtime on non-Windows platforms. Use the .NET compatibility analyzer to surface these:

```bash
dotnet build /p:PlatformTarget=AnyCPU
```

Review any `CA1416` platform compatibility warnings in the output.

### 5. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the core functionality of the application and confirm that pages load, data is retrieved, and no unhandled exceptions occur.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` (or equivalent configuration) are correct for the target environment and that Entity Framework migrations (if applicable) are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Review `web.config` vs `appsettings.json`

If the original project used `web.config` for configuration, verify that all relevant settings have been migrated to `appsettings.json` or `appsettings.{Environment}.json`. The `web.config` file is not used for application configuration in cross-platform .NET.

### 9. Publish the Application

Once the above steps are validated, produce a publish artifact:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present before deploying to the target environment.