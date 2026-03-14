# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these may indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the original legacy project.

### 5. Execute Existing Tests

If the solution contains any test projects, run them to validate that existing logic has not been broken during the transformation:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 6. Check for Removed or Changed APIs

Review the code for usage of any APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types, which may have different namespaces or behaviors
- Configuration APIs (`ConfigurationManager` vs. `Microsoft.Extensions.Configuration`)
- Any use of Windows-specific APIs such as the registry or certain `System.Drawing` features

### 7. Review Static Files and Configuration

Ensure that files such as `appsettings.json`, `Program.cs`, and `Startup.cs` (or the combined `Program.cs` in minimal hosting model) are correctly configured for the new runtime. Verify that connection strings and application settings have been properly migrated from `Web.config` to `appsettings.json`.

### 8. Test on Target Platform

If the goal of the migration was to support a non-Windows platform (Linux or macOS), run and test the application on that platform to confirm there are no platform-specific runtime issues.

### 9. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present, then deploy the contents to the target environment.