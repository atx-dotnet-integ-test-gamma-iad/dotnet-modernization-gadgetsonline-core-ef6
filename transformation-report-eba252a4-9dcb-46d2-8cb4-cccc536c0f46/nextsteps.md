# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-only framework such as `net48`, the migration to cross-platform .NET is not yet complete.

### 4. Check for Windows-Specific APIs

Search the codebase for any usage of APIs that are not supported on all platforms. Common areas to check include:

- `System.Web` namespace references, which are not available in cross-platform .NET
- Windows Registry access via `Microsoft.Win32`
- `HttpContext` usage patterns that relied on `System.Web.HttpContext` rather than `Microsoft.AspNetCore.Http.HttpContext`

The .NET Compatibility Analyzer can assist with this. Ensure the following is present in the project file to enable platform compatibility warnings:

```xml
<EnableNETAnalyzers>true</EnableNETAnalyzers>
```

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality such as page rendering, routing, and data access behaves as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has not regressed:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 7. Verify Database Connectivity

If the application uses Entity Framework or another data access layer, confirm that:

- The connection string in `appsettings.json` is correctly configured
- Any pending migrations are applied:

```bash
dotnet ef database update
```

- Data reads and writes function correctly when running the application locally

### 8. Deployment

Once the above validation steps pass, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target hosting environment. Ensure the target server has the appropriate .NET runtime installed, which can be verified with:

```bash
dotnet --info
```

Confirm the runtime version matches the target framework of the application.