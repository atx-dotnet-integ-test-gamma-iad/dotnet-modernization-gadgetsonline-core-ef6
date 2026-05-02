# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older or end-of-life version (e.g., `netcoreapp3.1` or `net5.0`), update it accordingly:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate correctness:

```bash
dotnet test
```

Review any failing tests and address logic or compatibility issues they may reveal.

### 6. Review Removed or Replaced APIs

Check the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed behavior or limited support in cross-platform .NET. Common areas to review include:

- `System.Web` references or types (these are not available in cross-platform .NET)
- `HttpContext` and related ASP.NET pipeline components
- Windows-specific APIs such as the registry, WCF, or Windows Communication Foundation
- Entity Framework version compatibility (ensure EF Core is being used rather than EF 6 if applicable)

### 7. Verify Static Assets and Configuration

Confirm that configuration files have been migrated correctly:

- `Web.config` settings should be represented in `appsettings.json` or `appsettings.{Environment}.json`
- Connection strings should be present and valid in the new configuration format
- Any `<appSettings>` or `<connectionStrings>` entries from the legacy config should be accounted for

### 8. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy the output to the target environment.