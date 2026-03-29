# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm expected behavior is preserved.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that business logic has not been broken during transformation:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed Windows-Specific APIs

Even without build errors, runtime issues can arise from APIs that were available in .NET Framework but behave differently or are absent in cross-platform .NET. Specifically, review the code for usage of:

- `System.Web` namespaces (these are not available in cross-platform .NET)
- `HttpContext` usage outside of the standard ASP.NET Core request pipeline
- Windows Registry access (`Microsoft.Win32.Registry`)
- `System.Drawing` (requires additional native dependencies on non-Windows platforms)
- Any P/Invoke calls targeting Windows-only native libraries

### 7. Verify Configuration Migration

If the project previously used `Web.config` or `App.config`, confirm that settings have been migrated to `appsettings.json` and that the application reads them correctly using the `IConfiguration` abstraction.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can connect and perform queries as expected in the new environment.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy the published output to the target environment.